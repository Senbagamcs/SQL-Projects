-- Create Database
CREATE DATABASE IF NOT EXISTS EnrollmentDB;
USE EnrollmentDB;

-- Create Student table
   CREATE TABLE Student (
   student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    contact_number VARCHAR(15),
    email VARCHAR(100)
);

-- Insert sample data into Student table
INSERT INTO Student(student_id,student_name,age,gender,contact_number,email) VALUES
(301, 'Alice Miller', 25, 'Female', '+1987654321', 'alice@example.com'),
(302, 'Bob Harris', 40, 'Male', '+1654321987', 'bob@example.com'),
(303, 'Jaya',45,'Female','+6655443322','jaya@example.com'),
(304, 'Abi', 34, 'Female', '+1987654321', 'abi@example.com'),
(305, 'Arya', 29, 'Male', '+1237654324', 'arya@example.com'),
(306, 'Anice', 26, 'Female', '+8899776655', 'anice@example.com'),
(307, 'Abarna', 23, 'Female', '+5544332211', 'abarna@example.com'),
(308, 'Anu', 50, 'Female', '+7788990066', 'anu@example.com'),
(309, 'Priya', 49, 'Female', '+3322114455', 'priya@example.com'),
(310, 'Dharshan', 29, 'Male', '+9876567890', 'dharsan@example.com'),
(311, 'Mathi', 35, 'Female', '+2345216890', 'mathi@example.com'),
(312, 'Mano', 31, 'Male', '+4455667788', 'mano@example.com'),
(313, 'Prabha', 25, 'Female', '+8855443399', 'prabha@example.com'),
(314, 'Pratheepa', 30, 'Female', '+1357908642', 'pratheepa@example.com'),
(315, 'Vinoth', 20, 'Male', '+2468097531', 'vinoth@example.com');



-- Create Course table
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credit_hours INT
);

-- Insert sample data into Course table
INSERT INTO Course(course_id,course_name,credit_hours) VALUES
(101, 'Mathematics', 3),
(102, 'Computer Science', 4),
(103, 'History', 3),
(104,'Civics',4),
(105,'Geography',2),
(106,'Botany',3),
(107,'Zoology',3),
(108,'Pharmacy',2),
(109,'Nursing',4),
(110,'Agriculture',3),
(111,'Economics',3),
(112,'Humanities',3),
(113,'Psychology',3),
(114,'Law',2),
(115,'Chemistry',3);

-- Create Enrollment table
CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Insert sample data into Enrollment table
INSERT INTO Enrollment(enrollment_id,student_id,course_id,enrollment_date,grade) VALUES
(501, 301, 101, '2023-01-15', 'A'),
(502, 302, 102, '2023-02-20', 'B+'),
(503, 303, 103, '2023-03-25', 'A-'),
(504, 304, 104, '2023-04-30', 'B-'),
(505, 305, 105, '2023-05-05', 'O-'),
(506, 306, 106, '2023-06-10', 'O+'),
(507, 307, 107, '2023-07-15', 'A+'),
(508, 308, 108, '2023-08-20', 'A'),
(509, 309, 109, '2023-09-25', 'A'),
(510, 310, 110, '2023-10-30', 'A'),
(511, 311, 111, '2023-11-05', 'O+'),
(512, 312, 112, '2023-12-10', 'O-'),
(513, 313, 113, '2024-01-15', 'A'),
(514, 314, 114, '2024-02-20', 'B+'),
(515, 315, 115, '2024-03-25', 'B-');



-- Query to get details of students with their enrolled courses and grades
SELECT S.student_id, S.student_name, S.age, S.gender, E.enrollment_date, C.course_name, E.grade
FROM Student S
JOIN Enrollment E ON S.student_id = E.student_id
JOIN Course C ON E.course_id = C.course_id
ORDER BY E.enrollment_date;

-- Query to find the average age of students
SELECT AVG(age) AS average_age
FROM Student;

-- Query to count the number of students enrolled in each course
SELECT C.course_name, COUNT(E.student_id) AS student_count
FROM Course C
LEFT JOIN Enrollment E ON C.course_id = E.course_id
GROUP BY C.course_name;