CREATE DATABASE TRIGGERS_EXAMPLE
GO
USE  TRIGGERS_EXAMPLE
GO
CREATE SCHEMA [class02]
GO
CREATE TABLE [class02].[student](
	[student_id] [bigint] NOT NULL,
	[name] [nvarchar](max) NOT NULL
)
GO
CREATE TABLE [class02].[history_logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime2](7)NOT NULL,
	[Description][nvarchar](max)NOT NULL
)
GO

-- INSERT TRIGGER- student table
CREATE OR ALTER TRIGGER trg_insertLog_student
ON [class02].[student]
AFTER INSERT
AS
BEGIN
	DECLARE @Description nvarchar(max);
	SELECT  @Description= 'Se ha insertado un nuevo registro en la tabla [class02].[Student] '+
							'student_id: '+CAST(INSERTED.student_id AS nvarchar(max))+' ,'+
							'Name: '+ INSERTED.name
	FROM INSERTED;

	INSERT INTO [class02].[history_logs](Date, Description)
	VALUES (GETDATE(),@Description);
END;
GO

-- DELETE TRIGGER - Student table
CREATE OR ALTER TRIGGER trg_deleteLog_student
ON [class02].[student]
AFTER DELETE
AS
BEGIN
	DECLARE @Description nvarchar(max);

	SELECT @Description='Se ha eliminado un registro de la tabla [class02].[student]: '+
			'student_id: '+CAST(DELETED.student_id AS nvarchar(max))+' ,'+
			'Name: '+ DELETED.name
	FROM DELETED;
	INSERT INTO [class02].[history_logs](Date,Description)
	VALUES (GETDATE(),@Description);
END;

GO

-- Update trigger - student table
CREATE OR ALTER TRIGGER trg_updateLog_student
ON [class02].[student]
AFTER UPDATE
AS
BEGIN
	DECLARE @OldDescription nvarchar(max),@NewDescription nvarchar(max);

	SELECT @OldDescription='Registro modificado (Antiguo) en la tabla [class02].[student]: '+
		'student_id: '+CAST(DELETED.student_id AS nvarchar(max))+ ', '+
		'Name: '+ DELETED.name+ ',',
		 @NewDescription='Registro modificado (Nuevo) en la tabla [class02].[student]: '+
		'student_id: '+CAST(INSERTED.student_id AS nvarchar(max))+ ', '+
		'Name: '+ INSERTED.name+ ','
		FROM DELETED
		JOIN INSERTED on DELETED.student_id=INSERTED.student_id;

		INSERT INTO [class02].[history_logs](Date,Description)
		VALUES(GETDATE(),@OldDescription);

		INSERT INTO [class02].[history_logs](Date,Description)
		VALUES(GETDATE(),@NewDescription);
END;
GO


-- SELECTS
SELECT * FROM class02.history_logs;
SELECT * FROM class02.student;

-- INSERTS
INSERT INTO class02.student(student_id,name)
VALUES(202001534,'Erwin Vásquez');

INSERT INTO class02.student(student_id,name)
VALUES(20220000000,'ANONIMO');


-- UPDATES
UPDATE class02.student
SET name='New Name'
WHERE student_id=20220000000;

-- DELETIONS
DELETE FROM class02.student
WHERE student_id=20220000000;
GO

-- Initial transaction with multipe rollbacks
CREATE PROCEDURE newStudent
    @student_id bigint,
    @name NVARCHAR(MAX)
AS
BEGIN
	-- Begin transaction
	BEGIN TRANSACTION;
	-- Insert the new student
	BEGIN TRY					
    -- Verify if @student_id is a valid number
    IF ISNUMERIC(@student_id) = 1
    BEGIN
       -- Verify if the student name is valid
       IF @Name IS NOT NULL AND @name <> '' AND @name LIKE '[A-Za-z][_A-Za-z0-9 ]%'
		BEGIN
			INSERT INTO [class02].[student] ([student_id], [name])
			VALUES (@student_id, @name);
			-- Confirm the transaction
			COMMIT
			PRINT 'The student was created successfully.';
         END
        ELSE
          BEGIN
			ROLLBACK;
            PRINT 'The student name is not valid';
          END
    END
    ELSE
    BEGIN
		ROLLBACK;
        PRINT 'Invalid @student_id value. Please provide a valid number.';
    END
	END TRY
	BEGIN CATCH
		-- If an error occurs, rollback the transaction
		ROLLBACK;
		PRINT 'Error during student insertion, try again later';
	END CATCH;
END;
GO
EXEC newStudent 202300000,'112Bases'
EXEC newStudent 202300000,'Bases'
EXEC newStudent 202300000,'Clase'
SELECT * FROM class02.student;
SELECT * FROM class02.history_logs;