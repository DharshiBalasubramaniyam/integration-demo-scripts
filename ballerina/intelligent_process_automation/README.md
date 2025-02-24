# Intelligent process automation

## Goal

This document provides a detailed explanation of a demo script showcasing an intelligent process automation use case built using Ballerina.

## Overview of Intelligent Process Automation

Automation is transforming the way businesses operate, unlocking new opportunities to achieve peak efficiency and innovation. Why is it crucial? Because it not only streamlines operations but also enhances workplace productivity and employee experiences. By taking over repetitive and mundane tasks, automation empowers teams to focus on creativity, innovation, and problem-solving—the key drivers of growth in today’s fast-paced world.

With advancements like Robotic Process Automation (RPA) and Intelligent Process Automation (IPA), businesses are reimagining workflows, adopting smarter and more agile processes to stay ahead of the competition. 

### Robotic Process Automation (RPA)

Robotic Process Automation (RPA) is a technology that allows organizations to automate rule-based repetitive tasks and processes using software robots or "bots". These bots can mimic human actions to perform tasks such as data entry, transaction processing, and responding to simple customer service queries. RPA can help improve efficiency, reduce errors, and free up human workers to focus on more complex and value-added activities.

### Artificial Intelligence (AI)

One of the humans' most distinct qualities is their ability to make decisions and take action based on previous experience. Artificial Intelligence (AI) refers to the simulation of human intelligence in machines that are programmed to think and learn like humans. AI can be used to analyze large amounts of data, recognize patterns, and make decisions with minimal human intervention. 

### How does RPA differ from AI?

While the use of artificial intelligence and RPA tools minimize the need for human intervention, the way in which they automate processes is different. The critical difference is that RPA is process-driven, whereas AI is data-driven. RPA bots can only follow the processes defined by an end user in a workflow, while AI bots use machine learning to recognize patterns in data, in particular unstructured data, and learn over time.

### Intelligent Process Automation (IPA)

Intelligent Process Automation (IPA) technology builds on top of RPA, incorporates AI capabilities such as ML, OCR, and NLP, and automates complex tasks that require intelligent decision-making.
In simple terms, **IPA = RPA + AI**.

## IPA use case

This demo script explains the following IPA use case.

![ipa use case](./resources/useCase.png)

The image represents an Intelligent Process Automation (IPA) use case for extracting and processing data from scanned documents. The workflow begins with scanning a physical form, such as an application, invoice, or survey, and saving it as a PDF. This scanned document is then stored on an FTP server, serving as a centralized location for further processing. Next, an automation system retrieves the PDF from the server, enabling structured data extraction.

Once the document is obtained, Optical Character Recognition (OCR) and AI-based tools extract its content and convert it into JSON format. This structured data can then be processed in multiple ways. It may be stored in a database for record-keeping or analytics, entered into a web application through web automation, or inputted into desktop applications via automation services. This ensures flexibility and compatibility with both modern and legacy systems.

Automation of such processes is highly significant in today’s digital landscape. It eliminates manual data entry, reducing human effort and minimizing errors. By enhancing efficiency and productivity, organizations can free up employees to focus on more strategic work. Moreover, automation improves accuracy and compliance, ensuring data integrity while mitigating compliance risks. Another key benefit is seamless integration with both legacy and modern systems, making it a valuable solution for industries that rely heavily on document processing, such as finance, healthcare, insurance, and government.

## IPA in action with Ballerina

### Step 1: Extracting Required Data as JSON from a Filled Application Form

This process involves two crucial steps to ensure accurate and efficient data extraction:

1. **Converting Document Pages to Images**: 
    Each page of the document will be converted into an image format. This step is essential as it prepares the document for further processing by transforming it into a format that can be easily analyzed. We will utilize the **Ballerina pdfbox module** to achieve this conversion, ensuring that each page is accurately rendered as an image.

2. **Processing Images with OpenAI API**:
    Once the document pages are converted into images, the next step is to extract the required data. We will send these images, along with a predefined JSON schema, to the OpenAI API. The API will process the images and retrieve the data in JSON format. This step leverages the **Ballerina OpenAI chat client connector** and **Ballerina's JSON handling capabilities**, which facilitates seamless communication with the OpenAI API, ensuring that the data extraction is both accurate and efficient.

By following these steps, we can automate the extraction of structured data from scanned documents, significantly reducing manual effort and minimizing errors. This process not only enhances efficiency but also ensures that the extracted data is ready for further processing and analysis. 

The [`pdfToJSON`](./modules/pdfToJSON/) module contains the logic for converting PDF documents to JSON format. This module handles the entire process of transforming document pages into images and subsequently extracting the required data using the OpenAI API.

### Step 2: Use case 1 - Storing extracted data in the database.

In this use case, we will demonstrate how to store the extracted data into a database using the **Ballerina MySQL client connector**. This step is crucial for maintaining a structured and easily accessible repository of the processed information.

The [`db`](./modules/db/) module contains the logic for storing the extracted data into a MySQL database. This module handles the entire process of connecting to the database, and inserting the extracted data. 

To set up the necessary tables in the MySQL database for storing the extracted data, use the [`tables.sql`](./resources/tables.sql). This script defines the structure of the tables, ensuring that the data is organized and easily accessible for further processing.

### Step 3: Filling a web application form using extracted data

To automate the data entry into a web application, we will use the **Ballerina Selenium module**. Selenium allows us to interact with web browsers directly, simulating user actions such as clicks, text input, page navigation, and more. This enables us to automate the process of filling out web forms with the extracted data, ensuring accuracy and efficiency while reducing manual effort.

The [`web_automation`](./modules/web_automation/) module contains the logic for automating the process of filling out web application forms with the extracted data. This module handles interactions with web browsers, simulating user actions to ensure accurate and efficient data entry.

### Step 4: Filling a desktop application form using extracted data

To automate data entry into a desktop application, we will use the **Ballerina Sikulix library**. Sikulix enables image-based automation by identifying elements through screenshots, allowing for precise control through coordinate-based interaction. With its built-in OCR capabilities, Sikulix can recognize and interact with on-screen text. Additionally, it is cross-platform, supporting Windows, macOS, and Linux.

By leveraging Sikulix, we can automate the process of filling out desktop application forms with the extracted data, ensuring accuracy and efficiency while minimizing manual effort.

The [`desktop_automation`](./modules/desktop_automation/) module contains the logic for automating the process of filling out desktop application forms with the extracted data. This module handles interactions with desktop applications, using image-based automation to ensure accurate and efficient data entry.
