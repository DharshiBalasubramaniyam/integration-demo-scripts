import intelligent_process_automation.types;

import ballerina/file;
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/os;

import xlibb/sikulix;

string basePath = file:getCurrentDir();
string imagespath = basePath + "/resources/elements";
string appPath = basePath + "/resources/student_app.jar";

public function fill(types:Student data) returns error? {

    // Open the application
    _ = check os:exec({value: "java", arguments: ["-jar", appPath]});
    runtime:sleep(1);

    sikulix:Screen screen = check new ();

    // Fill personal details
    check screen.'type(data.fullName + "\t");
    check screen.'type(data.nameWithInitials + "\t");
    check screen.'type(data.dob + "\t");
    check screen.'type(data.age + "\t");
    check screen.'type(data.nationality + "\t");
    check (check screen.find(string `${imagespath}/${data.gender}.png`)).click();
    check scrollToBottom(screen);
    check (check screen.find(string `${imagespath}/address.png`)).'type(data.address + "\t");
    check screen.'type(data.mobile + "\t");
    sikulix:Match districtMatch = check screen.find(imagespath + "/district.png");
    check districtMatch.click();
    sikulix:Region dropDownRegion = check new ({
        topLeftX: check districtMatch.getTopLeftX(),
        topLeftY: check districtMatch.getTopLeftY(),
        width: 200,
        height: 20
    });
    int count = 0;
    while dropDownRegion.getText() != data.district && count <= 25 {
        check screen.keyPress(sikulix:DOWN);
        dropDownRegion = check new ({
            topLeftX: check districtMatch.getTopLeftX(),
            topLeftY: check districtMatch.getTopLeftY(),
            width: 200,
            height: 20
        });
        count = count + 1;
    }
    check screen.keyPress(sikulix:ENTER);
    check screen.'type("\t" + data.gramaSevaka + "\t");
    check screen.'type(data.nic + "\t");
    sikulix:Match nextBtnMatch = check screen.find(imagespath + "/next.png");
    check nextBtnMatch.click();

    // Fill emergency contact details
    sikulix:Match emergencyNameMatch = check screen.find(imagespath + "/emergencyName.png");
    check emergencyNameMatch.'type(data.emergency.name + "\t");
    check screen.'type(data.emergency.address + "\t");
    check screen.'type(data.emergency.mobile + "\t");
    check screen.'type(data.emergency.relationship + "\t");
    check screen.'type(data.emergency.email + "\t");
    nextBtnMatch = check screen.find(imagespath + "/next.png");
    check nextBtnMatch.click();

    // Fill OL results
    sikulix:Match olSchoolNameMatch = check screen.find(imagespath + "/OLSchool.png");
    check olSchoolNameMatch.'type(data.olResults.school + "\t");
    check screen.'type(data.olResults.year + "\t");
    check screen.'type(data.olResults.index + "\t");
    check scrollToBottom(screen);
    foreach types:ResultsItem item in data.olResults.results {
        sikulix:Match olSubjectNameMatch = check screen.find(imagespath + "/olsubject.png");
        check olSubjectNameMatch.'type(item.subject + "\t");
        check screen.'type(item.grade);
        sikulix:Match addResultBtnMatch = check screen.find(imagespath + "/addResult.png");
        check addResultBtnMatch.click();
    }
    nextBtnMatch = check screen.find(imagespath + "/next.png");
    check nextBtnMatch.click();

    // Fill AL results
    sikulix:Match alSchoolNameMatch = check screen.find(imagespath + "/alSchool.png");
    check alSchoolNameMatch.'type(data.alResults.school + "\t");
    check screen.'type(data.alResults.year + "\t");
    check screen.'type(data.alResults.index + "\t");
    check screen.'type(data.alResults.zScore + "\t");
    check scrollToBottom(screen);
    foreach types:ResultsItem item in data.alResults.results {
        sikulix:Match alSubjectNameMatch = check screen.find(imagespath + "/alSubject.png");
        check alSubjectNameMatch.'type(item.subject + "\t");
        check screen.'type(item.grade);
        sikulix:Match addResultBtnMatch = check screen.find(imagespath + "/addResult.png");
        check addResultBtnMatch.click();
    }
    nextBtnMatch = check screen.find(imagespath + "/next.png");
    check nextBtnMatch.click();

    // Fill other qualifications
    foreach types:OtherQualificationsItem item in data.otherQualifications {
        sikulix:Match courseNameMatch = check screen.find(imagespath + "/course.png");
        check courseNameMatch.'type(item.course + "\t");
        check screen.'type(item.nvqLevel + "\t");
        check screen.'type(item.institute + "\t");
        check screen.'type(item.year + "\t");
        check screen.'type(item.result + "\t");
        sikulix:Match addResultBtnMatch = check screen.find(imagespath + "/addResult.png");
        check addResultBtnMatch.click();
    }
    check scrollToBottom(screen);
    nextBtnMatch = check screen.find(imagespath + "/next.png");
    check nextBtnMatch.click();

    // Fill referees details
    foreach types:RefreesItem item in data.refrees {
        sikulix:Match refereeNameMatch = check screen.find(imagespath + "/refereeName.png");
        check refereeNameMatch.'type(item.name + "\t");
        check screen.'type(item.designation + "\t");
        check screen.'type(item.address + "\t");
        check screen.'type(item.mobile + "\t");
        sikulix:Match addResultBtnMatch = check screen.find(imagespath + "/addReferee.png");
        check addResultBtnMatch.click();
    }

    // Submit the form
    sikulix:Match finishBtnMatch = check screen.find(imagespath + "/finish.png");
    check finishBtnMatch.click();

    io:println("Data entered successsfully!");
}

function scrollToBottom(sikulix:Screen screen) returns sikulix:Error? {
    sikulix:Match|sikulix:Error nextBtn = screen.find(string `${imagespath}/next.png`);
    while nextBtn is sikulix:FindFailedError {
        check screen.wheel(1, 3);
        nextBtn = screen.find(string `${imagespath}/next.png`);
    }
}
