CREATE DATABASE BankDB;

USE BankDB;

CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY,
    CustomerName varchar(50),
    Age INT,
    Balance decimal(10,2),
    LoanInterestRate decimal(5,2),
    IsVIP boolean
);

CREATE TABLE Loans(
	LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount DECIMAL(10,2),
    LoanDueDate DATE,
    FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);

Insert into Customer Values
(101,'Krishna',65,15000,9.5,FALSE),
(102,'Rahul',45,8000,10.0,FALSE),
(103,'Priya',70,20000,8.5,FALSE),
(104,'Arun',35,12000,11.0,FALSE),
(105,'Sneha',62,5000,9.0,FALSE);

INSERT INTO Loans VALUES
(1,101,500000,'2026-07-15'),
(2,102,300000,'2026-09-10'),
(3,103,400000,'2026-07-20'),
(4,104,250000,'2026-08-25'),
(5,105,350000,'2026-07-10');

SELECT* FROM Customer;

UPDATE Customer SET LoanInterestRate = LoanInterestRate - 1 WHERE Age > 60;

SELECT* FROM Customer;

UPDATE Customer SET IsVIP = TRUE WHERE Balance > 7000;

SELECT * FROM Customer;

SELECT
    C.CustomerName,
    L.LoanDueDate
FROM Customer C
JOIN Loans L
ON C.CustomerID = L.CustomerID
WHERE L.LoanDueDate
BETWEEN '2026-07-01' AND '2026-07-31';