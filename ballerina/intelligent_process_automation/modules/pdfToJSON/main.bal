import ballerinax/openai.chat;

import xlibb/pdfbox;

chat:Client chatClient = check new ({
    auth: {
        token: openAIApiKey
    },
    timeout: 120
});

# This function converts a PDF file to a JSON object based on the provided schema.
#
# + path - The path to the PDF file
# + jsonSchema - The schema for the JSON object
# + return - Returns the JSON object or an error
public function convertPDFToJSON(string path, string jsonSchema) returns json|error {
    string[] base64Images = check convertPDFToImages(path);
    json|error jsonData = check convertImagesToJson(base64Images, jsonSchema);
    return jsonData;
}

function convertPDFToImages(string path) returns string[]|error {
    string[] base64Images = check pdfbox:toImagesFromFile(path);
    return base64Images;
}

function convertImagesToJson(string[] base64Images, string jsonSchema) returns json|error {
    chat:ChatCompletionRequestMessage systemMessage = getSystemMessage();
    chat:ChatCompletionRequestMessage userMessage = getUserMessage(base64Images, jsonSchema);

    string jsonString = check processOpenAIApi(systemMessage, userMessage);
    return jsonString.fromJsonString();
}

function getSystemMessage() returns chat:ChatCompletionRequestMessage {
    return {
        role: "system",
        content: systemPrompt
    };
}

function getUserMessage(string[] base64Images, string schema) returns chat:ChatCompletionRequestMessage {
    chat:ChatCompletionRequestMessageContentPartImage[] imgContent = [];

    foreach string img in base64Images {
        imgContent.push({"type": "image_url", image_url: {url: "data:image/png;base64," + img}});
    }

    return {
        role: "user",
        content: [
            {
                "type": "text",
                text: string `${userPrompt}${schema}`
            },
            ...imgContent
        ]
    };
}

function processOpenAIApi(chat:ChatCompletionRequestMessage systemMessage,
        chat:ChatCompletionRequestMessage userMessage) returns string|error {

    chat:CreateChatCompletionResponse openAIResponse = check chatClient->/chat/completions.post({
        model: "gpt-4o",
        messages: [systemMessage, userMessage]
    });

    string? jsonString = openAIResponse.choices[0].message.content;

    if jsonString is string {
        return jsonString;
    }
    return error("Failed to process open ai api response.");
}
