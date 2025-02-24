# The API key for accessing OpenAI services.
public configurable string openAIApiKey = ?;

# The system prompt for the intelligent assistant.
public string systemPrompt = string `You are an intelligent assistant tasked with analyzing  
                text extracted from images of scanned forms using OCR technology. Your goal  
                is to understand the content of the form and provide insights as json object  
                (as per the provided schema) based on the extracted text. 
                [Important] You will not assume any value by your self and 
                always double check the form carefully and confirm each values.`;

# The user prompt for requesting the JSON object for specific form images according to a given schema.
public string userPrompt = string `Give me the json object only for below form images according to the given schema.
                Kindly go through the form carefully. \n\n
                # Important points \n
                1. If you cannot find the value for a paricular text field mark it as null. \n
                2. Give the response as plain text(json) without code format. \n 
                4. Enclose the field names with quotoes. \n\n # The schema: `;
