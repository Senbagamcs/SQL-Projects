-- Create Database
CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

-- Create Doctor table
   CREATE TABLE Doctor( doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(50),
    experience_years INT,
    contact_number VARCHAR(15),
    email VARCHAR(100)
);

-- Insert sample data into Doctor table
INSERT INTO Doctor(doctor_id,doctor_name,specialization,experience_years,contact_number,email) VALUES
(101, 'Dr. John Smith', 'Cardiology', 10, '+1234567890', 'john@example.com'),
(102, 'Dr. Mary Johnson', 'Pediatrics', 8, '+9876543210', 'mary@example.com'),
(103, 'Dr. Robert Davis', 'Orthopedics', 15, '+1122334455', 'robert@example.com'),
(104, 'Dr. Ragul', 'Gynogology', 4, '+9988776655', 'ragul@example.com'),
(105, 'Dr. Sujith', 'Radiology', 1, '+4433221100', 'sujith@example.com'),
(106, 'Dr. Akash', 'Physician', 12, '+1133557799', 'akash@example.com'),
(107, 'Dr. Sathish', 'Anesthesia', 7, '+2244668800', 'sathish@example.com'),
(108, 'Dr. Kumar', 'Nursing', 5, '+1357908642', 'kumar@example.com'),
(109, 'Dr. Ajith', 'Dentist', 9, '+9765432105', 'ajith@example.com'),
(110, 'Dr. Mani', 'Dermatology', 3, '+18765432013', 'mani@example.com'),
(111, 'Dr. Maran', 'Biomedical', 6, '+6655443388', 'maran@example.com'),
(112, 'Dr. Kumaran', 'Oncology', 8, '+7766995544', 'kumaran@example.com'),
(113, 'Dr. Santhosh', 'Gastroenterology', 4, '+2244553377', 'santhosh@example.com'),
(114, 'Dr. Krishva', 'Neurology', 12, '+1357908642', 'krishvan@example.com'),
(115, 'Dr. Dhaiwik', 'Optometry', 14, '+24680976531', 'dhaiwik@example.com');

-- Create Patient table
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    contact_number VARCHAR(15),
    email VARCHAR(100)
);

-- Insert sample data into Patient table
INSERT INTO Patient VALUES
(201, 'Alice Miller', 25, 'Female', '+1987654321', 'alice@example.com'),
(202, 'Bob Harris', 40, 'Male', '+1654321987', 'bob@example.com'),
(203, 'Jaya',45,'Female','+6655443322','jaya@example.com'),
(204, 'Abi', 34, 'Female', '+1987654321', 'abi@example.com'),
(205, 'Arya', 29, 'Male', '+1237654324', 'arya@example.com'),
(206, 'Anice', 26, 'Female', '+8899776655', 'anice@example.com'),
(207, 'Abarna', 23, 'Female', '+5544332211', 'abarna@example.com'),
(208, 'Anu', 50, 'Female', '+7788990066', 'anu@example.com'),
(209, 'Priya', 49, 'Female', '+3322114455', 'priya@example.com'),
(210, 'Dharshan', 29, 'Male', '+9876567890', 'dharsan@example.com'),
(211, 'Mathi', 35, 'Female', '+2345216890', 'mathi@example.com'),
(212, 'Mano', 31, 'Male', '+4455667788', 'mano@example.com'),
(213, 'Prabha', 25, 'Female', '+8855443399', 'prabha@example.com'),
(214, 'Pratheepa', 30, 'Female', '+1357908642', 'pratheepa@example.com'),
(215, 'Vinoth', 20, 'Male', '+2468097531', 'vinoth@example.com');

-- Create Appointment table
CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATE,
    diagnosis VARCHAR(200),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Insert sample data into Appointment table
INSERT INTO Appointment(appointment_id,doctor_id,patient_id,appointment_date,diagnosis) VALUES
(301, 101, 201, '2023-01-15', 'Cardiac checkup'),
(302, 102, 202, '2023-02-20', 'Pediatric consultation'),
(303, 103, 203, '2023-03-25', 'Orthopedic examination'),
(304, 104, 204, '2023-04-30', 'Biomedical checkup'),
(305, 105, 205, '2023-05-05', 'Neurology checkup'),
(306, 106, 206, '2023-06-10', 'Ontology checkup'),
(307, 107, 207, '2023-07-15', 'Nursing checkup'),
(308, 108, 208, '2023-08-20', 'Oncology checkup'),
(309, 109, 209, '2023-09-25', 'Determatology checkup'),
(310, 110, 210, '2023-10-30', 'dentist checkup'),
(311, 111, 211, '2023-11-05', 'Radiology checkup'),
(312, 112, 212, '2023-12-10', 'Gynogolgy checkup'),
(313, 113, 213, '2024-01-15', 'Cardiac checkup'),
(314, 114, 214, '2024-02-20', 'Physician checkup'),
(315, 115, 215, '2024-03-25', 'Anesthesia checkup');
-- Query to get details of patients with their appointments
SELECT P.patient_id, P.patient_name, P.age, P.gender, A.appointment_date, D.doctor_name, A.diagnosis
FROM Patient P
JOIN Appointment A ON P.patient_id = A.patient_id
JOIN Doctor D ON A.doctor_id = D.doctor_id
ORDER BY A.appointment_date;

-- Query to find doctors with the highest and lowest experience
SELECT specialization, 
       MAX(experience_years) AS max_experience, 
       MIN(experience_years) AS min_experience
FROM Doctor
GROUP BY specialization;

-- Query to count the number of patients in each age group
SELECT CASE 
    WHEN age < 30 THEN 'Under 30'
    WHEN age BETWEEN 30 AND 50 THEN '30-50'
    ELSE 'Over 50' 
END AS age_group,
COUNT(patient_id) AS patient_count
FROM Patient
GROUP BY age_group;