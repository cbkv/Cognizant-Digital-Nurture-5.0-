DELIMITER $$

CREATE PROCEDURE AddCustomer(

IN CID INT,

IN CName VARCHAR(50),

IN CAge INT,

IN CBalance DECIMAL(10,2),

IN Interest DECIMAL(5,2)

)

BEGIN

INSERT INTO Customer

(CustomerID,CustomerName,Age,Balance,LoanInterestRate,IsVIP)

VALUES

(CID,CName,CAge,CBalance,Interest,FALSE);

END $$

DELIMITER ;

SELECT * FROM Customer;
CALL AddCustomer(107,'Anshita',20,18000,9.5);

DELIMITER $$

CREATE PROCEDURE UpdateCustomerDetails(

IN CID INT,

IN NewBalance DECIMAL(10,2)

)

BEGIN

UPDATE Customer

SET Balance=NewBalance

WHERE CustomerID=CID;

END $$

DELIMITER ;

CALL UpdateCustomerDetails(101,30000);

SELECT * FROM Customer;

DELIMITER $$

CREATE FUNCTION GetCustomerBalance(

CID INT

)

RETURNS DECIMAL(10,2)

DETERMINISTIC

BEGIN

DECLARE Bal DECIMAL(10,2);

SELECT Balance

INTO Bal

FROM Customer

WHERE CustomerID=CID;

RETURN Bal;

END $$

DELIMITER ;

SELECT GetCustomerBalance(101);

