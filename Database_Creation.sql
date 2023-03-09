USE [ITI Mansoura System]

CREATE TABLE Students (
StdID varchar(10) NOT NULL PRIMARY KEY,
StdSSN varchar(14) NOT NULL UNIQUE,
StdName varchar(100) NOT NULL,
StdBirthDate date NOT NULL,
StdGender varchar(1) NOT NULL,
StdCity varchar(50) NOT NULL,
StdPhone varchar(11) NOT NULL,
StdJoinDate date NOT NULL,
StdGradDate date,
StdFaculty varchar(50) NOT NULL,
StdSpecialization varchar(50) NOT NULL,
StdUniGradGrade varchar(2) NOT NULL,
StdUniGradYear int NOT NULL,
StdAcceptanceScore decimal NOT NULL,
StdRound varchar(1) NOT NULL,
StdGrade varchar(1),
StdCertificateKPI varchar(20),
StdFreelancingKPI varchar(20),
StdGradProjectGrade varchar(1),
StdStatus varchar(10),
StdEmail varchar(100) NOT NULL,
StdPass varchar(50) NOT NULL,
StdTrackID varchar(10),
CHECK (LEN(StdSSN) = 14),
CHECK (LEN(StdPhone) = 11),
CHECK (StdGender IN ('M','F')),
CHECK (StdGrade IN ('A','B','C','D')),
CHECK (StdGradProjectGrade IN ('A','B','C','D')),
)

GO

CREATE TABLE Tracks (
TrackID varchar(10) NOT NULL PRIMARY KEY,
TrackName varchar(50) NOT NULL,
)

GO

CREATE TABLE Certifications (
CredID varchar(50) NOT NULL PRIMARY KEY,
CertName varchar(50) NOT NULL,
CertWebsite varchar(50) NOT NULL,
CertDuration int,
ExamPercentage decimal,
StdID varchar(10)
)

GO

CREATE TABLE Full_Time_Position (
PosID varchar(10) PRIMARY KEY,
Position varchar(50) NOT NULL
)

GO

CREATE TABLE Freelancing_Tittle (
TitleID varchar(10) PRIMARY KEY,
Title varchar(50) NOT NULL
)

GO

CREATE TABLE Student_Freelance (
StdID varchar(10) NOT NULL,
FreelanceID varchar(10) NOT NULL,
JobDate date NOT NULL,
JobMoney decimal NOT NULL,
Employer varchar(50) NOT NULL,
CONSTRAINT PK_Student_Freelance PRIMARY KEY (StdID,FreelanceID)
)

GO

CREATE TABLE Instructors (
InsID varchar(10) PRIMARY KEY,
InsSSN varchar(14) NOT NULL UNIQUE CHECK (Len(InsSSN)=14),
InsName varchar(50) NOT NULL,
InsBirthDate date NOT NULL,
InsGender varchar(1) NOT NULL CHECK (InsGender IN('M','F')),
InsCity varchar(50) NOT NULL,
InsPhone varchar(11) NOT NULL CHECK (Len(InsPhone)=11),
YearsofExperience int NOT NULL,
InsBranch varchar(30) NOT NULL,
InsEmail varchar(50) NOT NULL,
InsPass varchar(50) NOT NULL
)

GO

CREATE TABLE InsTrack (
InsID varchar(10),
TrackID varchar(10),
CONSTRAINT PK_InsTrack PRIMARY KEY (InsID,TrackID)
)

GO
CREATE TABLE Courses(
CrsID varchar(10) NOT NULL PRIMARY KEY ,
CrsName varchar(20) NOT NULL,
CrsType varchar(10) NOT NULL,
CrsGrade int NOT NULL,
TechType varchar(10),
CONSTRAINT CrsType CHECK(CrsType in ('Technical','Soft')),
CONSTRAINT TechType CHECK(CrsType in ('Course','Workshop'))
 )

GO
CREATE TABLE CrsTopic(
CrsID varchar(10) NOT NULL,
Topic varchar(20) NOT NULL,
CONSTRAINT CrsTopics PRIMARY KEY (CrsID, Topic) )

GO
CREATE TABLE StdCrs(
StdID varchar(10) NOT NULL,
CrsID varchar(10) NOT NULL,
StdGrade int NOT NULL,
StdStatus varchar(10) NOT NULL,
Evaluation int,
CONSTRAINT PK_Constraint_StdCrs PRIMARY KEY (StdID,CrsID),
CONSTRAINT StdStatus CHECK(StdStatus in ('Completed','Incompleted')),
CONSTRAINT Evaluation CHECK(Evaluation >=1 and Evaluation<=5)
)

GO
CREATE TABLE TrackCrs(
TrackID varchar(10) NOT NULL,
CrsID varchar(10) NOT NULL,
T_Type varchar(10) NOT NULL,
PercofTotal decimal NOT NULL,
CONSTRAINT PK_Constraint_TrackCrs PRIMARY KEY (TrackID, CrsID),
CONSTRAINT T_Type CHECK(T_Type in ('Online','Offline'))
)

GO
CREATE TABLE Questions(
QuesID varchar(10) NOT NULL PRIMARY KEY,
Question varchar(200) NOT NULL,
Answer varchar(100) NOT NULL,
QuesGrade int NOT NULL,
QuesType varchar(3) NOT NULL,
CrsID varchar(10),
CONSTRAINT QuesType CHECK(QuesType in ('MCQ','TF'))
)

GO
CREATE TABLE QuesChoices(
QuesID varchar(10) NOT NULL,
Choice varchar(100) NOT NULL,
CONSTRAINT PK_Constraint_QuesChoices PRIMARY KEY (QuesID, Choice)
)

GO
CREATE TABLE InsCrs(
CrsID varchar(10) NOT NULL,
InsID varchar(10) NOT NULL,
CONSTRAINT PK_Constraint_InsCrs PRIMARY KEY (CrsID, InsID)
)

GO
CREATE TABLE Exam(
ExID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
TotalResult int NOT NULL,
ExDate date,
)

GO
CREATE TABLE TakeExam(
ExID int NOT NULL,
StdID varchar(10) NOT NULL,
QuesID varchar(10) NOT NULL,
StudAns varchar(100) NOT NULL,
StdGrade int NOT NULL,
CONSTRAINT PK_Constraint_TakeExam PRIMARY KEY (ExID, StdID, QuesID)
)

GO
CREATE TABLE Std_Get_Pos(
StdID varchar(10) NOT NULL PRIMARY KEY,
PosID varchar(10) NOT NULL,
HiringDate Date NOT NULL,
Company varchar(20) NOT NULL,
)
 

 