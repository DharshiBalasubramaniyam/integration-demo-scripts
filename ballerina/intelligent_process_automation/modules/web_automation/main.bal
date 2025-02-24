import intelligent_process_automation.types;

import ballerina/io;
import ballerina/lang.runtime;

import xlibb/selenium;

public function fill(types:Student data) returns error? {

    selenium:WebDriver driver = check new ({
        url: "https://ballerina-ipa.choreoapps.dev/student-application",
        additionalArguments: ["--start-maximized"]
    });

    runtime:sleep(2);

    // Fill personal details
    selenium:WebElement fullNameElement = check driver.findById("fullName");
    check fullNameElement.sendKeys(data.fullName);

    selenium:WebElement nameWithInitialsElement = check driver.findById("nameWithInitials");
    check nameWithInitialsElement.sendKeys(data.nameWithInitials);

    selenium:WebElement dobElement = check driver.findById("dob");
    check dobElement.sendKeys(data.dob);

    selenium:WebElement ageElement = check driver.findById("age");
    check ageElement.sendKeys(data.age);

    selenium:WebElement nationalityElement = check driver.findById("nationality");
    check nationalityElement.sendKeys(data.nationality);

    selenium:WebElement genderElement = check driver.findById(data.gender);
    check genderElement.click();

    selenium:WebElement addressElement = check driver.findById("address");
    check addressElement.sendKeys(data.address);

    selenium:WebElement mobileElement = check driver.findById("mobile");
    check mobileElement.sendKeys(data.mobile);

    selenium:WebElement districtElement = check driver.findById("district");
    check districtElement.sendKeys(data.district);

    selenium:WebElement gramaSevakaElement = check driver.findById("gramaSevaka");
    check gramaSevakaElement.sendKeys(data.gramaSevaka);

    selenium:WebElement nicElement = check driver.findById("nic");
    check nicElement.sendKeys(data.nic ?: "");

    selenium:WebElement passportElement = check driver.findById("passport");
    check passportElement.sendKeys(data.passport ?: "");

    // Fill emergency contact details
    selenium:WebElement emerNameElement = check driver.findById("emer-name");
    check emerNameElement.sendKeys(data.emergency.name);

    selenium:WebElement emerAddressElement = check driver.findById("emer-address");
    check emerAddressElement.sendKeys(data.emergency.address);

    selenium:WebElement emerMobileElement = check driver.findById("emer-mobile");
    check emerMobileElement.sendKeys(data.emergency.mobile);

    selenium:WebElement relationshipElement = check driver.findById("relationship");
    check relationshipElement.sendKeys(data.emergency.relationship);

    selenium:WebElement emerEmailElement = check driver.findById("emer-email");
    check emerEmailElement.sendKeys(data.emergency.email);

    // Fill O/L results
    selenium:WebElement olSchoolElement = check driver.findById("ol-school");
    check olSchoolElement.sendKeys(data.olResults.school);

    selenium:WebElement olYearElement = check driver.findById("ol-year");
    check olYearElement.sendKeys(data.olResults.year);

    selenium:WebElement olIndexElement = check driver.findById("ol-index");
    check olIndexElement.sendKeys(data.olResults.index);

    selenium:WebElement olSubjectElement = check driver.findById("ol-subject");
    selenium:WebElement olGradeElement = check driver.findById("ol-grade");
    selenium:WebElement addOlResultElement = check driver.findById("add-ol-result");

    foreach types:ResultsItem item in data.olResults.results {
        check olSubjectElement.sendKeys(item.subject);
        check olGradeElement.sendKeys(item.grade);
        check addOlResultElement.click();
    }

    // Fill A/L results
    selenium:WebElement alSchoolElement = check driver.findById("al-school");
    check alSchoolElement.sendKeys(data.alResults.school);

    selenium:WebElement alYearElement = check driver.findById("al-year");
    check alYearElement.sendKeys(data.alResults.year);

    selenium:WebElement alIndexElement = check driver.findById("al-index");
    check alIndexElement.sendKeys(data.alResults.index);

    selenium:WebElement zScoreElement = check driver.findById("zScore");
    check zScoreElement.sendKeys(data.alResults.zScore);

    selenium:WebElement alSubjectElement = check driver.findById("al-subject");
    selenium:WebElement alGradeElement = check driver.findById("al-grade");
    selenium:WebElement addAlResultElement = check driver.findById("add-al-result");
    foreach types:ResultsItem item in data.alResults.results {
        check alSubjectElement.sendKeys(item.subject);
        check alGradeElement.sendKeys(item.grade);
        check addAlResultElement.click();
    }

    // Fill other qualifications
    selenium:WebElement courseElement = check driver.findById("course");
    selenium:WebElement nvqElement = check driver.findById("nvq");
    selenium:WebElement instituteElement = check driver.findById("institute");
    selenium:WebElement nvqYearElement = check driver.findById("nvq-year");
    selenium:WebElement nvqResultElement = check driver.findById("nvq-result");
    selenium:WebElement addNvqResultElement = check driver.findById("add-nvq-result");

    foreach types:OtherQualificationsItem item in data.otherQualifications {
        check courseElement.sendKeys(item.course);
        check nvqElement.sendKeys(item.nvqLevel);
        check instituteElement.sendKeys(item.institute);
        check nvqYearElement.sendKeys(item.year);
        check nvqResultElement.sendKeys(item.result);
        check addNvqResultElement.click();
    }

    // Fill Extra curricular activities
    selenium:WebElement extraActivitiesElement = check driver.findById("extra-activities");
    check extraActivitiesElement.sendKeys(data.extraCurricularActivities);

    // Fill Refrees
    selenium:WebElement refreeNameElement = check driver.findById("refree-name");
    selenium:WebElement designationElement = check driver.findById("designation");
    selenium:WebElement refreeAddressElement = check driver.findById("refree-address");
    selenium:WebElement refreeMobileElement = check driver.findById("refree-mobile");
    selenium:WebElement addRefreeElement = check driver.findById("add-refree");

    foreach types:RefreesItem item in data.refrees {
        check refreeNameElement.sendKeys(item.name);
        check designationElement.sendKeys(item.designation);
        check refreeAddressElement.sendKeys(item.address);
        check refreeMobileElement.sendKeys(item.mobile);
        check addRefreeElement.click();
    }

    // Submit the form
    selenium:WebElement submitButtonElement = check driver.findById("submit");
    check submitButtonElement.click();

    // Close the browser
    // check driver.quit();

    io:println("Data entered successfully!");

}
