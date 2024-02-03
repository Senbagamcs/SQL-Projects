CREATE DATABASE IF NOT EXISTS LIBRARY;

USE LIBRARY;

-- Create Book table
CREATE TABLE Book (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50),
    genre VARCHAR(30),
    published_year INT
);

-- Insert sample data
INSERT INTO Book(book_id,title,author,genre,published_year) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960),
(2, '1984', 'George Orwell', 'Dystopian', 1949),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925),
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 'Coming-of-Age', 1951),
(6, 'A Tale of Two Cltles', 'Charles Dickens', 'Historical fiction', 1859),
(7, 'The Little Prince', 'Antoine de saint-Exupery', 'Fantasy', 1943),
(8, 'Harry Potter and the Philosopher', 'J.K Rowling', 'Children Fiction', 1997),
(9, 'And Then There Were None', 'Agatha Christie', 'Mystery', 1939),
(10, 'Dream of the Red Chamber', 'Cae Xueqin', 'Family saga', 1791),
(11,'The Da Vinci Code','Dan Browm','Mystery Thriller',2003),
(12,'The Alchemist','Paulo coelho','Fantasy',1988),
(13,'The Tale of Peter Rabbit','Beatrix Potter','Children Literature',1902 ),
(14,'Jonathan Livingston seagull','Richard Bach','Novella',1970),
(15,'War and Peace','leo Tolstoy','Historical Novel',1869);



-- Create Member table
CREATE TABLE Member (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50),
    member_email VARCHAR(100),
    member_phone VARCHAR(15)
);

-- Insert sample data
INSERT INTO Member(member_id,member_name,member_email,member_phone) VALUES
(1, 'John Doe', 'john.doe@gmail.com', '123-456-7890'),
(2, 'Jane Smith', 'jane.smith@gmail.com', '987-654-3210'),
(3, 'Bob Johnson', 'bob.johnson@gmail.com', '555-123-4567'),
(4, 'Alice Williams', 'alice.w@gmail.com', '111-222-3333'),
(5, 'Charlie Brown', 'charlie.brown@gmail.com', '777-888-9999'),
(6,'Leo Tolstoy','leo.t@gmail.com','111-112-3560'),
(7,'Charles','Charles.d@gmail.com','666-555-780'),
(8,'Dan Brown','dan.b@gmail.com','346-905-456'),
(9,'Paul Raj','Raj23@gmail.com','167-785-000'),
(10,'Jonny','jonny80@gmail.com','431-074-173'),
(11,'Mukesh','muki66@gmail.com','043-294-430'),
(12,'Gowthan','gowtham10@gmail.com','424-175-910'),
(13,'Neha','neh99@gmail.com','140-215-621'),
(14,'Devi','devi55@gmail.com','864-095-231'),
(15,'Lavanya','lovenya100@gmail.com','883-489-645');

-- Create BookLoan table
CREATE TABLE BookLoan (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE
);

-- Insert sample data
INSERT INTO BookLoan(loan_id,book_id,member_id,loan_date,return_date) VALUES
(1, 1, 1, '2023-01-01', '2023-01-15'),
(2, 2, 2, '2023-02-01', '2023-02-15'),
(3, 3, 3, '2023-03-01', '2023-03-15'),
(4, 4, 4, '2023-04-01', '2023-04-15'),
(5, 5, 5, '2023-05-01', '2023-05-15'),
(6, 6, 6, '2023-06-01', '2023-06-15'),
(7, 7, 7, '2023-07-01', '2023-07-15'),
(8, 8, 8, '2023-08-01', '2023-08-15'),
(9, 9, 9, '2023-09-01', '2023-09-15'),
(10, 10, 10, '2023-10-01', '2023-10-15'),
(11, 11, 11, '2023-11-01', '2023-11-15'),
(12, 12, 12, '2023-12-01', '2023-12-15'),
(13, 13, 13, '2024-01-01', '2024-01-15'),
(14, 14, 14, '2024-01-16', '2024-01-30'),
(15, 15, 15, '2024-02-01', '2024-02-15');


-- Select all books
SELECT * FROM Book;

-- Select books published after 1950
SELECT * FROM Book WHERE published_year > 1950;

-- Update book genre
UPDATE Book SET genre = 'Literary Fiction' WHERE book_id = 1;

-- Delete a book
DELETE FROM Book WHERE book_id = 4;

-- Add a new member
INSERT INTO Member VALUES (6, 'Eva Green', 'eva.green@email.com', '999-888-7777');

-- Select all books borrowed by a specific member
SELECT Book.title, Book.author, BookLoan.loan_date, BookLoan.return_date
FROM Book
JOIN BookLoan ON Book.book_id = BookLoan.book_id
JOIN Member ON BookLoan.member_id = Member.member_id
WHERE Member.member_name = 'John Doe';

-- Count the number of books in each genre
SELECT genre, COUNT(*) AS num_books FROM Book GROUP BY genre;

-- Find the book with the earliest published year
SELECT * FROM Book ORDER BY published_year ASC LIMIT 1;

-- Find members who borrowed more than two books
SELECT Member.member_name, COUNT(*) AS num_books_borrowed
FROM Member
JOIN BookLoan ON Member.member_id = BookLoan.member_id
GROUP BY Member.member_name
HAVING COUNT(*) > 2;

-- Select books with 'The' in the title
SELECT * FROM Book WHERE title LIKE '%The%';

-- Select books borrowed in February
SELECT Book.title, Member.member_name, BookLoan.loan_date
FROM Book
JOIN BookLoan ON Book.book_id = BookLoan.book_id
JOIN Member ON BookLoan.member_id = Member.member_id
WHERE MONTH(BookLoan.loan_date) = 2;

-- Select books borrowed by members whose name starts with 'J'
SELECT Book.title, Member.member_name
FROM Book
JOIN BookLoan ON Book.book_id = BookLoan.book_id
JOIN Member ON BookLoan.member_id = Member.member_id
WHERE Member.member_name LIKE 'J%';

-- Use EXISTS to find books with loans
SELECT title FROM Book WHERE EXISTS (
    SELECT 1 FROM BookLoan WHERE BookLoan.book_id = Book.book_id
);

-- Select all members with NULL phone numbers
SELECT * FROM Member WHERE member_phone IS NULL;

-- Select all members with NOT NULL email addresses
SELECT * FROM Member WHERE member_email IS NOT NULL;