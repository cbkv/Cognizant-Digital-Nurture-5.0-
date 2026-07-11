ALTER TABLE Customer
ADD DOB DATE;

UPDATE Customer SET DOB='1961-05-15' WHERE CustomerID=101;
UPDATE Customer SET DOB='1981-09-20' WHERE CustomerID=102;
UPDATE Customer SET DOB='1956-12-10' WHERE CustomerID=103;
UPDATE Customer SET DOB='1991-07-08' WHERE CustomerID=104;
UPDATE Customer SET DOB='1964-03-25' WHERE CustomerID=105;

DELIMITER $$

CREATE FUNCTION CalculateAge(
    DOB DATE
)
RETURNS INT
DETERMINISTIC

BEGIN

    RETURN TIMESTAMPDIFF(YEAR, DOB, CURDATE());

END $$

DELIMITER ;

SELECT CalculateAge('2004-06-15') AS Age;

DELIMITER $$

CREATE FUNCTION CalculateMonthlyInstallment(

LoanAmount DECIMAL(10,2),

InterestRate DECIMAL(5,2),

Years INT

)

RETURNS DECIMAL(10,2)

DETERMINISTIC

BEGIN

    DECLARE EMI DECIMAL(10,2);

    SET EMI =
    (LoanAmount +
    (LoanAmount * InterestRate * Years /100))
    /(Years*12);

    RETURN EMI;

END $$

DELIMITER ;

SELECT CalculateMonthlyInstallment(500000,10,5) AS MonthlyInstallment;

DELIMITER $$

CREATE FUNCTION HasSufficientBalance(

AccID INT,

Amount DECIMAL(10,2)

)

RETURNS BOOLEAN

DETERMINISTIC

BEGIN

    DECLARE CurrentBalance DECIMAL(10,2);

    SELECT Balance
    INTO CurrentBalance
    FROM Account
    WHERE AccountID = AccID;

    RETURN CurrentBalance >= Amount;

END $$

DELIMITER ;

SELECT HasSufficientBalance(1,5000) AS Status;

SELECT HasSufficientBalance(1,500000) AS Status;