CREATE TABLE Employees3 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary INT,
    JoiningDate DATETIME,
    Department VARCHAR(50),
    Gender VARCHAR(10)
);

INSERT INTO Employees3 (EmployeeID, FirstName, LastName, Salary, JoiningDate, Department, Gender) VALUES
(1, 'Vikas', 'Ahlawat', 600000, '2013-02-12 11:16:00', 'IT', 'Male'),
(2, 'Nikita', 'Jain', 530000, '2013-02-14 11:16:00', 'HR', 'Female'),
(3, 'Ashish', 'Kumar', 1000000, '2013-02-14 11:16:00', 'IT', 'Male'),
(4, 'Nikhil', 'Sharma', 480000, '2013-02-15 11:16:00', 'HR', 'Male'),
(5, 'Anish', 'Kadian', 500000, '2013-02-16 11:16:00', 'Payroll', 'Male');

select * from Employees3
SELECT FirstName FROM Employees3;
SELECT UPPER(FirstName) AS "First Name" FROM Employees3;
SELECT UPPER(FirstName) AS "First Name" FROM Employees3;
SELECT CONCAT(FirstName, ' ', LastName) AS "Name" FROM Employees3;
SELECT * FROM Employees3 WHERE FirstName = 'Vikas';
SELECT * FROM Employees3 WHERE FirstName LIKE 'A%';
SELECT * FROM Employees3 WHERE FirstName LIKE '%h';
SELECT * FROM Employees3 WHERE FirstName LIKE '[a-p]%';
SELECT * FROM Employees3 WHERE FirstName NOT LIKE '[a-p]%';
SELECT * FROM Employees3 WHERE Gender LIKE '_ _ _ le';

SELECT * FROM Employees3 WHERE FirstName LIKE 'A____';
SELECT * FROM Employees3 WHERE FirstName LIKE '%\%%';
SELECT DISTINCT Department FROM Employees3;
SELECT MAX(Salary) AS HighestSalary FROM Employees3;
Select Min(Salary) As LowestSalary FROM Employees3

SELECT CONCAT(
    RIGHT(CONCAT('0', DAY(JoiningDate)), 2), 
    ' ',
    LEFT(RIGHT(CONCAT('00', MONTH(JoiningDate)), 2), 3),
    ' ',
    YEAR(JoiningDate)
) AS FormattedJoiningDate 
FROM Employees3;



SELECT CONCAT(
    YEAR(JoiningDate), 
    '/', 
    RIGHT(CONCAT('0', MONTH(JoiningDate)), 2), 
    '/', 
    RIGHT(CONCAT('0', DAY(JoiningDate)), 2)
) AS FormattedJoiningDate 
FROM Employees3;

SELECT RIGHT(CONVERT(VARCHAR, JoiningDate, 108), 8) AS TimePart FROM Employees3;

SELECT YEAR(JoiningDate) AS JoiningYear FROM Employees3;

SELECT MONTH(JoiningDate) AS JoiningMonth FROM Employees3;

SELECT GETDATE() AS SystemDate;

SELECT GETUTCDATE() AS UTCDate;

SELECT 
    FirstName,
    GETDATE() AS CurrentDate,
    JoiningDate,
    DATEDIFF(MONTH, JoiningDate, GETDATE()) AS MonthsDiff
FROM 
    Employees3;

	SELECT 
    FirstName,
    GETDATE() AS CurrentDate,
    JoiningDate,
    DATEDIFF(DAY, JoiningDate, GETDATE()) AS DaysDiff
FROM 
    Employees3;


	SELECT * 
FROM Employees3 
WHERE YEAR(JoiningDate) = 2013;


SELECT * 
FROM Employees3 
WHERE MONTH(JoiningDate) = 1;

SELECT COUNT(*) AS EmployeeCount FROM Employees3;

SELECT TOP 1 * FROM Employees3;

SELECT * 
FROM Employees3 
WHERE FirstName IN ('Vikas', 'Ashish', 'Nikhil');


SELECT * 
FROM Employees3 
WHERE FirstName not IN ('Vikas', 'Ashish', 'Nikhil');

SELECT RTRIM(FirstName) AS FirstNameWithoutTrailingSpaces 
FROM Employees3;

SELECT LTRIM(FirstName) AS FirstNameWithoutLeadingSpaces 
FROM Employees3;

SELECT 
    FirstName, 
    CASE 
        WHEN Gender = 'Male' THEN 'M'
        WHEN Gender = 'Female' THEN 'F'
    END AS GenderAbbreviation
FROM Employees3;

SELECT CONCAT('Hello ', FirstName) AS Greeting
FROM Employees3;

SELECT *
FROM Employees3
WHERE Salary > 600000;

SELECT *
FROM Employees3
WHERE Salary < 700000;

SELECT *
FROM Employees3
WHERE Salary BETWEEN 500000 AND 600000;

CREATE TABLE ProjectDetail (
    ProjectDetailID INT PRIMARY KEY,
    EmployeeDetailID INT,
    ProjectName VARCHAR(255)
);
INSERT INTO ProjectDetail (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES 
(1, 1, 'Task Track'),
(2, 1, 'CLP'),
(3, 1, 'Survey Management'),
(4, 2, 'HR Management'),
(5, 3, 'Task Track'),
(6, 3, 'GRS'),
(7, 4, 'DDS'),
(8, 4, 'HR Management'),
(9, 6, 'GL Management');

SELECT * FROM ProjectDetail;

SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees3
GROUP BY Department;

SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees3
GROUP BY Department
ORDER BY TotalSalary ASC;

SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees3
GROUP BY Department
ORDER BY TotalSalary DESC;

SELECT Department, COUNT(EmployeeID) AS TotalEmployees, SUM(Salary) AS TotalSalary
FROM Employees3
GROUP BY Department;

SELECT Department, AVG(Salary) AS AverageSalary
FROM Employees3
GROUP BY Department
ORDER BY AverageSalary ASC;

SELECT Department, MAX(Salary) AS MaxSalary
FROM Employees3
GROUP BY Department
ORDER BY MaxSalary ASC;

SELECT Department, MIN(Salary) AS MinSalary
FROM Employees3
GROUP BY Department
ORDER BY MinSalary ASC;

SELECT e.*, p.*
FROM Employees3 e
JOIN ProjectDetail p ON e.EmployeeID= p.EmployeeDetailID;

SELECT e.FirstName, e.LastName, p.ProjectName
FROM Employees3 e
JOIN ProjectDetail p ON e.EmployeeID = p.EmployeeDetailID
ORDER BY e.FirstName;


SELECT 
    Employees3.firstname AS EmployeeName, 
    COALESCE(ProjectDetail.projectname, '-No Project Assigned') AS ProjectName
FROM 
    Employees3
LEFT JOIN 
    ProjectDetail ON Employees3.EmployeeID = ProjectDetailID
ORDER BY 
    Employees3.firstname;


SELECT Employees3.FirstName, ProjectDetail.ProjectName
FROM Employees3
LEFT JOIN ProjectDetail ON Employees3.EmployeeID = ProjectDetailID
ORDER BY Employees3.FirstName, ProjectDetail.ProjectName;

SELECT Employees3.FirstName AS EmployeeName, ProjectDetail.ProjectName
FROM Employees3
FULL OUTER JOIN ProjectDetail ON Employees3.EmployeeID = ProjectDetailID


Select e.FirstName ,p.projectName
from Employees3 e
Join ProjectDetail p ON e.EmployeeID = p.EmployeeDetailID
where e.EmployeeID IN(
Select EmployeeDetailID
from ProjectDetail
Group By EmployeeDetailID
Having Count(*)>1
)
Order By e.FirstName ,p.ProjectName

SELECT ProjectName, STRING_AGG(EmployeeDetailID, ', ') AS employeedetailID
FROM ProjectDetail
GROUP BY ProjectName
HAVING COUNT(*) > 1;


SELECT *
FROM ProjectDetail
CROSS JOIN
Employees3;























































