-- Creation of the database
CREATE DATABASE IF NOT EXISTS restaurant_chain;

USE restaurant_chain;

-- JOb table
CREATE TABLE IF NOT EXISTS job(
job_id  INT PRIMARY KEY AUTO_INCREMENT,
job_name VARCHAR(100) NOT NULL,
job_salary DECIMAL(10,2) NOT NULL);

-- Restaurant table
CREATE TABLE IF NOT EXISTS restaurant(
restaurant_id VARCHAR(100) PRIMARY KEY,
restaurant_name VARCHAR(100) NOT NULL,
restaurant_staff INT NOT NULL,
restaurant_parking SMALLINT NOT NULL);


-- 1. INSERT NEW RESTAURANT PROCEDURE

DELIMITER //
CREATE PROCEDURE newRestaurant(
p_restaurant_id VARCHAR(100),
p_restaurant_name VARCHAR(100),
p_restaurant_staff INT,
p_restaurant_parking SMALLINT 
)
BEGIN
	DECLARE restaurant_count INT;
    IF p_restaurant_staff <=0 THEN
		SIGNAL SQLSTATE '45000'
        SET message_text= 'restaurant staff must be positive integer';
        -- Rollback here
	ELSE
		SELECT COUNT(*)  INTO restaurant_count FROM restaurant where restaurant_id=p_restaurant_id;
        IF restaurant_count >0 THEN
			SIGNAL SQLSTATE '45000'
			SET message_text= 'restaurant id must be unique';
            -- Rollback here
		ELSE
			-- Insert
            INSERT INTO restaurant(restaurant_id,restaurant_name,restaurant_staff,
            restaurant_parking) 
            VALUES(p_restaurant_id,p_restaurant_name,p_restaurant_staff,p_restaurant_parking);
            -- Commit here
		END IF;
	END IF;
    END;
        
//

DROP PROCEDURE newRestaurant;
CALL newRestaurant('R-02','BASES3',3,1);
SELECT * FROM restaurant;

-- Trigger creation sintax example
CREATE TRIGGER restaurant_trigger AFTER INSERT ON restaurant
FOR EACH ROW
INSERT INTO logsss(-- Parameters
);