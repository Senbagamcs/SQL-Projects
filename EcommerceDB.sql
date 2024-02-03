-- Create Database
CREATE DATABASE IF NOT EXISTS EcommerceDB;
USE EcommerceDB;

-- Create Product table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Insert sample data into Product table
INSERT INTO Product(product_id,product_name,category,price,stock_quantity) VALUES
(1, 'Laptop', 'Electronics', 999.99, 50),
(2, 'Smartphone', 'Electronics', 499.99, 100),
(3, 'Running Shoes', 'Fashion', 79.99, 200),
(4, 'Backpack', 'Fashion', 39.99, 150),
(5, 'Coffee Maker', 'Appliances', 129.99, 30),
(6, 'Furniture', 'Applicanes', 7999.99, 10),
(7, 'Books', 'Knowledge', 899.99, 80),
(8, 'Pet Products', 'Pet needs', 1999.99, 95),
(9, 'Baby Products', 'Baby needs', 2559.99, 25),
(10, 'Smartwatches', 'Electronics', 3999.99, 30),
(11, 'Jewellery', 'Fashion', 25999.99, 20),
(12, 'Movie Tickets', 'Entertainment', 99.99, 100),
(13, 'Groceries', 'Needs', 1599.99, 75),
(14, 'Food', 'Taste', 499.99, 69),
(15, 'Accessories', 'Fashion', 2999.99, 55);

-- Create Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

-- Insert sample data into Customer table
INSERT INTO Customer(customer_id,customer_name,email,phone_number) VALUES
(1, 'John Doe', 'john@example.com', '+1234567890'),
(2, 'Jane Smith', 'jane@example.com', '+9876543210'),
(3, 'Jagan', 'jagan@example.com', '+8876543210'),
(4, 'Hari', 'hari@example.com', '+1134562987'),
(5, 'Reshma', 'reshma@example.com', '+9988776655'),
(6, 'Ranjith', 'ranjith@example.com', '+5544332211'),
(7, 'Shreya', 'shreya@example.com', '+1133557799'),
(8, 'Babu', 'Babu@example.com', '+2244668800'),
(9, 'Prasana', 'prasana@example.com', '+9182736450'),
(10, 'Prasanth', 'prasana@example.com', '+1029384756'),
(11, 'Balu', 'balu@example.com', '+8822554477'),
(12, 'Rahman', 'rahman@example.com', '+2039485761'),
(13, 'Supraja', 'supu@example.com', '+4921056438'),
(14, 'Harish', 'harish@example.com', '+1357908642'),
(15, 'Harini', 'harini@example.com', '+2468013579');


-- Create Order table
CREATE TABLE OrderInfo (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Insert sample data into OrderInfo table
INSERT INTO OrderInfo(order_id,customer_id,order_date,total_amount) VALUES
(101, 1, '2023-01-10', 1599.97),
(102, 2, '2023-02-15', 349.98),
(103, 3, '2023-03-20', 319.97),
(104, 4, '2023-04-10', 599.07),
(105, 5, '2023-05-10', 199.77),
(106, 6, '2023-06-10', 159.35),
(107, 7, '2023-07-10', 1699.45),
(108, 8, '2023-08-10', 1399.87),
(109, 9, '2023-09-10', 799.18),
(110, 10, '2023-10-10', 154.57),
(111, 11, '2023-11-10', 178.64),
(112, 12, '2023-12-10', 189.81),
(113, 13, '2024-01-10', 1459.33),
(114, 14, '2024-02-10', 1989.56),
(115, 15, '2024-03-10', 1239.87);
-- Create OrderDetails table
CREATE TABLE OrderDetails (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES OrderInfo(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Insert sample data into OrderDetails table
INSERT INTO OrderDetails(order_id,product_id,quantity) VALUES
(101, 1, 2),
(101, 3, 1),
(102, 2, 1),
(102, 4, 2),
(103, 5, 3),
(103, 7, 9),
(109, 6, 3),
(104, 9, 2),
(109, 10,8 ),
(105, 11,7),
(111, 12, 6),
(106, 13, 4),
(106,15 , 3),
(107, 8, 7),
(108, 14, 8);


-- Query to get product details of orders with total amount greater than 300
SELECT P.product_id, P.product_name, P.category, OD.quantity, O.total_amount
FROM OrderDetails OD
JOIN Product P ON OD.product_id = P.product_id
JOIN OrderInfo O ON OD.order_id = O.order_id
WHERE O.total_amount > 300
ORDER BY O.total_amount DESC;

-- Query to get total quantity sold for each product
SELECT P.product_id, P.product_name, SUM(OD.quantity) AS total_quantity_sold
FROM Product P
LEFT JOIN OrderDetails OD ON P.product_id = OD.product_id
GROUP BY P.product_id, P.product_name;

-- Query to find customers with their total spending
SELECT C.customer_id, C.customer_name, SUM(O.total_amount) AS total_spending
FROM Customer C
LEFT JOIN OrderInfo O ON C.customer_id = O.customer_id
GROUP BY C.customer_id, C.customer_name;

-- Query to find out-of-stock products
SELECT * FROM Product WHERE stock_quantity = 0;

-- Update product price for a specific category
UPDATE Product SET price = price * 1.1 WHERE category = 'Electronics';

-- Delete a customer
DELETE FROM Customer WHERE customer_id = 3;

-- Add a new column to Product table
ALTER TABLE Product ADD COLUMN brand VARCHAR(50);

-- Find products with a specific brand
SELECT * FROM Product WHERE brand = 'Nike';

-- Use LIKE to find products with a similar name
SELECT * FROM Product WHERE product_name LIKE 'Laptop%';

-- Use EXISTS to find products with orders
SELECT * FROM Product P
WHERE EXISTS (
    SELECT 1 FROM OrderDetails OD
    WHERE OD.product_id = P.product_id
);

-- Use HAVING to filter based on aggregated data
SELECT C.customer_id, COUNT(O.order_id) AS order_count
FROM Customer C
LEFT JOIN OrderInfo O ON C.customer_id = O.customer_id
GROUP BY C.customer_id
HAVING order_count > 1;