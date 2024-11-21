create database Customers_Orders_Products 

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(100)
);

INSERT INTO Customers (CustomerID, Name, Email)
VALUES

(1, 'John Doe', 'johndoe@example.com'),
(2, 'Jane Smith', 'janesmith@example.com'),
(3, 'Robert Johnson', 'robertjohnson@example.com'),
(4, 'Emily Brown', 'emilybrown@example.com'),
(5, 'Michael Davis', 'michaeldavis@example.com'),
(6, 'Sarah Wilson', 'sarahwilson@example.com'),
(7, 'David Thompson', 'davidthompson@example.com'),
(8, 'Jessica Lee', 'jessicalee@example.com'),
(9, 'William Turner', 'williamturner@example.com'),
(10, 'Olivia Martinez', 'oliviamartinez@example.com')

select * from Customers

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT
);

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1)

  Select * from Orders


CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99)

  select * from products


  SElect * from Customers

  SELECT name, email
FROM customers
WHERE name LIKE 'J%';

Select * from Orders

SELECT SUM(quantity) AS total_quantity
FROM orders;


SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.CustomerID = o.OrderID;

SELECT ProductName, price
FROM products
WHERE price > 10.00;

SELECT c.name, o.OrderDate
FROM customers c
JOIN orders o ON c.CustomerID = o.OrderID
WHERE o.OrderDate>= '2023-07-05';

SELECT AVG(price) AS average_price
FROM products;

SELECT c.name, SUM(o.quantity) AS total_quantity
FROM customers c
JOIN orders o ON c.CustomerID = o.OrderID
GROUP BY c.name;


SELECT p.ProductName
FROM products p
LEFT JOIN orders o ON p.ProductID = o.OrderID
WHERE o.OrderID IS NULL;


SELECT TOP 5
    CustomerID,
    SUM(quantity) AS total_quantity
FROM 
    orders
GROUP BY 
    CustomerID
ORDER BY 
    total_quantity DESC;

	SELECT 
    ProductID,
    ProductName,
    AVG(price) AS average_price
FROM 
    products
GROUP BY 
    ProductID, 
    ProductName;

	SELECT 
    c.CustomerID,
    c.Name
FROM 
    customers c
LEFT JOIN 
    orders o
ON 
    c.CustomerID = o.CustomerID
WHERE 
    o.CustomerID IS NULL;

	SELECT 
    o.OrderID,
    o.ProductName,
    o.Quantity
FROM 
    customers c
JOIN 
    orders o ON c.CustomerID = o.OrderID
JOIN 
    Orders  ON o.OrderID= o.OrderID
WHERE 
    c.name LIKE 'M%';




	SELECT 
    SUM(o.Quantity * p.Price) AS total_revenue
FROM 
    Orders o
JOIN 
    Products p ON o.ProductName = p.ProductName;


	SELECT 
    c.Name,
    SUM(o.Quantity * p.Price) AS total_revenue
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Products p ON o.ProductName = p.ProductName
GROUP BY 
    c.Name


	SELECT 
    c.CustomerID,
    c.Name
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    Products p ON o.ProductName = p.ProductName
GROUP BY 
    c.CustomerID, c.Name
HAVING 
    COUNT(DISTINCT p.Price) = (SELECT COUNT(DISTINCT Price) FROM Products);


	SELECT DISTINCT
    o1.CustomerID,
    c.Name
FROM 
    Orders o1
JOIN 
    Orders o2 ON o1.CustomerID = o2.CustomerID
JOIN 
    Customers c ON o1.CustomerID = c.CustomerID
WHERE 
    o1.OrderDate = DATEADD(day, 1, o2.OrderDate);



	SELECT TOP 3
    p.ProductID,
    p.ProductName,
    AVG(o.Quantity) AS avg_quantity
FROM 
    Orders o
JOIN 
    Products p ON o.OrderID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    avg_quantity DESC;



SELECT 
    COUNT(CASE WHEN Quantity > avg_quantity THEN 1 END) * 100.0 / COUNT(*) AS percentage_orders
FROM 
    Orders
CROSS JOIN 
    (SELECT AVG(Quantity) AS avg_quantity FROM Orders) AS avg_table;



	SELECT 
    c.CustomerID,
    c.Name
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.Name
HAVING 
    COUNT(DISTINCT o.OrderID) = (SELECT COUNT(DISTINCT ProductID) FROM Products);


	
---2 	SELECT 
    p.ProductID,
    p.ProductName
FROM 
    Products p
JOIN 
    Orders o ON p.ProductID = o.OrderID
GROUP BY 
    p.ProductID, p.ProductName
HAVING 
    COUNT(DISTINCT o.CustomerID) = (SELECT COUNT(DISTINCT CustomerID) FROM Customers);


 ALTER TABLE Orders ADD Price DECIMAL(10, 2);


 SELECT 
    FORMAT(OrderDate, 'yyyy-MM') AS month, 
    SUM(Quantity * Price) AS total_revenue
FROM 
    Orders
GROUP BY 
    FORMAT(OrderDate, 'yyyy-MM')
ORDER BY 
    month;


	WITH CustomerCounts AS (
    SELECT 
        ProductName, 
        COUNT(DISTINCT CustomerID) AS customer_count
    FROM 
        Orders
    GROUP BY 
        ProductName
), TotalCustomers AS (
    SELECT 
        COUNT(DISTINCT CustomerID) AS total_customers
    FROM 
        Orders
)
SELECT 
    ProductName
FROM 
    CustomerCounts, TotalCustomers
WHERE 
    CustomerCounts.customer_count > TotalCustomers.total_customers * 0.5;


	SELECT TOP 5 
    CustomerID, 
    SUM(Quantity) AS total_quantity
FROM 
    Orders
GROUP BY 
    CustomerID
ORDER BY 
    total_quantity DESC;

--6 SELECT 
    OrderID,
    CustomerID, 
    OrderDate, 
    Quantity,
    SUM(Quantity) OVER (PARTITION BY CustomerID ORDER BY OrderDate, OrderID) AS running_total
FROM 
    Orders
ORDER BY 
    CustomerID, OrderDate, OrderID


	SELECT 
    OrderID,
    CustomerID,
    OrderDate
FROM 
    Orders o1
WHERE 
    (SELECT COUNT(*) 
     FROM Orders o2 
     WHERE o1.CustomerID = o2.CustomerID 
       AND o1.OrderDate <= o2.OrderDate) <= 3
ORDER BY 
    CustomerID, OrderDate DESC;



	
--- 8

SELECT
    CustomerID,
    SUM(Quantity) AS total_revenue
FROM
    Orders
WHERE
    OrderDate >= DATEADD(day, -30, GETDATE())
GROUP BY
    CustomerID;




SELECT
    CustomerID
FROM
    orders
WHERE
    CustomerID IN (
        SELECT
            CustomerID
        FROM
            Orders
            JOIN products ON Orders.OrderID = products.ProductID
        GROUP BY
            CustomerID
        HAVING
            COUNT(DISTINCT products.ProductName) >= 2
    );


	--10

 
 SELECT
    o.CustomerID,
    AVG(o.Quantity * p.Price) AS AverageRevenuePerOrder
FROM
    Orders o
JOIN
    Products p ON o.ProductName = p.ProductName
GROUP BY
    o.CustomerID;

	---11

	DECLARE @Year INT = 2023;

SELECT
    CustomerID
FROM
    (
        SELECT
            CustomerID,
            MONTH(OrderDate) AS OrderMonth
        FROM
            Orders
        WHERE
            YEAR(OrderDate) = @Year
        GROUP BY
            CustomerID,
            MONTH(OrderDate)
    ) AS MonthlyOrders
GROUP BY
    CustomerID
HAVING
    COUNT(DISTINCT OrderMonth) = 12; -- Assuming you're interested in all 12 month

	---12

	DECLARE @ProductName VARCHAR(50) = 'SpecificProduct';

SELECT DISTINCT
    o1.CustomerID
FROM
    Orders o1
JOIN
    Orders o2 ON o1.CustomerID = o2.CustomerID
            AND o1.ProductName = o2.ProductName
            AND DATEDIFF(MONTH, o1.OrderDate, o2.OrderDate) = 1
JOIN
    Products p ON o1.ProductName = p.ProductName
WHERE
    o1.ProductName = @ProductName;



---13 DECLARE @CustomerID INT = 10;

SELECT
    od.ProductName
FROM
    Orders o
JOIN
    Orders od ON o.OrderID = od.OrderID
WHERE
    o.CustomerID = @CustomerID
GROUP BY
    od.ProductName
HAVING
    COUNT(*) >= 2;