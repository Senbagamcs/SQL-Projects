CREATE DATABASE IF NOT EXISTS EmployeeDB;
USE EmployeeDB;

CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);


INSERT INTO Employees(EmployeeID,FirstName,LastName,Department,Salary)
   VALUES (1, 'John', 'Doe', 'IT', 60000),
          (2, 'Jane', 'Smith', 'HR', 55000),
          (3, 'Jagan','Mohan','TL',62500.75),
          (4, 'Abi', 'shek','Manager',70000),
          (5,'Yuva','Sri','Sales',45000.25),
          (6,'Sowmiya','Suresh','Database',20000),
          (7,'Vijaya','Lakshmi','Marketing',35000),
          (8,'Raga','Priya','Supervisor',50000),
          (9,'Siva','Ranjani','TL',63000),  
          (10,'Vishnu','Priya','Testing',25000),
          (11,'Madhu','Bala','HR',57000),
          (12,'Nandha','Kumar','Designing',45000.50),
          (13,'Ram','Kumar','Sales',43500),
          (14,'Priya','Dharshini','Manager',65000),
          (15,'Sai','Nath','Designing',45000);
          
-- Add more records...

UPDATE Employees SET Salary = 65000 WHERE EmployeeID = 1;

SELECT * FROM Employees WHERE Department = 'IT' ORDER BY Salary DESC;


CREATE TABLE IF NOT EXISTS Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments(DepartmentID,DepartmentName) 
						VALUES (1, 'IT'),
                               (2, 'HR'),
                               (3,'Sales'),
                               (4,'Marketing'),
                               (5,'Designing'),
                               (6,'Manager'),
                               (7,'Testing'),
                               (8,'TL'),
                               (9,'Supervisor'),
                               (10,'Database'),
                               (11,'Customerservice'),
                               (12,'Security'),
                               (13,'Admin'),
                               (14,'Accounting'),
                               (15,'Communication');
                               

-- INNER JOIN example
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.Department = Departments.DepartmentName;


SELECT Department, AVG(Salary) AS AvgSalary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department;

SELECT * FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);

SELECT * FROM Employees WHERE FirstName LIKE 'J%';

SELECT EmpName FROM Employee WHERE EmpName LIKE '%John%';

SELECT EmployeeID, FirstName FROM Employees
UNION
SELECT DepartmentID, DepartmentName FROM Departments;


SELECT * FROM Employees WHERE EXISTS (SELECT 1 FROM Departments WHERE Employees.Department = Departments.DepartmentName);

SELECT AVG(Salary) AS AvgSalary, SUM(Salary) AS TotalSalary FROM Employee;


SELECT * FROM Employee WHERE emp_id IN (2, 4); 

SELECT * FROM Employee WHERE emp_salary > 60000 AND emp_dept = 'Finance';

SELECT DISTINCT emp_dept FROM Employee;

SELECT emp_id, emp_name FROM Employee WHERE emp_salary > 60000
UNION
SELECT emp_id, emp_name FROM Employee WHERE emp_dept = 'Finance';


SELECT emp_id, emp_name FROM Employee WHERE emp_salary > 60000 INTERSECT SELECT emp_id, emp_name FROM Employee WHERE emp_dept = 'Finance'; 



SELECT COUNT(emp_id) AS num_employees FROM Employee;

SELECT AVG(emp_salary) AS average_salary FROM Employee;

SELECT MAX(emp_salary) AS highest_salary FROM Employee;


SELECT * FROM Employee WHERE emp_salary BETWEEN 60000 AND 75000;

SELECT * FROM Employee WHERE emp_name IS NULL;

SELECT * FROM Employee WHERE emp_name IS NOT NULL; 



DELETE FROM Employee WHERE Salary < 50000;