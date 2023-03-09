--> GENERATE THE EXAM AND INSERT INTO EXAM, TAKEEXAM TABLES
GO
CREATE PROCEDURE GenerateExam
(
@CourseID		VARCHAR(10),
@StudentID		VARCHAR(10),
@MCQ			INT,
@TF				INT
)
AS
BEGIN;
	DECLARE @ExamID INT
	SELECT @ExamID = FLOOR(RAND() * (100000000 - 1 + 1)) + 1

	---> Insert basic exam information
	INSERT INTO Exam (ExID,CrsID ,ExDate)
		VALUES(@ExamID, @CourseID, GETDATE())
	
	---> Insert ID of MCQ questions
	INSERT INTO TakeExam (QuesID, ExID, StdID)
		SELECT TOP (@MCQ) QuesID, @ExamID, @StudentID
		FROM Questions
		WHERE CrsID = @CourseID AND QuesType = 'MCQ'
		ORDER BY NEWID()

	---> Insert ID of TF questioins
	INSERT INTO TakeExam (QuesID, ExID, StdID)
		SELECT TOP (@TF) QuesID, @ExamID, @StudentID
		FROM Questions
		WHERE CrsID = @CourseID AND QuesType = 'TF'
		ORDER BY NEWID()
	SELECT 'EXAM GENERATED AND IT''S ID: '+CAST(@ExamID AS VARCHAR(100))
END;

exec GenerateExam 'DB01','12',6,4

------------------------------------------------------------

--> SHOWING THE EXAM FOR THE STUDENT
GO
alter PROCEDURE Exam_Show
(
@ExamID		INT
)
AS
BEGIN;
DROP TABLE ExamShow
SELECT Dense_rank() OVER ( ORDER BY Q.QuesID) 'QuestionNumber',T.ExID,Q.QuesID,Q.Question, Q.Choice1, Q.Choice2, Q.Choice3, Q.Choice4 into ExamShow
FROM QUESTIONS Q, TakeExam T
WHERE Q.QuesID = T.QuesID AND T.ExID = @ExamID
SELECT *FROM ExamShow
END;
exec Exam_Show 56874914
------------------------------------------------------------
--> INSERTING STUDENT ANSWERS INTO TAKEEXAM TABLE 
GO
alter PROCEDURE ExamAns (@ExID int, @StID int,@QuesID1 varchar(10),@StdAns1 varchar(10),@QuesID2 varchar(10),@StdAns2 varchar(10),
@QuesID3 varchar(10),@StdAns3 varchar(10),@QuesID4 varchar(10),@StdAns4 varchar(10),@QuesID5 varchar(10),@StdAns5 varchar(10),
@QuesID6 varchar(10),@StdAns6 varchar(10),@QuesID7 varchar(10),@StdAns7 varchar(10),@QuesID8 varchar(10),@StdAns8 varchar(10) ,
@QuesID9 varchar(10),@StdAns9 varchar(10),@QuesID10 varchar(10),@StdAns10 varchar(10))
AS
declare @code varchar(MAX)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns1 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID1 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID1 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns2 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID2 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID2 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns3 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID3 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID3 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns4 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID4 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID4 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns5 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID5 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID5 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns6 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID6 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID6 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns7 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID7 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID7 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns8 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID8 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID8 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns9 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID9 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID9 as varchar(50))
exec (@code)
set @code= '
UPDATE te
SET te.StudAns = es.Choice
FROM TakeExam te, 
	(SELECT ExID,'+cast(@StdAns10 as varchar(50))+' Choice 
	FROM ExamShow
	WHERE QuesID='+cast(@QuesID10 as varchar(50))+' and ExID='+cast(@ExID as varchar(50))+' )es
WHERE te.ExID=es.ExID and te.StdID='+cast(@StID as varchar(50))+' and te.QuesID='+cast(@QuesID10 as varchar(50))
exec (@code)

exec ExamAns 56874914,12,'''DB11''','Choice1','''DB13''','Choice1','''DB14''','Choice1','''DB15''','Choice1','''DB2''','Choice2','''DB3''','Choice1','''DB5''','Choice1',
'''DB7''','Choice4','''DB8''','Choice3','''DB9''','Choice2'
------------------------------------------------------------

--> CORRECT STUDENT ANSWERS, INSERT THE GRADE INTO TAKEEXAM TABLE
GO
CREATE PROCEDURE ExamCorrection (@ExID int, @StID varchar(10),@QuesID1 varchar(10),@QuesID2 varchar(10),
@QuesID3 varchar(10),@QuesID4 varchar(10),@QuesID5 varchar(10),
@QuesID6 varchar(10),@QuesID7 varchar(10),@QuesID8 varchar(10),
@QuesID9 varchar(10),@QuesID10 varchar(10))
AS
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID1 and StudAns =(select Answer from Questions where QuesID=@QuesID1)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID2 and StudAns =(select Answer from Questions where QuesID=@QuesID2)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID3 and StudAns =(select Answer from Questions where QuesID=@QuesID3)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID4 and StudAns =(select Answer from Questions where QuesID=@QuesID4)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID5 and StudAns =(select Answer from Questions where QuesID=@QuesID5)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID6 and StudAns =(select Answer from Questions where QuesID=@QuesID6)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID7 and StudAns =(select Answer from Questions where QuesID=@QuesID7)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID8 and StudAns =(select Answer from Questions where QuesID=@QuesID8)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID9 and StudAns =(select Answer from Questions where QuesID=@QuesID9)
UPDATE TakeExam 
SET StdGrade = 5
WHERE ExID=@ExID and StdID=@StID and QuesID=@QuesID10 and StudAns =(select Answer from Questions where QuesID=@QuesID10)

exec ExamCorrection 56874914,12,'DB11','DB13','DB14','DB15','DB2',
'DB3','DB5','DB7','DB8','DB9'
------------------------------------------------------------

--> CALCULATE TOTAL RESULT AND INSERT IT TO TAKEEXAM TABLE
GO
CREATE PROCEDURE GradeCalc (@ExID int, @StID varchar(10))
AS
UPDATE exam 
SET TotalResult= (SELECT SUM(stdgrade) 
					FROM TakeExam
					WHERE ExID=@ExID and StdID=@StID)
					WHERE ExID=@ExID

exec GradeCalc 56874914,12
------------------------------------------------------------

--> SHOWING EXAM QUESTIONS, STUDENT ANSWERS AND TOTAL RESULT
GO
CREATE PROCEDURE ShowExamGrade
(
@StdID	INT,
@ExamID	VARCHAR(10)
)
AS
BEGIN;
	SELECT QUESTION, StudAns AS [Student Answer], StdGrade AS Grade
	FROM TakeExam, Questions
	WHERE StdID = @StdID AND ExID = @ExamID AND TakeExam.QuesID=Questions.QuesID
	UNION ALL
	SELECT ' ','Total Result',TotalResult
	FROM Exam
	WHERE ExID = @ExamID

END;

exec ShowExamGrade 12,56874914
