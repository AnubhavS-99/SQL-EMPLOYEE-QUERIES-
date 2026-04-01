--list down existing db---
EXEC sp_databases
SELECT name FROM sys.databases

----creating a new database---
CREATE DATABASE School_db
CREATE TABLE students(
	student_id INT PRIMARY KEY,
	name VARCHAR(100),
	age INT,
	grade VARCHAR(10)
)
EXEC sp_help 'students'

INSERT INTO students (student_id, name, age, grade) 
VALUES (101, 'Alice', 10, 5),
	   (102, 'Bob', 12, 7),
	   (103, 'Charlie', 14, 9),
	   (104, 'David', 12, 6),
	   (105, 'Eve', 11, 6),
	   (106, 'Frank', 13, 8),
	   (107, 'Grace', 10, 5),
	   (108, 'Heidi', 14, 9),
	   (109, 'Ivan', 12, 7),
	   (110, 'Judy', 11, 6)
	  
	   
	    

UPDATE students
SET grade = 11
WHERE student_id = 101


DELETE FROM students
WHERE student_id = 104

SELECT name , grade FROM students WHERE age>12












DROP TABLE students

SELECT * FROM students

SELECT name FROM students 