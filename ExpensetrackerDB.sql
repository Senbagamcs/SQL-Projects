-- Create database
CREATE DATABASE IF NOT EXISTS ExpenseTracker;

-- Use the database
USE ExpenseTracker;

-- Create expense table
CREATE TABLE IF NOT EXISTS Expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    category VARCHAR(50),
    expense_date DATE NOT NULL
);

-- Insert data
INSERT INTO Expenses (description, amount, category, expense_date) VALUES
('Groceries', 50.00, 'Food', '2024-01-01'),
('Dinner with friends', 30.00, 'Entertainment', '2024-01-05'),
('Internet bill', 40.00, 'Utilities', '2024-01-10'),
('Petrol',150.00,'Transport','2024-01-02'),
('Bike service',500.00,'Transport','2024-01-15'),
('Hospital bill',1500.00,'Needs','2024-01-17'),
('Pharmacy',2000.00,'Needs','2024-01-20'),
('Water bill',200.00,'Needs','2024-01-16'),
('Maintanence',150.00,'Utilies','2024-01-27'),
('School fees',25000.00,'Needs','2024-01-30'),
('Shopping',2500.00,'Needs','2024-01-22'),
('Food',1500.00,'Needs','2024-01-23'),
('Electronic gadgets',250.00,'Utilities','2024-01-19'),
('Emergency fund',250.00,'Needs','2024-01-12'),
('Insurance',350.00,'Essential','2021-01-01');

-- Update expense
UPDATE Expenses SET amount = 60.00 WHERE description = 'Groceries';

-- Select with WHERE and AND
SELECT * FROM Expenses WHERE category = 'Food' AND amount > 40.00;

-- Select with OR and ORDER BY
SELECT * FROM Expenses WHERE category = 'Food' OR category = 'Utilities' ORDER BY amount DESC;

-- Use of LIKE
SELECT * FROM Expenses WHERE description LIKE '%friend%';

-- Joins (Inner Join)
CREATE TABLE IF NOT EXISTS ExpenseCategories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO ExpenseCategories (category_id,category_name) VALUES (101,'Food'), (102,'Entertainment'),
 (103,'Utilities'),
 (104,'Needs'),
 (105,'Membership'),
 (106,'Housing'),
 (107,'Insurance'),
 (108,'Electronics'),
 (109,'Food'),
 (110,'Transport'),
 (111,'Loan'),
 (112,'Recharge'),
 (113,'Service'),
 (114,'Essential'),
 (115,'others');
SELECT Expenses.*, ExpenseCategories.category_name
FROM Expenses
JOIN ExpenseCategories ON Expenses.category = ExpenseCategories.category_name;

-- Aggregation functions
SELECT category, COUNT(*) AS total_expenses, SUM(amount) AS total_amount
FROM Expenses
GROUP BY category
HAVING total_amount > 50.00;

-- Subquery
SELECT description, amount
FROM Expenses
WHERE amount > (SELECT AVG(amount) FROM Expenses);

-- UNION and UNION ALL
SELECT description, amount FROM Expenses WHERE category = 'Food'
UNION
SELECT description, amount FROM Expenses WHERE category = 'Entertainment';

-- INTERSECT (not supported in MySQL, using INNER JOIN as an alternative)
SELECT a.description, a.amount
FROM Expenses a
JOIN Expenses b ON a.description = b.description AND a.amount = b.amount AND a.category = b.category
WHERE a.category = 'Food' AND b.category = 'Entertainment';

-- NULL and NOT NULL
SELECT * FROM Expenses WHERE category IS NULL;
SELECT * FROM Expenses WHERE category IS NOT NULL;

-- MIN and MAX
SELECT MIN(amount) AS min_amount, MAX(amount) AS max_amount FROM Expenses;

-- EXISTS
SELECT description FROM Expenses WHERE EXISTS (SELECT 1 FROM ExpenseCategories WHERE category_name = 'Food');

-- Wildcards
SELECT * FROM Expenses WHERE description LIKE 'D%';

-- ALTER TABLE
ALTER TABLE Expenses ADD COLUMN notes TEXT;