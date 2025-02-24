import intelligent_process_automation.types;

import ballerina/io;
import ballerina/uuid;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// configure Database
configurable string dbHost = ?;
configurable string dbUsername = ?;
configurable string dbPassword = ?;
configurable string dbName = ?;
configurable int dbPort = ?;

# Store data in the database
#
# + data - data to be stored in the database.
# + return - Returns `error` if an error occurs.
public function storeInDatabase(types:Student data) returns error? {
    mysql:Client db = check new (dbHost, dbUsername, dbPassword, dbName, dbPort);

    string student_id = uuid:createType1AsString();
    string ol_id = uuid:createType1AsString();
    string al_id = uuid:createType1AsString();

    _ = check db->execute(`INSERT INTO student
                VALUES (${student_id}, ${data.fullName}, ${data.nameWithInitials}, ${data.dob}, ${data.age},
                ${data.nationality}, ${data.gender}, ${data.address}, ${data.mobile},
                ${data.district}, ${data.gramaSevaka}, ${data.nic},
                ${data.passport});`);

    _ = check db->execute(`INSERT INTO emergencycontact (name, address, mobile, relationship, email, studentId)
                VALUES (${data.emergency.name}, ${data.emergency.address}, ${data.emergency.mobile}, ${data.emergency.relationship}, ${data.emergency.email},
                ${student_id});`);

    _ = check db->execute(`INSERT INTO olresults 
                        VALUES (${ol_id}, ${data.olResults.school}, ${data.olResults.year}, ${data.olResults.index}, ${student_id});`);

    foreach types:ResultsItem item in data.olResults.results {
        _ = check db->execute(`INSERT INTO olresultdetails (olResultId, subject, grade)
                        VALUES (${ol_id}, ${item.subject}, ${item.grade});`);

    }

    _ = check db->execute(`INSERT INTO alresults
                        VALUES (${al_id}, ${data.alResults.school}, ${data.alResults.year}, ${data.alResults.index},  ${data.alResults.zScore}, ${student_id});`);

    foreach types:ResultsItem item in data.alResults.results {
        _ = check db->execute(`INSERT INTO alresultdetails (alResultId, subject, grade)
                        VALUES (${al_id}, ${item.subject}, ${item.grade});`);

    }

    foreach types:OtherQualificationsItem item in data.otherQualifications {
        _ = check db->execute(`INSERT INTO otherqualifications (course, nvqLevel, institute, year, result, studentId)
                        VALUES (${item.course}, ${item.nvqLevel}, ${item.institute}, ${item.year}, ${item.result}, ${student_id});`);

    }

    foreach types:RefreesItem item in data.refrees {
        _ = check db->execute(`INSERT INTO referees (name, designation, address, mobile, studentId)
                        VALUES (${item.name}, ${item.designation}, ${item.address}, ${item.mobile}, ${student_id});`);

    }

    io:println("Data has stored to database successfully!");
}
