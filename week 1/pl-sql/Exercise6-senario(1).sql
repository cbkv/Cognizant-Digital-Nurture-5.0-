INSERT INTO transactions VALUES
(104,4,'Deposit',5000),
(102,2,'Withdrawal',3000),
(103,3,'Deposit',7000);

DELIMITER $$

CREATE PROCEDURE GenerateMonthlyStatements()

BEGIN

DECLARE Done BOOLEAN DEFAULT FALSE;

DECLARE T_ID INT;
DECLARE A_ID INT;
DECLARE T_Type VARCHAR(20);
DECLARE T_Amount DECIMAL(10,2);

DECLARE cur CURSOR FOR

SELECT TransactionID,
       AccountID,
       TransactionType,
       Amount
FROM Transactions;

DECLARE CONTINUE HANDLER
FOR NOT FOUND
SET Done = TRUE;

OPEN cur;

read_loop: LOOP

FETCH cur
INTO T_ID,
     A_ID,
     T_Type,
     T_Amount;

IF Done THEN
LEAVE read_loop;
END IF;

SELECT
T_ID AS TransactionID,
A_ID AS AccountID,
T_Type AS TransactionType,
T_Amount AS Amount;

END LOOP;

CLOSE cur;

END $$

DELIMITER ;

CALL GenerateMonthlyStatements();

SELECT * FROM transactions;

DELIMITER $$

CREATE PROCEDURE ApplyAnnualFee()

BEGIN

DECLARE Done BOOLEAN DEFAULT FALSE;

DECLARE A_ID INT;

DECLARE cur CURSOR FOR

SELECT AccountID
FROM Account;

DECLARE CONTINUE HANDLER
FOR NOT FOUND
SET Done = TRUE;

OPEN cur;

read_loop: LOOP

FETCH cur
INTO A_ID;

IF Done THEN
LEAVE read_loop;
END IF;

UPDATE Account

SET Balance = Balance - 100

WHERE AccountID = A_ID;

END LOOP;

CLOSE cur;

END $$

DELIMITER ;

SELECT * FROM Account;

DELIMITER $$

CALL ApplyAnnualFee();

DELIMITER $$

CREATE PROCEDURE UpdateLoanInterestRates()

BEGIN

DECLARE Done BOOLEAN DEFAULT FALSE;

DECLARE C_ID INT;

DECLARE cur CURSOR FOR

SELECT CustomerID
FROM Customer;

DECLARE CONTINUE HANDLER
FOR NOT FOUND
SET Done = TRUE;

OPEN cur;

read_loop: LOOP

FETCH cur
INTO C_ID;

IF Done THEN
LEAVE read_loop;
END IF;

UPDATE Customer

SET LoanInterestRate = LoanInterestRate - 0.5

WHERE CustomerID = C_ID;

END LOOP;

CLOSE cur;

END $$

DELIMITER ;

SELECT CustomerID,
       CustomerName,
       LoanInterestRate
FROM Customer;

CALL UpdateLoanInterestRates();

