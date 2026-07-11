-- Procedure 1: Open Account
DELIMITER $$

CREATE PROCEDURE OpenAccount(

IN AccID INT,

IN CID INT,

IN AccType VARCHAR(20),

IN Bal DECIMAL(10,2)

)

BEGIN

INSERT INTO Account

VALUES

(AccID,CID,AccType,Bal);

END $$

DELIMITER ;

SELECT * FROM Account;
CALL OpenAccount(6,101,'Savings',15000);

-- Procedure 2: Close Account
DELIMITER $$

CREATE PROCEDURE CloseAccount(

IN AccID INT

)

BEGIN

DELETE FROM Account

WHERE AccountID=AccID;

END $$

DELIMITER ;

CALL CloseAccount(6);
CALL CloseAccount(5);

--Function 3: Get Total Balance
DELIMITER $$

CREATE FUNCTION GetTotalBalance(

CID INT)

RETURNS DECIMAL(10,2)

DETERMINISTIC

BEGIN

DECLARE Total DECIMAL(10,2);

SELECT SUM(Balance)
INTO Total
FROM Account
WHERE CustomerID=CID;

RETURN IFNULL(Total,0);

END $$

DELIMITER ;
SELECT GetTotalBalance(101);
