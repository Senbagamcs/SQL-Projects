-- Create Database
CREATE DATABASE IF NOT EXISTS hotel_reservation_system;
USE hotel_reservation_system;

-- Create Tables
CREATE TABLE IF NOT EXISTS guests (
    guest_id INT PRIMARY KEY,
    guest_name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    phone_number VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(30),
    occupancy INT,
    price DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS reservations (
    reservation_id INT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in_date DATE,
    check_out_date DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Insert Data
INSERT INTO guests(guest_id,guest_name,email,phone_number) VALUES (1, 'raja', 'raja@gmail.com', '123-456-7890'),
 (2, 'sriram', 'sriram@gmail.com', '987-654-3210'),
 (3,'Sai','sai@gmail.com','987-098-765'),
 (4,'Sridhar','sridhar@gmail.com','678-543-098'),
 (5,'Murugan','murugan@gmail.com','345-123-321'),
 (6,'Kowsi','kowsi@gmail.com','654-567-987'),
 (7,'Gowri','gowi@gmail.com','378-267-983'),
 (8,'Sowmiya','sowmiya@gmail.com','109-106-287'),
 (9,'Dharshini','dharshini@gmail.com','345-543-289'),
 (10,'Arun','arun@gmail.com','222-444-666'),
 (11,'Anitha','anitha@gmail.com','666-333-111'),
 (12,'Asif','asif@gmail.com','777-000-111'),
 (13,'saravanan','saravana@gmail.com','444-666-222'),
 (14,'Suriya','suriya@gmail.com',000-666-222),
 (15,'Vijay','vijay@gmail.com',888-555-333);
 

INSERT INTO rooms(room_id,room_type,occupancy,price) VALUES (101, 'Single', 1, 8000.00),
 (102, 'Double', 2, 12000.00),
 (103,'Single',1,8000.00),
 (104,'Triple',3,15000.00),
 (105,'Single',1,7500.00),
 (106,'Double',2,12000.00),
 (107,'Triple',3,13500.50),
 (108,'Single',1,4500.00),
 (109,'Triple',3,12500.00),
 (110,'Double',2,10000.35),
 (111,'Single',1,3000.00),
 (112,'Double',2,12000.00),(113,'Triple',3,15000.00),(114,'Single',1,8000.00),(115,'Triple',3,13500.50);
-- add ur record

INSERT INTO reservations(reservation_id,guest_id,room_id,check_in_date,check_out_date) VALUES
    (201, 1, 101, '2023-01-10', '2023-01-15'),
    (202, 2, 102, '2023-02-15', '2023-02-20'),
    (203, 3, 103, '2023-03-10', '2023-03-15'),
    (204, 4, 104, '2023-04-20', '2023-04-25'),
	(205, 5, 105, '2023-05-10', '2023-05-15'),
    (206, 6, 106, '2023-06-11', '2023-06-16'),
    (207, 7, 107, '2023-07-17', '2023-01-22'),
    (208, 8, 108, '2023-08-21', '2023-08-26'),
	(209, 9, 109, '2023-09-13', '2023-09-18'),
	(210, 10, 110, '2023-10-10', '2023-10-15'),
	(211, 11, 111, '2023-11-15', '2023-11-20'),
	(212, 12, 112, '2023-12-12', '2023-12-17'),
	(213, 13, 113, '2024-01-10', '2024-01-15'),
	(214, 14, 114, '2024-02-15', '2024-02-20'),
	(215, 15, 115, '2024-03-22', '2024-03-27');

-- Select Data
SELECT * FROM guests;
SELECT * FROM rooms;
SELECT * FROM reservations;

-- Update Data
UPDATE rooms SET price = 100.00 WHERE room_id = 101;

-- Joins
SELECT reservations.reservation_id, guests.guest_name, rooms.room_type
FROM reservations
JOIN guests ON reservations.guest_id = guests.guest_id
JOIN rooms ON reservations.room_id = rooms.room_id;

-- Aggregation
SELECT room_type, AVG(price) AS avg_price
FROM rooms
GROUP BY room_type
HAVING avg_price > 90;

-- Subquery
SELECT guest_name
FROM guests
WHERE guest_id IN (
    SELECT guest_id
    FROM reservations
    WHERE check_in_date BETWEEN '2023-02-01' AND '2023-02-28'
);

-- LIKE and Wildcards
SELECT * FROM guests WHERE email LIKE '%gmail.com%';

-- Order By
SELECT * FROM rooms ORDER BY price DESC;

-- EXISTS
SELECT room_type
FROM rooms r
WHERE EXISTS (
    SELECT 1
    FROM reservations re
    WHERE re.room_id = r.room_id
);

-- UNION
SELECT room_type FROM rooms WHERE occupancy = 1
UNION
SELECT room_type FROM rooms WHERE occupancy = 2;

-- ALTER TABLE
ALTER TABLE guests ADD COLUMN nationality VARCHAR(20);

-- DROP TABLE
DROP TABLE IF EXISTS guests;

-- DROP DATABASE
DROP DATABASE IF EXISTS hotel_reservation_system;