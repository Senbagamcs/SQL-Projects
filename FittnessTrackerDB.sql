-- Create Database
CREATE DATABASE IF NOT EXISTS FitnessTracker;
USE FitnessTracker;

-- Create Tables
CREATE TABLE IF NOT EXISTS Users (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DateOfBirth DATE,
    JoinDate DATE
);

CREATE TABLE IF NOT EXISTS Exercises (
    ExerciseID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Category VARCHAR(50),
    Intensity ENUM('Low', 'Moderate', 'High')
);

CREATE TABLE IF NOT EXISTS Workouts (
    WorkoutID INT PRIMARY KEY,
    UserID INT,
    Date DATE,
    DurationInMinutes INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE IF NOT EXISTS WorkoutDetails (
    WorkoutDetailID INT PRIMARY KEY,
    WorkoutID INT,
    ExerciseID INT,
    Sets INT,
    Reps INT,
    WeightInKg DECIMAL(5, 2),
    FOREIGN KEY (WorkoutID) REFERENCES Workouts(WorkoutID),
    FOREIGN KEY (ExerciseID) REFERENCES Exercises(ExerciseID)
);

-- Insert Data
INSERT INTO Users (UserID, FirstName, LastName, Email, DateOfBirth, JoinDate)
VALUES
    (1, 'John', 'Doe', 'john@example.com', '1990-01-01', '2022-01-01'),
    (2, 'Jane', 'Smith', 'jane@example.com', '1985-05-15', '2022-02-15'),
    (3,'Jagan','Mohan','jagan@example.com','1985-01-04','2024-01-05'),
	(4,'Janagi','Raman','janagi@example.com','1975-11-08','2020-08-07'),
	(5,'Renga','Raj','raj@example.com','1935-01-24','2004-11-05'),
	(6,'Sai','Ram','sai@example.com','1925-03-05','2000-11-25'),
	(7,'Ram','kumar','ram@example.com','1950-10-10','2015-04-09'),
    (8,'Siva','Priya','siva@example.com','1960-03-14','2002-12-17'),
	(9,'Priya','dharshini','dharshini@example.com','1955-09-20','2005-10-15'),
	(10,'Anu','Priya','priya@example.com','1915-06-16','1999-06-24'),
	(11,'Krishna','kumar','krishna@example.com','1925-04-24','1989-08-22'),
	(12,'Nandha','Kishore','kishore@example.com','1975-09-10','2013-04-05'),
	(13,'Nandha','Kumar','kumar@example.com','1945-06-14','2004-12-13'),
	(14,'Gokul','Kannan','gokul@example.com','1947-02-08','2000-11-20'),
	(15,'Rajan','Sri','rajan@example.com','1945-05-04','2022-04-30');
INSERT INTO Exercises (ExerciseID, Name, Category, Intensity)
VALUES
    (1, 'Running', 'Cardio', 'High'),
    (2, 'Weight Lifting', 'Strength', 'Moderate'),
    (3, 'Yoga', 'Flexibility', 'Low'),
	(4, 'Jumping', 'Fat Reduce', 'High'),
    (5, 'Skipping', 'Freshness', 'Moderate'),
	(6, 'Walking', 'Relaxation', 'Moderate'),
	(7, 'Squats', 'Strength', 'High'),
	(8, 'Pushups', 'Strongness', 'Moderate'),
	(9, 'Dumbbell', 'Strongness', 'High'),
	(10, 'Single leg', 'Balance', 'Moderate'),
	(11, 'Meditation', 'Flexibility', 'Low'),
	(12, 'Breathin-out', 'Freshness', 'High'),
	(13, 'Jogging', 'Fittness', 'Moderate'),
	(14, 'Streching', 'Flexibility', 'Low'),
	(15, 'Throwing ball', 'Flexibility', 'High');
    
    
    
    
    
    
    
INSERT INTO Workouts (WorkoutID, UserID, Date, DurationInMinutes)
VALUES 
       (1, 1, '2022-03-01', 45),
       (2, 2, '2022-03-02', 60),
       (3, 3, '2022-03-03', 15),
       (4, 4, '2022-03-04', 30),
       (5, 5, '2022-03-05', 35),
       (6, 6, '2022-03-06', 80),
       (7, 7, '2022-03-07', 25),
       (8, 8, '2022-03-08', 50),
       (9, 9, '2022-03-09', 55),
       (10, 10, '2022-03-10', 60),
       (11, 11, '2022-03-11', 75),
       (12, 12, '2022-03-12', 60),
       (13, 13, '2022-03-13', 75),
       (14, 14, '2022-03-14', 80),
       (15, 15, '2022-03-15', 85),
       (16, 16, '2022-03-16', 90);
	
INSERT INTO WorkoutDetails (WorkoutDetailID, WorkoutID, ExerciseID, Sets, Reps, WeightInKg)
VALUES
    (1, 1, 1, 1, 0, NULL),
    (2, 1, 2, 3, 12, 25),
    (3, 2, 3, 1, 0, NULL),
    (4, 4, 4, 1, 0, NULL),
    (5, 1, 5, 3, 12, 25),
    (6, 2, 6, 1, 0, NULL),
    (7, 1, 7, 1, 0, NULL),
    (8, 1, 8, 3, 12, 25),
    (9, 2, 9, 1, 0, NULL),
    (10, 1, 10, 1, 0, NULL),
    (12, 1, 2, 13, 12, 25),
    (13, 2, 3, 11, 0, NULL),
    (14, 1, 1, 12, 0, NULL),
    (15, 1, 2, 14, 12, 25),
    (11, 2, 3, 15, 0, NULL);

-- Select Data
-- Example: Retrieve workouts with exercise details for a specific user
SELECT Users.FirstName, Users.LastName, Workouts.Date, Workouts.DurationInMinutes,
       Exercises.Name AS ExerciseName, Exercises.Category, WorkoutDetails.Sets, WorkoutDetails.Reps, WorkoutDetails.WeightInKg
FROM Users
JOIN Workouts ON Users.UserID = Workouts.UserID
JOIN WorkoutDetails ON Workouts.WorkoutID = WorkoutDetails.WorkoutID
JOIN Exercises ON WorkoutDetails.ExerciseID = Exercises.ExerciseID
WHERE Users.FirstName = 'John';

-- Update Data
-- Example: Update the duration of a workout
UPDATE Workouts
SET DurationInMinutes = 50
WHERE WorkoutID = 1;

-- Delete Data
-- Example: Remove an exercise detail from a workout
DELETE FROM WorkoutDetails
WHERE WorkoutDetailID = 2;