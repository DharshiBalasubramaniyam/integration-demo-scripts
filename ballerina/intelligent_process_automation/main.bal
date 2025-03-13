import intelligent_process_automation.db;
import intelligent_process_automation.desktop_automation;
import intelligent_process_automation.pdfToJSON;
import intelligent_process_automation.types;
import intelligent_process_automation.web_automation;

import ballerina/io;

import thisarug/prettify;

public function main() returns error? {

    // Getting json data from the pdf
    io:println("Extracting data from the PDF...");
    json targetJsonSchema = check io:fileReadJson("./resources/jsonSchema.json");
    json jsonExtractedFromPDF = check pdfToJSON:convertPDFToJSON("./resources/form.pdf", targetJsonSchema.toString());
    io:println("\nReceived JSON data from open AI: ", prettify:prettify(jsonExtractedFromPDF));

    // Converting the json data to the record type
    types:Student data = check jsonExtractedFromPDF.fromJsonWithType(types:Student);

    // Use case 1
    io:println("Storing data in the database...");
    check db:store(data);

    // Use case 2
    io:println("Filling the form in the web application...");
    check web_automation:fill(data);

    // Use case 3
    io:println("Filling the form in the desktop application...");
    check desktop_automation:fill(data);

    io:println("Process completed successfully.");
}
