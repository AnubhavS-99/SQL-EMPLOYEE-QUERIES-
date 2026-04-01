CREATE database employee_db

CREATE TABLE employee(
empid INT IDENTITY(101,1) PRIMARY KEY,
fname VARCHAR(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
job_title VARCHAR(50) NOT NULL,
department VARCHAR(50) ,
salary DECIMAL(10,2) DEFAULT 30000.00,
hire_date DATE  NOT NULL DEFAULT CONVERT(date, GETDATE()),
city VARCHAR(50)
);


INSERT INTO employee (fname, lname, email, job_title, department, salary,hire_date, city)
VALUES 
('Aarav','Sharma', 'aarav.sharma@example.com','Director','Management',180000,'2010-05-15','Mumbai'),
('Diya','Patel', 'diya.patel@example.com','Lead Engineer','tech',120000,'2015-08-01','Bangalore'),
('Rohan','Mehra', 'rohan.mehra@example.com','Software Engineer','Tech',90000,'2018-03-20','Pune'),
('Priya','singh', 'priya.singh@example.com','HR Manager','Human Resources',110000,'2012-11-10','Delhi'),
('Arjun','Kumar', 'arjun,kumar@example.com','Data scientist','Tech',95000,'2019-07-05','Hyderabad'),
('Ananya','Gupta', 'ananya.gupta@example.com','Marketing Lead','Marketing',85000,'2016-02-25','Chennai'),
('Vikram','Reddy', 'vikram.reddy@example.com','Sales Manager','Sales',105000,'2014-09-30','Mumbai'),
('Sanya','Shah', 'sanya.shah@example.com','Financial Analyst','Finance',80000,'2017-12-15','Bangalore'),
('Kabir','Singh', 'kabir.singh@example.com','Product Manager','Product',115000,'2013-06-20','Pune'),
('Isha','Verma', 'isha.verma@example.com','UX Designer','Design',90000,'2018-10-01','Delhi');

SELECT * FROM employee

SELECT*FROM employee WHERE department='Tech'
SELECT*FROM employee WHERE salary>50000
SELECT*FROM employee WHERE hire_date>'2017-01-01'
SELECT*FROM employee WHERE department != 'tech'


SELECT DISTINCT city FROM employee

SELECT*FROM employee ORDER BY salary DESC
SELECT*FROM employee ORDER BY hire_date ASC
SELECT department ,fname FROM employee ORDER BY  department , fname ASC

SELECT*FROM employee
WHERE department LIKE '%T%'

SELECT*FROM employee
WHERE fname LIKE 'A%'

SELECT*FROM employee WHERE email LIKE '%gupta%'

SELECT TOP 3 *FROM employee ORDER BY salary DESC

SELECT * FROM employee WHERE salary > 15000 AND department = 'tech'
SELECT * FROM employee WHERE salary > 17000 OR  city = 'mumbai'

SELECT*FROM employee WHERE department IN('marketing','sales','tech')
SELECT*FROM employee WHERE salary BETWEEN 150000 AND 200000
SELECT *FROM employee where department NOT IN ('sales','tech')


SELECT fname ,lname,salary ,
case
WHEN salary >150000 THEN 'Higher earner'
WHEN salary >=100000 AND  salary <=150000 THEN 'Medium earner'
ELSE 'Standard earner'
END AS salary_band 
FROM employee 

--CALCULATE BONUS ---
SELECT fname,lname ,department,salary,
CASE 
WHEN department IN ('sales','marketing') THEN salary*0.10
WHEN department = 'tech' THEN salary *0.20
ELSE salary*0.05
END as bonus
FROM employee

SELECT COUNT(empid) as count FROM employee 
SELECT MIN(salary) as minimum_salary  FROM employee
SELECT MAX(salary) as Maximum_salary FROM employee 
SELECT AVG(salary) FROM employee 
SELECT SUM(salary) FROM employee 

 
 ----GROUP BY 
 SELECT department FROM employee GROUP BY department 
SELECT department , COUNT(fname) as count FROM employee GROUP BY department 

SELECT city , count(empid) as NUMBER_OF_EMP FROM employee GROUP BY city

SELECT department , AVG(salary) as AVERAGE_SALARY FROM employee GROUP BY department
SELECT job_title  , SUM(salary) as TOTAL_SALARY FROM employee GROUP BY job_title 


SELECT department ,city ,COUNT(empid) as No_of_empid FROM employee GROUP BY department , city

SELECT department, COUNT(empid) as No_of_empid FROM employee GROUP BY ROLLUP( department )
HAVING COUNT(empid) > 2

SELECT job_title ,AVG(salary) as AVERAGE_SALARY FROM employee GROUP BY job_title
HAVING AVG(salary) > 90000


SELECT department ,SUM(salary) as TOTAL_SALARY FROM employee GROUP BY ROLLUP(department) 
HAVING SUM(salary) > 100000

--COALESCEFUNCTION / ROLLUP ----

SELECT COALESCE (department,'NO_OF_DEP') AS department  , COALESCE(city ,'TOTAL') as city, COUNT(empid) as No_of_empid 
FROM employee GROUP BY ROLLUP(department,city)
ORDER BY department 


----SUB QUERIES -----
SELECT *FROM employee 
WHERE salary > (SELECT AVG(salary) FROM employee)

SELECT * FROM employee 
WHERE department IN (
SELECT department FROM employee WHERE city ='mumbai'
)

---CO RELATED QUERIES ----
SELECT*FROM employee e1
WHERE salary = (
SELECT MAX(salary) FROM employee e2 
WHERE e2.department = e1.department)

----STRING FUNCTIONS ----
SELECT CONCAT(fname,' ',lname) AS full_name FROM employee

----REPLACE--
SELECT REPLACE(department ,'tech','Tech') FROM employee

-----DATE FUNCTION ---
SELECT GETDATE()
SELECT DATEADD(MONTH,3,GETDATE())


SELECT DATEDIFF(MONTH ,'2024-03-31',GETDATE())

SELECT FORMAT(GETDATE(),'DD/yyyy/mm')

----ALTER--
ALTER TABLE employee
ADD phone VARCHAR(15)

ALTER TABLE employee
DROP COLUMN phone

---RELATIONSHIP--

----1:MANY ------
CREATE DATABASE store_db
USE store_db

CREATE TABLE Customers(
customer_id INT IDENTITY(100,1) PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE
)

INSERT INTO Customers(customer_name,email)
VALUES
('Raju','raju@example.com'),
('sham','sham@example.com'),
('Baburao','baburao@example.com')



---ORDER TABLE--
CREATE TABLE orders(
order_id INT IDENTITY (500,1) PRIMARY KEY,
order_date DATE NOT NULL,
total_amount DECIMAL(10,2),
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
)

INSERT INTO orders(order_date,total_amount,customer_id)
VALUES 
('2025-09-15',1500.00,100),
('2025-09-25',800.00,101),
('2025-10-19',2200.00,102),
('2025-11-05',1200.00,101)



SELECT *FROM customers
SELECT *FROM orders
