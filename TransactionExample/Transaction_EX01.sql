CREATE DATABASE BD2_EXAMPLES
GO
USE BD2_EXAMPLES
GO
CREATE SCHEMA [example01]
GO
CREATE TABLE [example01].[historyLogs](
	[course_id] [int] NOT NULL,
	[name][nvarchar](max)NOT NULL,
	[credits][int]NOT NULL
)


CREATE PROCEDURE newCourse
    @course_id INT,
    @name NVARCHAR(MAX),
    @credits INT
AS
BEGIN
    -- Verify if @course_id is a valid number
    IF ISNUMERIC(@course_id) = 1
    BEGIN
        -- Verify if @credits is a valid number
        IF ISNUMERIC(@credits) = 1 AND @credits>0
        BEGIN
            -- Verify if the course name is valid
            IF @Name IS NOT NULL AND @name <> '' AND @name LIKE '[A-Za-z][_A-Za-z0-9 ]%'
            BEGIN
                -- Verify if the course name not exists
                IF NOT EXISTS (SELECT 1 FROM [example01].[course] WHERE [name] = @name)
                BEGIN
					-- Verify if the course id not exists
					IF NOT EXISTS (SELECT 1 FROM [example01].[course] WHERE [course_id] = @course_id)
					BEGIN
						-- Begin transaction
						BEGIN TRANSACTION;
						-- Insert the new course
							BEGIN TRY
								INSERT INTO [example01].[course] ([course_id], [name], [credits])
								VALUES (@course_id, @name, @credits);
								-- Confirm the transaction
								COMMIT;
								PRINT 'The course was created successfully.';
							END TRY
							BEGIN CATCH
								-- If an error occurs, rollback the transaction
								ROLLBACK;
								PRINT 'Error during course insertion, try again later';
							END CATCH;
					END
					ELSE
					BEGIN
						PRINT 'The course id already exists, try with another course id';
					END
				END
                ELSE
                BEGIN
                    PRINT 'The course name already exists, try with another course name';
                END
            END
            ELSE
            BEGIN
                PRINT 'The course name is not valid';
            END
        END
        ELSE
        BEGIN
            PRINT 'Invalid @credits value. Please provide a valid number.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Invalid @course_id value. Please provide a valid number.';
    END
END;
GO

EXEC newCourse 775,"Sistemas de bases de datos 2",5;
SELECT * FROM [example01].[course];

GO

-- Initial transaction with multipe rollbacks
CREATE PROCEDURE newCourse2
    @course_id INT,
    @name NVARCHAR(MAX),
    @credits INT
AS
BEGIN
	-- Begin transaction
	BEGIN TRANSACTION;
	-- Insert the new course
	BEGIN TRY					
    -- Verify if @course_id is a valid number
    IF ISNUMERIC(@course_id) = 1
    BEGIN
        -- Verify if @credits is a valid number
        IF ISNUMERIC(@credits) = 1 AND @credits>0
        BEGIN
            -- Verify if the course name is valid
            IF @Name IS NOT NULL AND @name <> '' AND @name LIKE '[A-Za-z][_A-Za-z0-9 ]%'
            BEGIN
                -- Verify if the course name not exists
                IF NOT EXISTS (SELECT 1 FROM [example01].[course] WHERE [name] = @name)
                BEGIN
					-- Verify if the course id not exists
					IF NOT EXISTS (SELECT 1 FROM [example01].[course] WHERE [course_id] = @course_id)
					BEGIN
						INSERT INTO [example01].[course] ([course_id], [name], [credits])
						VALUES (@course_id, @name, @credits);
						-- Confirm the transaction
						COMMIT
						PRINT 'The course was created successfully.';
					END
					ELSE
					BEGIN
						ROLLBACK;
						PRINT 'The course id already exists, try with another course id';
					END
				END
                ELSE
                BEGIN
					ROLLBACK;
                    PRINT 'The course name already exists, try with another course name';
                END
            END
            ELSE
            BEGIN
				ROLLBACK;
                PRINT 'The course name is not valid';
            END
        END
        ELSE
        BEGIN
			ROLLBACK;
            PRINT 'Invalid @credits value. Please provide a valid number.';
        END
    END
    ELSE
    BEGIN
		ROLLBACK;
        PRINT 'Invalid @course_id value. Please provide a valid number.';
    END
	END TRY
	BEGIN CATCH
		-- If an error occurs, rollback the transaction
		ROLLBACK;
		PRINT 'Error during course insertion, try again later';
	END CATCH;
END;
GO





EXEC newCourse2 771,"IPC2",5;
SELECT * FROM [example01].[course];