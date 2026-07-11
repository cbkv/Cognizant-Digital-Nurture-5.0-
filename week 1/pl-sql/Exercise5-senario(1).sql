ALTER TABLE Customer
ADD LastModified DATE;

DELIMITER $$

CREATE TRIGGER UpdateCustomerLastModified

BEFORE UPDATE

ON Customer

FOR EACH ROW

BEGIN

SET NEW.LastModified = CURDATE();

END $$

DELIMITER ;

UPDATE Customer
SET Balance = 25000
WHERE CustomerID = 101;

SELECT CustomerID,
       CustomerName,
       Balance,
       LastModified
FROM Customer;

CREATE TABLE Transactions(
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionType VARCHAR(20),
    Amount DECIMAL(10,2),
    FOREIGN KEY(AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE AuditLog(
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    TransactionID INT,
    ActionDate DATETIME,
    Description VARCHAR(100)
);

DELIMITER $$

CREATE TRIGGER LogTransaction

AFTER INSERT
ON Transactions

FOR EACH ROW

BEGIN

INSERT INTO AuditLog
(
    TransactionID,
    ActionDate,
    Description
)

VALUES
(
    NEW.TransactionID,
    NOW(),
    'Transaction Inserted'
);

END $$

DELIMITER ;

INSERT INTO Transactions
VALUES
(1,1,'Deposit',5000);

SELECT * FROM AuditLog;

DELIMITER $$

CREATE TRIGGER CheckTransactionRules

BEFORE INSERT
ON Transactions

FOR EACH ROW

BEGIN

DECLARE CurrentBalance DECIMAL(10,2);

-- Check Deposit
IF NEW.TransactionType='Deposit'
AND NEW.Amount<=0 THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Deposit amount must be positive';

END IF;

-- Check Withdrawal
IF NEW.TransactionType='Withdrawal' THEN

SELECT Balance
INTO CurrentBalance
FROM Account
WHERE AccountID=NEW.AccountID;

IF NEW.Amount>CurrentBalance THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Insufficient Balance';

END IF;

END IF;

END $$

DELIMITER ;


INSERT INTO Transactions
VALUES
(2,1,'Deposit',-500);

INSERT INTO Transactions
VALUES
(3,1,'Withdrawal',100000);

INSERT INTO Transactions
VALUES
(4,1,'Withdrawal',5000);

SELECT * FROM Transactions;