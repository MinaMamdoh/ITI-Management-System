use ITI_Mansoura_System

-----------------------COURSES TABLE------------------------------------
--->Insert into courses table
GO
CREATE PROCEDURE Insertcourses
(
@CourseID			VARCHAR(10),
@CourseName			VARCHAR(20),
@CourseType			VARCHAR(10),
@CourseGrade		INT,
@TechType			VARCHAR(10)
)
AS
BEGIN;
	IF NOT EXISTS (SELECT CrsID FROM Courses WHERE CrsID = @CourseID)
		INSERT INTO dbo.Courses (CrsID, CrsName, CrsType, CrsGrade, TechType)
			VALUES (@CourseID, @CourseName, @CourseType, @CourseGrade, @TechType)
END;


--->Select from courses table
GO
CREATE PROCEDURE Selectcourses
(
@ID		VARCHAR(10)
)
AS
BEGIN;
	IF EXISTS (SELECT CrsID FROM Courses WHERE CrsID = @ID)
		SELECT * FROM dbo.Courses
		WHERE CrsID = @ID
	ELSE
		PRINT ('The course not found')
END;


--->Delete from courses table
GO
CREATE PROCEDURE Deletecourse
(
@ID		VARCHAR(10)
)
AS
BEGIN;
	IF EXISTS (SELECT CrsID FROM Courses WHERE CrsID = @ID)
		DELETE FROM dbo.Courses
		WHERE CrsID = @ID
	ELSE
		PRINT ('The course not found')
END;



--->Update courses table
GO
CREATE PROCEDURE Updatecourses
(
@CourseID			VARCHAR(10),
@CourseName			VARCHAR(20) ='TestValue',
@CourseType			VARCHAR(10) ='TestValue',
@CourseGrade		VARCHAR(10) ='TestValue',
@TechType			VARCHAR(10) ='TestValue'
)
AS
BEGIN;
	IF EXISTS (SELECT CrsID FROM Courses WHERE CrsID = @CourseID)
	BEGIN;
		IF @CourseName != 'TestValue'
		BEGIN;
			UPDATE Courses
				SET CrsName = @CourseName WHERE CrsID = @CourseID
		END;
		IF @CourseType != 'TestValue'
		BEGIN;
			UPDATE Courses
				SET CrsType = @CourseType WHERE CrsID = @CourseID
		END;
		IF @CourseGrade != 'TestValue'
		BEGIN;
			UPDATE Courses
				SET CrsGrade = CONVERT(INT,@CourseGrade) WHERE CrsID = @CourseID
		END;
		IF @CourseName != 'TestValue'
		BEGIN;
			UPDATE Courses
				SET TechType = @TechType WHERE CrsID = @CourseID
		END;
	END;
	ELSE
		PRINT ('The course doesn''t exist')
END;




-----------------------COURSETOPICS TABLE------------------------------------
--->Insert into COURSETOPICS TABLE
GO
CREATE PROCEDURE Insertcoursetopic
(
@CourseID		VARCHAR(10),
@CourseTopic	VARCHAR(20)
)
AS
BEGIN;
	IF NOT EXISTS (SELECT CrsID FROM CrsTopic WHERE CrsID = @CourseID AND Topic = @CourseTopic)
		INSERT INTO CrsTopic (CrsID,Topic)
			VALUES (@CourseID, @CourseTopic)
	ELSE
		PRINT ('This topic of this course already exists')
END;



--->Select From COURSETOPICS TABLE
GO
CREATE PROCEDURE Selectcoursetopic
(
@CourseID		VARCHAR(10),
@CourseTopic	VARCHAR(20)
)
AS
BEGIN;
	IF EXISTS (SELECT CrsID FROM CrsTopic WHERE CrsID = @CourseID AND Topic = @CourseTopic)
		SELECT *
		FROM CrsTopic
		WHERE CrsID = @CourseID AND Topic = @CourseTopic
	ELSE
		PRINT ('This topic of this course does''t exist')
END;


--->Delete From COURSETOPICS TABLE
GO
CREATE PROCEDURE Deletecrstopic
(
@CourseID		VARCHAR(10),
@CourseTopic	VARCHAR(20)
)
AS
BEGIN;
	IF EXISTS (SELECT CrsID FROM CrsTopic WHERE CrsID = @CourseID AND Topic = @CourseTopic)
		DELETE FROM CrsTopic
			WHERE CrsID = @CourseID AND Topic = @CourseTopic
	ELSE
		PRINT('This topic of this course does not exist')
END;



--->Update COURSETOPICS TABLE
GO
CREATE PROCEDURE Updatecrstopic
(
@OldCourseID		VARCHAR(10),
@OldCourseTopic		VARCHAR(20),
@NewCourseID		VARCHAR(10),
@NewCourseTopic		VARCHAR(20)
)
AS
BEGIN;
	IF EXISTS (SELECT CrsID FROM CrsTopic WHERE CrsID = @OldCourseID AND Topic = @OldCourseTopic)
		UPDATE CrsTopic
			SET CrsID = @NewCourseID,
				Topic = @NewCourseTopic
	ELSE
		PRINT ('This topic of this course does not exist')
END;

-----------------------STUDENTCOURSES TABLE------------------------------------
--->Insert into STUDENTCOURSES TABLE
GO
CREATE PROCEDURE InsertStdCrs
(
@StudentID		VARCHAR(10),
@CourseID		VARCHAR(10),
@StudentGrade	INT,
@Status			VARCHAR(10),
@Evaluation		INT
)
AS
BEGIN;
	IF NOT EXISTS (SELECT StdID FROM StdCrs WHERE StdID = @StudentID AND CrsID = @CourseID)
		INSERT INTO StdCrs (StdID, CrsID, StdGrade, StdStatus, Evaluation)
			VALUES (@StudentID, @CourseID, @StudentGrade, @Status, @Evaluation)
	ELSE
		PRINT ('The student and the course already exist')
END;


--->Select from STUDENTCOURSES TABLE
GO
CREATE PROCEDURE SelectStdCrs
(
@StudentID		VARCHAR(10),
@CourseID		VARCHAR(10)
)
AS
BEGIN;
	IF EXISTS (SELECT StdID FROM StdCrs WHERE StdID = @StudentID AND CrsID = @CourseID)
		SELECT *
		FROM StdCrs
		WHERE StdID = @StudentID AND CrsID = @CourseID
	ELSE
		PRINT('The student and the course don''t exist')
END;



--->Delete from STUDENTCOURSES TABLE
GO
CREATE PROCEDURE DeleteStdCrs
(
@StudentID		VARCHAR(10),
@CourseID		VARCHAR(10)
)
AS
BEGIN;
	IF EXISTS (SELECT StdID FROM StdCrs WHERE StdID = @StudentID AND CrsID = @CourseID)
		DELETE FROM StdCrs
			WHERE StdID = @StudentID AND CrsID = @CourseID
	ELSE
		PRINT ('The student and the course don''t exist')
END;



--->Update STUDENTCOURSES TABLE
GO
CREATE PROCEDURE UpdateStdCourses
(
@StudentID			VARCHAR(10),
@CourseID			VARCHAR(10),
@StudentGrade		VARCHAR(20) ='TestValue',
@Status				VARCHAR(10) ='TestValue',
@Evaluation			VARCHAR(10) ='TestValue'
)
AS
BEGIN;
	IF EXISTS (SELECT CrsID FROM StdCrs WHERE StdID = @StudentID AND CrsID = @CourseID)
	BEGIN;
		IF @StudentGrade != 'TestValue'
		BEGIN;
			UPDATE StdCrs
				SET StdGrade = CONVERT(INT,@StudentGrade) WHERE StdID = @StudentID AND CrsID = @CourseID
		END;
		IF @Evaluation != 'TestValue'
		BEGIN;
			UPDATE StdCrs
				SET Evaluation = CONVERT(INT,@Evaluation) WHERE StdID = @StudentID AND CrsID = @CourseID
		END;
		IF @Status != 'TestValue'
		BEGIN;
			UPDATE StdCrs
				SET StdStatus = @Evaluation WHERE CrsID = @CourseID
		END;
	END;
	ELSE
		PRINT ('The course doesn''t exist')
END;

-------------------------------------------------------------------


-----------------------------------------Tracks Table--------------------------------------------------
-----> Select from Tracks Table
GO
create proc Gettrack @id varchar (10)
as 
	select * 
	from Tracks
	where TrackID = @id


-----> Insert into Tracks Table
GO
create proc Insertintracks 
@id varchar (10) , @tname varchar (50)
as 
	begin try
		insert into Tracks
		values (@id,@tname)
	end try 
	begin catch 
		select 'Error'
	end catch

-----> Delete rows from Tracks Table
GO
create proc Deletetracks @id varchar (10)
as 
	begin 
	delete from Tracks
	where TrackID= @id
	end

-----> Update rows from Tracks Table
GO
create proc Uptracks
(
@tid	VARCHAR(10),
@trackname	VARCHAR(50) ='TestValue'

)
AS
BEGIN;
	IF EXISTS (SELECT TrackID FROM Tracks WHERE TrackID = @tid)
	BEGIN;
		IF @trackname!= 'TestValue'
		BEGIN;
			UPDATE Tracks
				SET TrackName = @trackname WHERE  TrackID = @tid
		END;
	END;
	ELSE
		SELECT ('Error')
END;

-----------------------------------------Std_Get_Pos Table--------------------------------------------------
-----> Select from Std_Get_Pos (Student get position)Table
GO
create proc Getstpos @id varchar (10)
as 
	select * 
	from Std_Get_Pos
	where StdID = @id

-----> Insert into Std_Get_Pos (Student get position)Table
GO
create proc Insertinstpos
@id varchar (10) , @posid varchar (10),@hirdate date ,@company varchar (20)
as 
	begin try
		insert into Std_Get_Pos
		values (@id,@posid,@hirdate,@company)
	end try 
	begin catch 
		select 'Error'
	end catch

-----> Delete rows from Std_Get_Pos (Student get position)Table
GO
create proc Deletestpos @id varchar (10)
as 
	begin 
	delete from Std_Get_Pos
	where StdID= @id
	end

-----> Update rows from Std_Get_Pos (Student get position)Table
GO
create proc Upstposition
(
@stid		VARCHAR(10),
@posid		VARCHAR(10) ='TestValue',
@hiredate		date ='TestValue',
@company		VARCHAR(20) ='TestValue'
)
AS
BEGIN;
	IF EXISTS (SELECT StdID FROM Std_Get_Pos WHERE StdID = @stid)
	BEGIN;
		IF @posid!= 'TestValue'
		BEGIN;
			UPDATE Std_Get_Pos
				SET PosID = @posid  WHERE  StdID = @stid
		END;
		IF @hiredate!= 'TestValue'
		BEGIN;
			UPDATE Std_Get_Pos
				SET HiringDate = CONVERT(date,@hiredate) WHERE  StdID = @stid
		END;
		IF @company!= 'TestValue'
		BEGIN;
			UPDATE Std_Get_Pos
				SET Company = @company WHERE  StdID = @stid
		END;
	END;
	ELSE
		SELECT ('Error')
END;

-----------------------------------------Full_Time_Position Table--------------------------------------------------
-----> Select from Full Time Position Table
GO
create proc Getposition @id varchar (10)
as 
	select * 
	from Full_Time_Position
	where PosID = @id

-----> Insert into Full Time Position Table
GO
create proc Insertinpos
@pid varchar (10) , @positionname varchar (50)
as 
	begin try
		insert into Full_Time_Position
		values (@pid,@positionname)
	end try 
	begin catch 
		select 'Error'
	end catch

-----> Delete rows from Full Time Position Table
GO
create proc Deletepos @pid varchar (10)
as 
	begin 
	delete from Full_Time_Position
	where PosID= @pid
	end

-----> Update rows from Full Time Position Table
GO
create proc Upposition
(
@postid			VARCHAR(10),
@positionname			VARCHAR(50) ='TestValue'
)
AS
BEGIN;
	IF EXISTS (SELECT PosID FROM Full_Time_Position WHERE PosID = @postid)
	BEGIN;
		IF @positionname != 'TestValue'
		BEGIN;
			UPDATE Full_Time_Position
				SET Position = @postid WHERE  PosID = @postid
		END;
	END;
	ELSE
		SELECT ('Error')
END;

-----------------------------------------Certifications Table--------------------------------------------------
-----> Select from  Certifications Table
GO
create proc Getcert @id varchar
as 
	select * 
	from Certifications
	where CredID = @id

-----> Insert into Certifications Table
GO
create proc Insertincert
@certid varchar (50) , @certname varchar (50),@website varchar (50),@duration int, @examperc decimal (18,0),@stid varchar (10)	
as 
	begin try
		insert into Certifications
		values (@certid,@certname,@website,@duration,@examperc,@stid)
	end try 
	begin catch 
		select 'Error'
	end catch

-----> Delete rows from Certifications Table
GO
create proc Deletecert @id varchar (50)
as 
	begin 
	delete from Certifications
	where CredID= @id
	end

-----> Update rows from Certifications Table
GO
create proc Upcert
(
@certid			VARCHAR(50),
@Certname			VARCHAR(50) ='TestValue',
@certwebsite		VARCHAR(50) ='TestValue',
@certduration		int ='TestValue',
@exampercentage		decimal (18,0) ='TestValue',
@stid	VARCHAR(10) ='TestValue'

)
AS
BEGIN;
	IF EXISTS (SELECT CredID FROM Certifications WHERE CredID = @certid)
	BEGIN;
		IF @Certname != 'TestValue'
		BEGIN;
			UPDATE Certifications
				SET CertName = @Certname WHERE  CredID = @certid
		END;
		IF @certwebsite != 'TestValue'
		BEGIN;
			UPDATE Certifications
				SET CertWebsite = @certwebsite WHERE  CredID = @certid
		END;
		IF @certduration != 'TestValue'
		BEGIN;
			UPDATE Certifications
				SET CertDuration = CONVERT(INT,@certduration) WHERE CredID = @certid
		END;
		IF @exampercentage != 'TestValue'
		BEGIN;
			UPDATE Certifications
				SET ExamPercentage = CONVERT(decimal (18,0),@exampercentage) WHERE CredID = @certid
		END;
		IF @stid != 'TestValue'
		BEGIN;
			UPDATE Certifications
				SET StdID= @stid WHERE CredID = @certid
		END;
	END;
	ELSE
		SELECT ('Error')
END;

-------------------------------------------------------------------


---------------------------Table Instructores---------------------------------

--------->Select Ins
Go
CREATE Procedure Select_Instructor
(@INS_ID VARCHAR(10))
AS
Begin;
IF EXISTS(select InsID from Instructors where InsID=@INS_ID)
          Select * from Instructors where InsID=@INS_ID 
ELSE
       PRINt 'Input Valid Data'
End;

--------->UPDATE Ins
GO
CREATE Procedure Update_Instructor
(@INS_ID      VARCHAR(10),
 @INPUT       VARCHAR(10),
 @UPDATED     VARCHAR(10)
 )
AS
Begin;
     IF EXISTS (select InsID from Instructors where InsID= @INS_ID)
     Begin;
       IF @INPUT='ID'
          BEGIN
             UPDATE Instructors SET InsID=@UPDATED WHERE InsID=@INS_ID
          END
       ELSE IF @INPUT='SSN'
          BEGIN
             UPDATE Instructors SET InsSSN=@UPDATED WHERE InsID=@INS_ID
          END
       ELSE IF @INPUT='NAME'
          BEGIN
             UPDATE Instructors SET InsName=@UPDATED WHERE InsID=@INS_ID
          END
       ELSE IF @INPUT='BirthDate'
          BEGIN
             UPDATE Instructors SET InsBirthDate=CONVERT(date,@UPDATED) WHERE InsID=@INS_ID
          END
       ELSE IF @INPUT='GENDER'
          BEGIN
             UPDATE Instructors SET InsGender=@UPDATED WHERE InsID=@INS_ID
          END
       ELSE IF @INPUT='CITY'
          BEGIN
             UPDATE Instructors SET InsCity=@UPDATED WHERE InsID=@INS_ID
          END
       ELSE IF @INPUT='PHONE'
          BEGIN
             UPDATE Instructors SET InsPhone=@UPDATED WHERE InsID=@INS_ID
          END
       ELSE IF @INPUT='BRANCH'
   BEGIN
     UPDATE Instructors SET InsBranch=@UPDATED WHERE InsID=@INS_ID
   END
ELSE IF @INPUT='EMAIL'
   BEGIN
     UPDATE Instructors SET InsEmail=@UPDATED WHERE InsID=@INS_ID
   END
ELSE IF @INPUT='PASS'
   BEGIN
     UPDATE Instructors SET InsPass=@UPDATED WHERE InsID=@INS_ID
   END
ELSE IF @INPUT='YEARS'
   BEGIN
     UPDATE Instructors SET YearsofExperience=@UPDATED WHERE InsID=@INS_ID
   END
END; 
Else 
     print'Input Valid Data'
End;



--------->Insert Ins
GO
CREATE Procedure Insert_Instructor
(@INS_ID     VARCHAR,
 @INS_SSN    VARCHAR,
 @INS_NAME   VARCHAR,
 @INS_BIRTH  DATE,
 @INS_GENDER VARCHAR,
 @INS_CITY   VARCHAR,
 @INS_PHONE  VARCHAR,
 @YEARS      INT,
 @INS_BRANCH VARCHAR,
 @INS_EMAIL  VARCHAR,
 @INS_PASS   VARCHAR)
AS
Begin;
If NOT Exists(select InsID from Instructors where InsID= @INS_ID)
              Insert into Instructors(InsID,InsSSN,InsName,InsBirthDate,
                        InsGender,InsCity,InsPhone,YearsofExperience,
						InsBranch,InsEmail,InsPass)
              Values (@INS_ID,@INS_SSN,@INS_NAME,
                      @INS_BIRTH,@INS_GENDER,@INS_CITY,
		              @INS_PHONE,@YEARS,@INS_BRANCH,@INS_EMAIL,@INS_PASS)
ELSE
    print 'Input Valid Data'

End;

--------->Delete Ins

GO
CREATE Procedure Delete_Instructor
(@INS_ID VARCHAR)
AS
Begin;
IF EXISTS (SELECT InsID FROM Instructors WHERE InsID= @INS_ID)
           Delete from Instructors where InsID=@INS_ID
ELSE 
    PRINT 'Input Valid Data'
End;
--------------------------------Ins_Crs Table--------------------------------

GO
------>Select Ins_Crs
CREATE Procedure Select_Ins_Crs
(@INS_ID VARCHAR(10),
 @CRS_ID VARCHAR(10))
AS
Begin;
IF EXISTS (SELECT InsID , CrsID FROM InsCrs WHERE InsID=@INS_ID AND CrsID=@CRS_ID)
           select * FROM InsCrs
           where InsID =@INS_ID AND CrsID=@CRS_ID
ELSE 
    Print 'Input Valid Data'
End;

GO
---------Update Ins_Crs
CREATE Procedure Update_Ins_Crs
(@INS_ID   VARCHAR(10),
 @CRS_ID   VARCHAR(10),
 @INPUT    VARCHAR(10),
 @UPDATED  VARCHAR(10))
AS
Begin;
IF EXISTS(SELECT InsID , CrsID FROM InsCrs WHERE InsID=@INS_ID AND CrsID=@CRS_ID)
IF @INPUT='INSTRUCTOR_ID'
   BEGIN
     UPDATE InsCrs SET InsID=@UPDATED WHERE InsID=@INS_ID AND CrsID=@CRS_ID
   END
ELSE IF @INPUT='CRS_ID'
   BEGIN
     UPDATE InsCrs SET CrsID=@UPDATED WHERE InsID=@INS_ID AND CrsID=@CRS_ID
   END
ELSE 
   Print'Input Valid Data'
End;

GO
-----------Insert Ins_Crs
CREATE Procedure Insert_Ins_Crs
(@INS_ID   VARCHAR,
 @CRS_ID   VARCHAR)
AS
Begin;
IF NOT EXISTS (SELECT InsID , CrsID FROM InsCrs WHERE InsID=@INS_ID AND CrsID=@CRS_ID)
               insert into InsCrs(InsID, CrsID)
               values (@INS_ID, @CRS_ID)
ELSE 
  Print'Input Valid Data'
End;

------------Delete Ins_Crs
GO
CREATE Procedure Delete_Ins_Crs
(@INS_ID VARCHAR(10),
 @CRS_ID VARCHAR(10))
AS
Begin;
IF EXISTS (SELECT InsID , CrsID FROM InsCrs WHERE InsID=@INS_ID AND CrsID=@CRS_ID)
          Delete from InsCrs
          where InsID =@INS_ID AND CrsID=@CRS_ID
ELSE 
  Print 'Input Valid Data'
End;

----------------------------Ins_Track Table------------------------------------

GO
-------Select Ins_Track
CREATE Procedure Select_Ins_Track
(@INS_ID    VARCHAR(10),
 @TRACK_ID  VARCHAR(10))
AS
Begin;
if EXISTS (select InsID, TrackID from InsTrack where InsID=@INS_ID AND TrackID=@TRACK_ID)
           select * FROM InsTrack
           where InsID =@INS_ID AND TrackID=@TRACK_ID
ELSE 
   PRINT 'Input Valid Data'
End;

GO
-------->update Ins_Track
CREATE Procedure Update_Ins_Track
(@INS_ID   VARCHAR(10),
 @Track_ID VARCHAR(10),
 @INPUT    VARCHAR(10),
 @UPDATED  VARCHAR(10))
AS
Begin;
if exists (select InsID, TrackID from InsTrack where InsID=@INS_ID AND TrackID=@TRACK_ID)
IF @INPUT='INSTRUCTOR_ID'
   BEGIN
     UPDATE InsTrack SET InsID=@UPDATED WHERE InsID=@INS_ID AND TrackID=@Track_ID
   END
ELSE IF @INPUT='TRACK_ID'
   BEGIN
     UPDATE InsTrack SET TrackID=@UPDATED WHERE InsID=@INS_ID AND TrackID=@Track_ID
   END
else 
  print 'Input Valid Data'
End;

GO
--------------Insert Ins_Track
CREATE Procedure Insert_Ins_Track
(@INS_ID   VARCHAR(10),
 @Track_ID VARCHAR(10))
AS
Begin;
if not  exists (select InsID, TrackID from InsTrack where InsID=@INS_ID AND TrackID=@TRACK_ID)
               insert into InsTrack (InsID, TrackID)
               values (@INS_ID, @Track_ID)
else 
  print 'Input Valid Data'
End;

GO
------------>Delete Ins_Track
CREATE Procedure Delete_Ins_Track
(@INS_ID    VARCHAR(10),
 @TRACK_ID  VARCHAR(10))
AS
Begin;
if exists (select InsID, TrackID from InsTrack where InsID=@INS_ID AND TrackID=@TRACK_ID)
           Delete from InsTrack
           where InsID =@INS_ID AND TrackID=@TRACK_ID
else 
  print'Input Valid Data'
End;

------------------------------TrackCrs Table-------------------------------------

GO
----->select TrackCrs
CREATE Procedure Select_TrackCrs
(@TRACK_ID VARCHAR(10),
 @CRS_ID   VARCHAR(10))
AS
Begin;
if exists (select TrackID, CrsID from TrackCrs where TrackID=@TRACK_ID AND CrsId=@CRS_ID)
           SELECT * FROM TrackCrs WHERE TrackID=@TRACK_ID AND CrsID=@CRS_ID
else 
  print 'Input Valid Data'
End;

GO
-------------update TrackCrs
CREATE Procedure Update_TrackCrs
(@TRACK_ID VARCHAR(10),
 @CRS_ID   VARCHAR(10),
 @INPUT    VARCHAR(10),
 @UPDATED  VARCHAR(10))
AS
Begin;
if exists (select TrackID, CrsID from TrackCrs where TrackID=@TRACK_ID AND CrsId=@CRS_ID)

IF @INPUT='TRACK_ID'
   BEGIN
     UPDATE TrackCrs SET TrackID=@UPDATED WHERE TrackID=@TRACK_ID AND CrsID=@CRS_ID
   END
ELSE IF @INPUT='CRS_ID'
   BEGIN
     UPDATE TrackCrs SET CrsID=@UPDATED WHERE TrackID=@TRACK_ID AND CrsID=@CRS_ID
   END
ELSE IF @INPUT='T_TYPE'
   BEGIN
     UPDATE TrackCrs SET T_Type=@UPDATED WHERE TrackID=@TRACK_ID AND CrsID=@CRS_ID
   END
ELSE IF @INPUT='DURATION'
   BEGIN
     UPDATE TrackCrs SET CrsDuration=CONVERT(INT,@UPDATED) WHERE TrackID=@TRACK_ID AND CrsID=@CRS_ID
   END
else 
  print'Input valid Data'
End;

GO
--------->Insert TrackCrs
CREATE Procedure Insert_TrackCrs
(@TRACK_ID VARCHAR,
 @CRS_ID   VARCHAR,
 @T_TYPE   VARCHAR,
 @DURATION INT )
AS
Begin;
if exists (select TrackID, CrsID from TrackCrs where TrackID=@TRACK_ID AND CrsId=@CRS_ID)
           INSERT INTO TrackCrs (TrackID, CrsID, T_Type, CrsDuration)
           VALUES (@TRACK_ID, @CRS_ID, @T_TYPE, @DURATION)
else 
  print 'Input Valid Data'
End;

GO
------------->Delete TrackCrs
CREATE Procedure Delete_TrackCrs
(@TRACK_ID VARCHAR(10),
 @CRS_ID   VARCHAR(10))
AS
Begin;
if exists (select TrackID, CrsID from TrackCrs where TrackID=@TRACK_ID AND CrsId=@CRS_ID)
           DELETE FROM TrackCrs WHERE TrackID=@TRACK_ID AND CrsID=@CRS_ID
else 
  print 'Input Valid Data'
End;

-------------------------------------------------------------------

---------------------------------Questions------------------------------------------
-----> Select from  Questions Table
GO
create proc GetQues @id varchar (10)
as 
	select * 
	from Questions
	where QuesID= @id

-----> Insert into Questions Table
GO
create proc InsertinQues
@Quesid varchar (10) , @question varchar (200),@choice1 varchar (100),@choice2 varchar (100),@choice3 varchar (100),@choice4 varchar (100), @Answer varchar (100),@Grade int, @QuesType varchar (3),
@CrsId varchar (10)
as 
	begin try
		insert into Questions
		values (@Quesid,@question,@choice1,@choice2,@choice3,@choice4,@Answer,@Grade,@QuesType,@CrsId)
	end try 
	begin catch 
		select 'Error'
	end catch

-----> Delete rows from Questions Table
GO
create proc DeleteQues @id varchar (10)
as 
	begin 
	delete from Questions
	where QuesID= @id
	end

-----> Update rows from Questions Table
GO
create proc UpQues
(
@Quesid		VARCHAR(10),
@question			VARCHAR(200) ='TestValue',
@choice1		VARCHAR(100) ='TestValue',
@choice2		VARCHAR(100) ='TestValue',
@choice3		VARCHAR(100) ='TestValue',
@choice4		VARCHAR(100) ='TestValue',
@answer		VARCHAR(100) ='TestValue',
@grade		int ='TestValue',
@questype		VARCHAR(3) ='TestValue',
@crsid		VARCHAR(10) ='TestValue'
)
AS
BEGIN;
	IF EXISTS (SELECT QuesID FROM Questions WHERE QuesID = @Quesid)
	BEGIN;
		IF @question != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET Question = @question WHERE QuesID = @Quesid
		END;
		IF @choice1 != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET Choice1 = @choice1 WHERE QuesID = @Quesid
		END;
		IF @choice2 != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET Choice2 = @choice2 WHERE QuesID = @Quesid
		END;
		IF @choice3 != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET Choice3 = @choice3 WHERE QuesID = @Quesid
		END;
		IF @choice4 != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET Choice4 = @choice4 WHERE QuesID = @Quesid
		END;
		IF @answer != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET Answer = @answer WHERE QuesID = @Quesid
		END;
		IF @grade != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET QuesGrade = CONVERT(INT,@grade) WHERE QuesID = @Quesid
		END;
		IF @questype != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET QuesType = @questype WHERE QuesID = @Quesid
		END;
		IF @crsid != 'TestValue'
		BEGIN;
			UPDATE Questions
				SET CrsID = @crsid WHERE QuesID = @Quesid		
		END;
	END;
	ELSE
		SELECT ('Error')
END;

---------------------------Student_Freelance-----------------------------
--> INSERT Freelance
GO
create proc InsStdFL @Stdid varchar (10), @Freelanceid varchar (10),  @JobDate Date,@JobMoney decimal(18,0), @Employer varchar(50)
as 
begin try 
insert into Student_Freelance
values ( @Stdid, @Freelanceid, @JobDate, @JobMoney, @Employer)
end try
begin catch
select 'This Freelance Job already exists.' 
end catch 


--> Delete Freelance
GO
create proc DeleteStdFL @Stdid varchar (10), @Freelanceid varchar (10)
as 
Begin try
delete from Student_Freelance
where StdID = @Stdid and FreelanceID = @Freelanceid
end try
begin catch 
select ' You can''t Delete This Freelance Job'
end catch


--> Update Freelance
GO
create PROCEDURE UpdateFL
(
@StdID		        VARCHAR(10),
@FreelanceID		VARCHAR(10),
@StdID2		    VARCHAR(10)='TestValue',
@FreelanceID2		VARCHAR(10) ='TestValue',
@JobDate			date ='1/1/1970',
@JobMoney 			decimal(18, 0) =-1,
@Employer    		VARCHAR(50) ='TestValue'

)
AS
BEGIN;
	IF EXISTS (SELECT StdID FROM Student_Freelance WHERE StdID = @StdID and FreelanceID=@FreelanceID )
	BEGIN;
		IF @StdID2 != 'TestValue'
		BEGIN;
			UPDATE Student_Freelance
				SET StdID	 = @StdID  WHERE StdID = @StdID and FreelanceID=@FreelanceID
		END;
		IF @FreelanceID2 != 'TestValue'
		BEGIN;
			UPDATE Student_Freelance
				SET FreelanceID = @FreelanceID2  WHERE StdID = @StdID and FreelanceID=@FreelanceID
		END;
		IF @JobDate != '1/1/1970'
		BEGIN;
			UPDATE Student_Freelance
				SET @JobDate = CONVERT(date,@JobDate)  WHERE StdID = @StdID and FreelanceID=@FreelanceID
		END;
		IF @JobMoney != -1
		BEGIN;
			UPDATE Student_Freelance
				SET JobMoney = @JobMoney    WHERE StdID = @StdID and FreelanceID=@FreelanceID
		END;
		IF @Employer != 'TestValue'
		BEGIN;
			UPDATE Student_Freelance
				SET Employer = @Employer   WHERE StdID = @StdID and FreelanceID=@FreelanceID
		END;
	END;
	ELSE
		SELECT ('The Freelance Job doesn''t exist')
END;


--> Select All freelance for one student
GO
create proc SelcStdFL @StdId Varchar(10) 
as 
begin try 
select * from Student_Freelance 
where StdID = @StdId
end try 
begin catch
select ' There is no Freelance Jobs For This Student ' 
end catch 

--> Select freelance jobs with it id
GO
create proc SelcFL @Stdid varchar (10), @Freelanceid varchar (10)
as 
begin try 
select * from Student_Freelance 
where StdID = @StdId and FreelanceID=@Freelanceid
end try 
begin catch
select 'Error Getting This Job ' 
end catch 

--------------------------------------TakeExam--------------------------------
--> Insert Exam
GO
create proc InsTExam @ExID int, @StdID varchar (10), @QuesID varchar (10), @StudAns varchar(100),@StdGrade int
as 
begin try 
insert into TakeExam
values ( @ExID, @StdID, @QuesID, @StudAns, @StdGrade)
end try
begin catch
select 'This Exam Question already exists.' 
end catch 


--> Delete Exam Question
GO
create proc DeleteExamQues @ExID int, @StdID varchar (10), @QuesID varchar (10)
as 
Begin try
delete from TakeExam
where ExID = @ExID and StdID = @StdID and QuesID=@QuesID
end try
begin catch 
select ' You can''t Delete This Exam Question'
end catch

--> Delete Exam 
GO
create proc DeleteTExam @ExID int
as 
Begin try
delete from TakeExam
where ExID = @ExID
end try
begin catch 
select ' You can''t Delete This Exam'
end catch

--> Update Exam
GO
create PROCEDURE UpdateTExam
(
@ExID		        int,
@StdID		    VARCHAR(10),
@QuesID		    VARCHAR(10),
@ExID2		        int=-1,
@StdID2		    VARCHAR(10)='TestValue',
@QuesID2	    VARCHAR(10)='TestValue',
@StudAns		VARCHAR(100) ='TestValue',
@StdGrade			int =-1
)
AS
BEGIN;
	IF EXISTS (SELECT StdID FROM TakeExam WHERE ExID=@ExID and StdID = @StdID and QuesID=@QuesID )
	BEGIN;
		IF @ExID2 != -1
		BEGIN;
			UPDATE TakeExam
				SET ExID = @ExID2 where ExID = @ExID and StdID = @StdID and QuesID=@QuesID
		END;
		IF @StdID2 != 'TestValue'
		BEGIN;
			UPDATE TakeExam
				SET StdID = @StdID2  where ExID = @ExID and StdID = @StdID and QuesID=@QuesID

		END;
		IF @QuesID2 != 'TestValue'
		BEGIN;
			UPDATE TakeExam
				SET QuesID = CONVERT(VARCHAR,@QuesID2) where ExID = @ExID and StdID = @StdID and QuesID=@QuesID
		END;
		IF @StudAns != 'TestValue'
		BEGIN;
			UPDATE TakeExam
				SET StudAns = @StudAns    where ExID = @ExID and StdID = @StdID and QuesID=@QuesID
		END;
		IF @StdGrade != -1
		BEGIN;
			UPDATE TakeExam
				SET StdGrade = @StdGrade   where ExID = @ExID and StdID = @StdID and QuesID=@QuesID
		END;
	END;
	ELSE
		SELECT ('The Exam Question  doesn''t exist')
END;

--> Select All Questions for one Exam
GO
create proc SelcTTExam @ExID Varchar(10) 
as 
begin try 
select * from TakeExam
where ExID = @ExID
end try 
begin catch
select ' There is no Questions Jobs For This Exam ' 
end catch 


--> Select Questions with it id 
GO
create proc SelcTExamQues @ExID int, @StdID varchar (10), @QuesID varchar (10)
as 
begin try 
select * from TakeExam 
where ExID = @ExID and StdID = @StdID and QuesID=@QuesID
end try 
begin catch
select 'Error Getting This Exam Question ' 
end catch 

-------------------------------------------------------------------

--------------------------------------Exam--------------------------------
--> Insert Exam
GO
create proc InsExam @ExID int,@TotalResult int, @ExDate Date, @CrsID varchar (10)
as 
begin try 
insert into Exam
values ( @ExID, @TotalResult, @ExDate, @CrsID)
end try
begin catch
select 'This Exam already exists.' 
end catch 


--> Delete Exam
GO
create proc DeleteExam @ExID int
as 
Begin try
delete from Exam
where ExID = @ExID
end try
begin catch 
select ' You can''t Delete This Exam'
end catch

--> Update Exam
GO
create PROCEDURE UpdateExam
(
@ExID int,
@ExID2 int=-1,
@TotalResult int=-1,
@ExDate Date='1/1/1970',
@CrsID varchar (10)='TestValue'
)
AS
BEGIN;
	IF EXISTS (SELECT ExID FROM Exam WHERE ExID=@ExID )
	BEGIN;
		IF @ExID2 != -1
		BEGIN;
			UPDATE Exam
				SET ExID = @ExID2 where ExID = @ExID 
		END;
		IF @TotalResult != -1
		BEGIN;
			UPDATE Exam
				SET TotalResult = @TotalResult   where ExID = @ExID 
		END;
		IF @ExDate != '1/1/1970'
		BEGIN;
			UPDATE Exam
				SET ExDate = CONVERT(Date,@ExDate) where ExID = @ExID
		END;
		IF @CrsID != 'TestValue'
		BEGIN;
			UPDATE Exam
				SET CrsID = @CrsID    where ExID = @ExID 
		END;

	END;
	ELSE
		SELECT ('The Exam Doesn''t Exist')
END;

--> Select Exam
GO
create proc SelectExam @ExID Varchar(10) 
as 
begin try 
select * from Exam
where ExID = @ExID
end try 
begin catch
select ' This Exam Doesn''t Exist' 
end catch 

-------------------------------------------------------------------

------------------------------STUDENT TABLE-----------------------------------------------
-----> Select from student table

CREATE PROCEDURE SelectStudents
(
@StudID			VARCHAR(10)
)
AS
BEGIN;
	IF EXISTS (SELECT StdID FROM Students WHERE StdID = @StudID)
		BEGIN;
			SELECT [StdID],[StdSSN],[StdName],[StdBirthDate],[StdCity]
			FROM Students
			WHERE StdID = @StudID
		END;
	ELSE
		PRINT('The student doen''t exist')
END;

-----> Insert Student Information

CREATE PROCEDURE InsertStudent
(
@ID			VARCHAR(10),
@SSN		VARCHAR(14),
@NAME		VARCHAR(100),
@DOB		DATE,
@GENDER		VARCHAR(1),
@CITY		VARCHAR(50),
@PHONE		VARCHAR(11),
@JOINDATE	DATE,
@GRADDATE	DATE,
@FAC		VARCHAR(50),
@SPEC		VARCHAR(50),
@GRADGRADE	VARCHAR(2),
@GRADYR		INT,
@SCORE		DECIMAL,
@ROUND		VARCHAR(1),
@GRADE		VARCHAR(1),
@CERT		VARCHAR(20),
@FREELANC	VARCHAR(20),
@GRADPROJ	VARCHAR(1),
@STATUS		VARCHAR(10),
@EMAIL		VARCHAR(100),
@PASS		VARCHAR(50),
@TRACK		VARCHAR(10)
)
AS
BEGIN;
	IF NOT EXISTS (SELECT S.StdID FROM Students S WHERE S.StdID = @ID)
		BEGIN;
			INSERT INTO Students
				VALUES(@ID,@SSN,@NAME,@DOB,@GENDER,@CITY,@PHONE,@JOINDATE,@GRADDATE,@FAC,@SPEC,@GRADGRADE,@GRADYR,@SCORE,@ROUND,@GRADE,@CERT,@FREELANC,@GRADPROJ,@STATUS,@EMAIL,@PASS,@TRACK)
		END;
	ELSE
		PRINT ('The student already exists')
END;

------> Delete from student

CREATE PROCEDURE DeleteStudent
(
@ID	VARCHAR(10)
)
AS
BEGIN;
	IF EXISTS (SELECT S.StdID FROM Students S WHERE S.StdID = @ID)
		BEGIN;
			DELETE FROM Students
				WHERE StdID = @ID
		END;
	
	ELSE
		PRINT('The student doesn''t exist')
END;

------> UPDATE STUDENT TABLE

CREATE PROCEDURE UpdateStudent
(
@ID			VARCHAR(10),
@SSN		VARCHAR(14) ='***',
@NAME		VARCHAR(100) ='***',
@DOB		VARCHAR(10) ='***',
@GENDER		VARCHAR(10) ='***',
@CITY		VARCHAR(50) ='***',
@PHONE		VARCHAR(11) ='***',
@JOINDATE	VARCHAR(10) ='***',
@GRADDATE	VARCHAR(10) ='***',
@FAC		VARCHAR(50) ='***',
@SPEC		VARCHAR(50) ='***',
@GRADGRADE	VARCHAR(10) ='***',
@GRADYR		VARCHAR(10) ='***',
@SCORE		VARCHAR(10) ='***',
@ROUND		VARCHAR(1) ='***',
@GRADE		VARCHAR(1) ='***',
@CERT		VARCHAR(20) ='***',
@FREELANC	VARCHAR(20) ='***',
@GRADPROJ	VARCHAR(1) ='***',
@STATUS		VARCHAR(10) ='***',
@EMAIL		VARCHAR(100) ='***',
@PASS		VARCHAR(50) ='***',
@TRACK		VARCHAR(10) ='***'
)
AS
BEGIN;
	IF EXISTS (SELECT StdID FROM Students WHERE StdID = @ID)
		BEGIN;
			IF @SSN != '***'
				BEGIN;
					UPDATE Students
						SET StdSSN = @SSN
						WHERE StdID = @ID
				END;
			IF @NAME != '***'
				BEGIN;
					UPDATE Students
						SET StdName = @NAME
						WHERE StdID = @ID
				END;
			IF @DOB != '***'
				BEGIN;
					UPDATE Students
						SET StdBirthDate = CONVERT(DATE,@DOB)
						WHERE StdID = @ID
				END;
			IF @GENDER != '***'
				BEGIN;
					UPDATE Students
						SET StdGender = CONVERT(VARCHAR(1),@GENDER)
						WHERE StdID = @ID
				END;
			IF @CITY != '***'
				BEGIN;
					UPDATE Students
						SET StdCity = @CITY
						WHERE StdID = @ID
				END;
			IF @PHONE != '***'
				BEGIN;
					UPDATE Students
						SET StdPhone = @PHONE
						WHERE StdID = @ID
				END;
			IF @JOINDATE != '***'
				BEGIN;
					UPDATE Students
						SET StdJoinDate = CONVERT(DATE,@JOINDATE)
						WHERE StdID = @ID
				END;
			IF @GRADDATE != '***'
				BEGIN;
					UPDATE Students
						SET StdGradDate = CONVERT(DATE,@GRADDATE)
						WHERE StdID = @ID
				END;
			IF @FAC != '***'
				BEGIN;
					UPDATE Students
						SET StdFaculty = @FAC
						WHERE StdID = @ID
				END;
			IF @SPEC != '***'
				BEGIN;
					UPDATE Students
						SET StdSpecialization = @SPEC
						WHERE StdID = @ID
				END;
			IF @GRADGRADE != '***'
				BEGIN;
					UPDATE Students
						SET StdUniGradGrade = CONVERT(VARCHAR(2),@GRADGRADE)
						WHERE StdID = @ID
				END;
			IF @GRADYR != '***'
				BEGIN;
					UPDATE Students
						SET StdUniGradYear = CONVERT(INT,@GRADYR)
						WHERE StdID = @ID
				END;
			IF @SCORE != '***'
				BEGIN;
					UPDATE Students
						SET StdAcceptanceScore = CONVERT(DECIMAL,@SCORE)
						WHERE StdID = @ID
				END;
			IF @ROUND != '***'
				BEGIN;
					UPDATE Students
						SET StdRound = CONVERT(VARCHAR(1),@ROUND)
						WHERE StdID = @ID
				END;
			IF @GRADE != '***'
				BEGIN;
					UPDATE Students
						SET StdGrade = CONVERT(VARCHAR(1),@GRADE)
						WHERE StdID = @ID
				END;
			IF @CERT != '***'
				BEGIN;
					UPDATE Students
						SET StdCertificateKPI = @CERT
						WHERE StdID = @ID
				END;		
			IF @FREELANC != '***'
				BEGIN;
					UPDATE Students
						SET StdFreelancingKPI = @FREELANC
						WHERE StdID = @ID
				END;
			IF @GRADPROJ != '***'
				BEGIN;
					UPDATE Students
						SET StdGradProjectGrade = CONVERT(VARCHAR(1),@GRADPROJ)
						WHERE StdID = @ID
				END;	
			IF @STATUS != '***'
				BEGIN;
					UPDATE Students
						SET StdStatus = @STATUS
						WHERE StdID = @ID
				END;
			IF @EMAIL != '***'
				BEGIN;
					UPDATE Students
						SET StdEmail = @EMAIL
						WHERE StdID = @ID
				END;
			IF @PASS != '***'
				BEGIN;
					UPDATE Students
						SET StdPass = @PASS
						WHERE StdID = @ID
				END;			
			IF @TRACK != '***'
				BEGIN;
					UPDATE Students
						SET StdTrackID = @TRACK
						WHERE StdID = @ID
				END;	
		END;
	ELSE
		PRINT('The student doesn''t exist')
END;


--------------------------------------Freelance_Title------------------------------------------------------
-----> Select from Freelancing_Tittle Table
GO
create proc Getfreelancetitle @titleid varchar (10)
as 
	select * 
	from Freelancing_Tittle
	where TitleID= @titleid


-----> Insert into Freelancing_Tittle Table
GO
create proc Insertinfreelancetitle
@titleid varchar (10) , @title varchar (50)
as 
	begin try
		insert into Freelancing_Tittle 
		values (@titleid,@title)
	end try 
	begin catch 
		select 'Error'
	end catch

-----> Delete rows from Freelancing_Tittle Table
GO
create proc Deletefreelancetitle @titleid varchar (10)
as 
	begin 
	delete from Freelancing_Tittle  
	where TitleID = @titleid
	end

-----> Update rows from Freelancing_Tittle Table
GO
create proc Upfreelancetitle
(
@titleid			VARCHAR(10),
@title			VARCHAR(50) ='TestValue'
)
AS
BEGIN;
	IF EXISTS (SELECT TitleID FROM Freelancing_Tittle  WHERE TitleID = @titleid)
	BEGIN;
		IF @title!= 'TestValue'
		BEGIN;
			UPDATE Freelancing_Tittle 
				SET Title = @title WHERE TitleID = @titleid
		END;
	END;
	ELSE
		SELECT ('Error')
END;


-------------------------------SupTrack-------------------

--->Select From SupTrack
GO
create procedure Select_Supervision
(@TRACK_ID VARCHAR(10),
 @SUPER_ID VARCHAR(10))
AS
BEGIN;
IF EXISTS(SELECT TrackID, SupervisorID from SupTrack where TrackID=@TRACK_ID and SupervisorID=@SUPER_ID)
   select * from SupTrack where TrackID=@TRACK_ID and SupervisorID=@SUPER_ID
else 
   print 'Input Valid Data' 
END;

--->Update SupTrack
GO
Create procedure Update_super
(@track_id varchar(10),
 @super_id varchar(10),
 @input    varchar(10),
 @updated  varchar(10))
as
begin;
if exists(SELECT TrackID, SupervisorID from SupTrack where TrackID=@track_id and SupervisorID=@super_id)
 if @input='Track_ID'
    begin 
	 update SupTrack set TrackID=@updated where TrackID=@track_id and SupervisorID=@super_id
	end
 else if @input='Super_ID'
    begin
	 update SupTrack set SupervisorID=@updated where TrackID=@track_id and SupervisorID=@super_id
	end
 else if @input='Super_Type'
    begin
	 update SupTrack set SupervisionType=@updated where TrackID=@track_id and SupervisorID=@super_id
	end
else
  print'Input Valid Data'
end;

--->Insert SupTrack
GO
create procedure insert_super
(@track_id  varchar(10),
 @super_id  varchar(10),
 @type      varchar(10))
as
begin;
if not exists(SELECT TrackID, SupervisorID from SupTrack where TrackID=@track_id and SupervisorID=@super_id)
 insert into SupTrack (TrackID, SupervisorID, SupervisionType)
 values(@track_id, @super_id, @type)
else
  print'Input Valid Data'
end;

--->Delete From SupTrack
GO
create procedure delete_super
(@track_id  varchar(10),
 @super_id  varchar(10))
as
begin;
if exists (select TrackID, SupervisorID from SupTrack where TrackID=@track_id and SupervisorID=@super_id)
   delete  from SupTrack where TrackID=@track_id and SupervisorID=@super_id
else 
  print 'Input Valid Data'
end;