create database if not exists teenViolence;

use teenViolence;

-- here binary means for zero -  is avoid, one - is approach.


create table if not exists user(
userId bigint(20) NOT NULL AUTO_INCREMENT,
userAge bigint(20),
userGender enum('male', 'female', 'choose not to disclose'),
userEthnicity 
enum('African American/Black',
      'Hispanic/Latino',
	  'Asian',
      'Middle Eastern',
      'Pacific Islander',
      'Native American/Alaskan', 
	  'Other',
      'Choose not to specify',
      'N/A'),
userDisability enum('yes', 'no', 'choose not to disclose') NOT NULL,
userEducation varchar(200) NOT NULL,
userMobileHandlingExperience bigint(20) NOT NULL,
userPsycothereputicMedications varchar(200) NOT NULL,
userColorblind boolean NOT NULL,
PRIMARY KEY (userId)
);


create table if not exists userLogin(
userLoginId bigint(20) NOT NULL AUTO_INCREMENT,
ulUserName varchar(200) NOT NULL UNIQUE,
ulPassword varchar(200) NOT NULL,
ulUserDetails bigint(10) NOT NULL,
PRIMARY KEY (userLoginId),
KEY FKI_USER_DETAILS (ulUserDetails),
CONSTRAINT FKI_USER_DETAILS FOREIGN KEY (ulUserDetails) REFERENCES user (userId)
);

create table if not exists userSession(
userSessionId bigint(20) NOT NULL,
usUserId bigint(20) NOT NULL,
usSessionNumber bigint(20) NOT NULL,
usSessionDate date NOT NULL,
PRIMARY KEY (userSessionId),
KEY PKI_USER_SESSION_ID (userSessionId),
KEY FKI_USER_ID (usUserId),
CONSTRAINT FKI_USER_ID FOREIGN KEY (usUserId) REFERENCES userLogin (userLoginId) on delete cascade on update cascade
);

create table if not exists questAns(
queAnsId bigint(20) NOT NULL AUTO_INCREMENT,
qaSessionId bigint(20) NOT NULL,
qaSessionDate date NOT NULL, 
qaUserId bigint(20) NOT NULL,
qaQuestion varchar(2000) NOT NULL,
qaAnswer enum('1', '2', '3', '4', '5') NOT NULL,
questionType varchar(10) NOT NULL,
PRIMARY KEY (queAnsId),
KEY PKI_QUEANS_ID (queAnsId),
KEY FKI_QA_USER_ID (qaUserId),
CONSTRAINT FKI_QA_USER_ID FOREIGN KEY (qaUserId) REFERENCES userLogin (userLoginId) on delete cascade on update cascade
);


create table if not exists questionnaire(
questionnaireId bigint(20) NOT NULL,
questionnaireType enum('B', 'E'),
questionId int(20) NOT NULL,
questionText varchar(2000) NOT null,
PRIMARY KEY (questionnaireId),
KEY PKI_QUESTIONNAIRE_ID (questionnaireId)
);

create table if not exists image(
imageId bigint(20) NOT NULL AUTO_INCREMENT,
imgName varchar(200) NOT NULL,
imgFileLocation varchar(200) NOT NULL,
PRIMARY KEY (imageId)
);

create table if not exists background(
backgroundId bigint(20) NOT NULL AUTO_INCREMENT,
bgColor varchar(200) NOT NULL UNIQUE,
PRIMARY KEY (backgroundId)
);

create table if not exists imageBackground(
imageBackgroundId bigint(20) NOT NULL AUTO_INCREMENT,
ibImage bigint(20),
ibBackground bigint(20) NOT NULL,
KEY PKI_imageBackground (imageBackgroundId),
KEY FKI_IMAGE (ibImage),
CONSTRAINT FKI_IMAGE FOREIGN KEY (ibImage) REFERENCES image (imageId),
PRIMARY KEY (imageBackgroundId)
);

create table if not exists response(
responseId bigint(20) NOT NULL AUTO_INCREMENT,
respCorrectness enum('right', 'wrong', 'not answered') NOT NULL,
respTimeTaken float(20) NOT NULL,
respExpectedResult binary NOT NULL,
respActualResult binary NOT NULL,
respUser bigint(20) NOT NULL,
respBGColor varchar(20) NOT NULL,
KEY FKI_USER_RESP (respUser),
CONSTRAINT FKI_USER_RESP FOREIGN KEY (respUser) REFERENCES userLogin (userLoginId) on delete cascade on update cascade,
PRIMARY KEY(responseId)
);

create table if not exists parameter( 
parameterId bigint(20) NOT NULL AUTO_INCREMENT,
paramUser bigint(20) NOT NULL,
paramSessionId bigint(20) NOT NULL,
paramSessionDate date NOT NULL,
paramColorOne varchar(50) NOT NULL,
paramColorTwo varchar(50) NOT NULL,
paramColorOneType binary NOT NULL,
paramColorTwoType binary NOT NULL,
paramTimeInterval bigint(20) NOT NULL,
paramQuestionnaire bigint(20) NOT NULL,
KEY FKI_QUESTIONNAIRE (paramQuestionnaire),
KEY FKI_USER (paramUser),
CONSTRAINT FKI_QUESTIONNAIRE FOREIGN KEY (paramQuestionnaire) REFERENCES questionnaire (questionnaireId) on delete cascade on update cascade,
CONSTRAINT FKI_USER FOREIGN KEY (paramUser) REFERENCES userLogin (userLoginId) on delete cascade on update cascade,
PRIMARY KEY (parameterId)
);

create table if not exists evaluation(
evaluationId bigint(20) NOT NULL,
comments varchar(3000) NOT NULL,
participant bigint NOT NULL,
KEY FKI_PARTICIPANT (participant),
CONSTRAINT FKI_PARTICIPANT FOREIGN KEY (participant) REFERENCES userLogin (userLoginId) on delete cascade on update cascade
);
 