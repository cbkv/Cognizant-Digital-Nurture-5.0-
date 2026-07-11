--Procedure 1: Hire Employee
DELIMITER $$

CREATE PROCEDURE HireEmployee(

IN EID INT,

IN EName VARCHAR(50),

IN Salary DECIMAL(10,2),

IN Dept VARCHAR(30)

)

BEGIN

INSERT INTO Employee

VALUES

(EID,EName,Salary,Dept);

END $$

DELIMITER ;

SELECT * FROM Employee;

CALL HireEmployee(200,'Vishwa',55000,'HR');

-- Procedure 2: Update Employee

DELIMITER $$

CREATE PROCEDURE UpdateEmployeeDetails(

IN EID INT,

IN NewSalary DECIMAL(10,2)

)

BEGIN

UPDATE Employee

SET Salary=NewSalary

WHERE EmployeeID=EID;

END $$

DELIMITER ;

CALL UpdateEmployeeDetails(201,65000);

-- Function 3: Calculate Annual Salary
DELIMITER $$

CREATE FUNCTION CalculateAnnualSalary(

MonthlySalary DECIMAL(10,2)

)

RETURNS DECIMAL(10,2)

DETERMINISTIC

BEGIN

RETURN MonthlySalary*12;

END $$

DELIMITER ;

SELECT CalculateAnnualSalary(60000);

