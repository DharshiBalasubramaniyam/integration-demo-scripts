public type Emergency record {
    string name;
    string address;
    string mobile;
    string relationship;
    string email;
};

public type ResultsItem record {
    string subject;
    string grade;
};

public type OlResults record {
    string school;
    string year;
    string index;
    ResultsItem[] results;
};

public type AlResults record {
    string school;
    string year;
    string index;
    string zScore;
    ResultsItem[] results;
};

public type OtherQualificationsItem record {
    string course;
    string nvqLevel;
    string institute;
    string year;
    string result;
};

public type RefreesItem record {
    string name;
    string designation;
    string address;
    string mobile;
};

public type Student record {
    string fullName;
    string nameWithInitials;
    string dob;
    string age;
    string nationality;
    string gender;
    string address;
    string mobile;
    string district;
    string gramaSevaka;
    string nic;
    Emergency emergency;
    OlResults olResults;
    AlResults alResults;
    OtherQualificationsItem[] otherQualifications;
    string extraCurricularActivities;
    RefreesItem[] refrees;
};
