-- Create database
CREATE DATABASE IF NOT EXISTS AppointmentScheduler;

-- Use the database
USE AppointmentScheduler;

-- Create tables
CREATE TABLE IF NOT EXISTS Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Insert data
INSERT INTO Doctors (doctor_name, specialty) VALUES
('Dr. Smith', 'Cardiology'),
('Dr. Johnson', 'Orthopedics'),
('Dr. John Smith', 'Cardiology'),
('Dr. Mary Johnson', 'Pediatrics'),
('Dr. Robert Davis', 'Orthopedics'),
('Dr. Ragul', 'Gynogology'),
( 'Dr. Sujith', 'Radiology'),
( 'Dr. Akash', 'Physician'),
('Dr. Sathish', 'Anesthesia'),
('Dr. Kumar', 'Nursing'),
('Dr. Ajith', 'Dentist'),
( 'Dr. Mani', 'Dermatology'),
('Dr. Maran', 'Biomedical'),
('Dr. Kumaran', 'Oncology'),
( 'Dr. Santhosh', 'Gastroenterology'),
('Dr. Krishva', 'Neurology'),
('Dr. Dhaiwik', 'Optometry');


INSERT INTO Patients (patient_name, contact_number) VALUES
('John Doe', '123-456-7890'),
('Jane Smith', '987-654-3210'),
('Jaya','+6655443322'),
('Abi', '+1987654321'),
('Arya', '+1237654324'),
('Anice', '+8899776655'),
('Abarna', '+5544332211'),
( 'Anu', '+7788990066'),
('Priya','+3322114455'),
('Dharshan', '+9876567890'),
('Mathi', '+2345216890'),
('Mano', '+4455667788'),
('Prabha',  '+8855443399'),
('Pratheepa', '+1357908642'),
('Vinoth', '+2468097531' );


INSERT INTO Appointments (doctor_id, patient_id, appointment_date, appointment_time)
VALUES
(1, 1, '2024-01-10', '10:00:00'),
(2, 2, '2024-01-15', '14:30:00'),
(3, 3, '2024-01-20', '10:15:00'),
(4, 4, '2024-01-25', '11:20:00'),
(5, 5, '2024-01-30', '12:00:00'),
(6, 6, '2024-02-05', '01:30:00'),
(7, 7, '2024-02-10', '10:10:00'),
(8, 8, '2024-02-15', '10:25:00'),
(9, 9, '2024-02-20', '07:30:00'),
(10, 10, '2024-02-25', '05:40:00'),
(11, 11, '2024-02-27', '06:30:00'),
(12, 12, '2024-03-10', '10:45:00'),
(13, 13, '2024-03-15', '11:40:00'),
(14, 14, '2024-03-20', '08:50:00'),
(15, 15, '2024-03-25', '04:15:00');
-- Update appointment status
UPDATE Appointments SET status = 'Cancelled' WHERE appointment_id = 1;

-- Select appointments with WHERE and AND
SELECT * FROM Appointments WHERE status = 'Scheduled' AND appointment_date > '2024-01-10';

-- Joins
SELECT Appointments.appointment_id, Doctors.doctor_name, Patients.patient_name
FROM Appointments
JOIN Doctors ON Appointments.doctor_id = Doctors.doctor_id
JOIN Patients ON Appointments.patient_id = Patients.patient_id;

-- Aggregation functions
SELECT doctor_id, COUNT(*) AS total_appointments, AVG(appointment_date) AS avg_date
FROM Appointments
GROUP BY doctor_id
HAVING total_appointments > 1;

-- Subquery
SELECT patient_name
FROM Patients
WHERE patient_id IN (SELECT patient_id FROM Appointments WHERE doctor_id = 1);

-- UNION and UNION ALL
SELECT appointment_id, appointment_date FROM Appointments WHERE doctor_id = 1
UNION ALL
SELECT appointment_id, appointment_date FROM Appointments WHERE doctor_id = 2;

-- ORDER BY
SELECT * FROM Appointments ORDER BY appointment_date ASC, appointment_time DESC;

-- LIKE and wildcards
SELECT * FROM Doctors WHERE doctor_name LIKE '%Dr%';

-- NULL and NOT NULL
SELECT * FROM Appointments WHERE status IS NULL;
SELECT * FROM Appointments WHERE status IS NOT NULL;

-- MIN and MAX
SELECT MIN(appointment_date) AS earliest_date, MAX(appointment_date) AS latest_date FROM Appointments;

-- EXISTS
SELECT doctor_name FROM Doctors WHERE EXISTS (SELECT 1 FROM Appointments WHERE doctor_id = Doctors.doctor_id);

-- ALTER TABLE
ALTER TABLE Appointments ADD COLUMN notes TEXT;