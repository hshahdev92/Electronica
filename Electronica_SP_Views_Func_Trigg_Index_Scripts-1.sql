------------------------------------------------------------------------
-- STORED PROCEDURE EXECUTION STATEMENT
------------------------------------------------------------------------
-- 1) Stored Procedure to get Customer with Frequent Orders
CREATE PROCEDURE GetFrequentCustomer 
(
@purchase_year INT,
@frequent_customer INT OUTPUT
)
AS 
BEGIN

DECLARE @FrequentCustomerID int

SELECT @FrequentCustomerID = CustomerID
FROM Orders 
GROUP BY CustomerID
HAVING COUNT(CustomerID) = (
SELECT MAX(Temp.CustomerIDCount)
FROM 
(
	SELECT Orders.CustomerID AS CustomerID, COUNT(Orders.CustomerID) AS CustomerIDCount 
	FROM Orders
	WHERE DATEPART(yy, OrderDate) = @purchase_year  
	GROUP BY Orders.CustomerID 
) AS Temp);

SET @frequent_customer = @FrequentCustomerID;

END;

---Execute the stored procedure
DECLARE @customer INT;

EXEC GetFrequentCustomer
    @purchase_year = 2020,
    @frequent_customer = @customer OUTPUT;

SELECT @customer AS 'Frequent Customer';

------------------------------------------------------------------------------
-- STORED PROCEDURE EXECUTION STATEMENT
------------------------------------------------------------------------------
---2) Stored Procedure to get the Order Details of the Customer

CREATE PROCEDURE GetOrderDetails 
(
@orderID INT,
@productName VARCHAR(65) OUTPUT,
@productUnitPrice FLOAT OUTPUT,
@orderQuantity INT OUTPUT,
@productPrice FLOAT OUTPUT
)
AS
BEGIN

DECLARE 
@name VARCHAR(65),
@unitPrice FLOAT,
@quantity INT,
@totalProductPrice FLOAT
SELECT @name = Temp.ProductName, @unitPrice = Temp.UnitPrice, @quantity = Temp.Quantity, @totalProductPrice = Temp.ProductPrice 
FROM(
SELECT Product.ProductName, Product.UnitPrice, OrderItem.Quantity, 
ROUND(OrderItem.Quantity * OrderItem.UnitPrice,0) AS ProductPrice 
FROM Product
INNER JOIN OrderItem 
ON OrderItem.ProductID = Product.ProductID
WHERE OrderItem.OrderID = @orderID
) AS TEMP
SET @productName = @name;
SET @productUnitPrice = @unitPrice;
SET @orderQuantity = @quantity;
SET @productPrice = @totalProductPrice;
 
END;

---Execute the stored procedure
DECLARE 
@pname VARCHAR(65),
@opunitprice FLOAT,
@oquantity INT,
@pprice FLOAT

EXEC GetOrderDetails
    @orderID = 1,
    @productName = @pname OUTPUT,
@productUnitPrice = @opunitprice OUTPUT,
@orderQuantity = @oquantity OUTPUT,
@productPrice = @pprice OUTPUT;

SELECT @pname, @opunitprice, @oquantity, @pprice ;

-------------------------------------------------------------------
-- STORED PROCEDURE EXECUTION STATEMENT
-------------------------------------------------------------------
-- 3) Stored Procedure to get a Customer Order History
CREATE PROCEDURE CustomerOrderHistory 
(
@customerID INT
)
AS
BEGIN
SELECT Orders.OrderID, Orders.OrderQuanitiy, Orders.OrderDate, Orders.ShippedDate, Orders.OrderAmount
FROM Orders
WHERE Orders.CustomerID = 1008
END;


EXEC CustomerOrderHistory
    @customerID = 1008




-------------------------------------------------------------------------
-- VIEW AND EXECUTION STATEMENT
-------------------------------------------------------------------------
-- 1) View to get the Order Deatils
USE Electronica;
GO
CREATE VIEW OrderDetails
AS
SELECT OrderItem.OrderID, OrderItem.ProductID, Product.ProductName, OrderItem.UnitPrice, OrderItem.Quantity,
ROUND(OrderItem.UnitPrice * OrderItem.Quantity,0) AS "ExtendedPrice"
FROM Product
JOIN OrderItem
ON Product.ProductID = OrderItem.ProductID;

EXEC('SELECT * FROM OrderDetails;')

--------------------------------------------------------------------------
-- VIEW AND EXECUTION STATEMENT
--------------------------------------------------------------------------
-- 2) View to get Sales by Category of the products
USE Electronica ;   
GO  
CREATE VIEW SalesByCategory AS 
SELECT Category.CategoryID AS 'CategoryID',
Category.CategoryName AS 'CategoryName',
Product.ProductName AS 'ProductName',
SUM(OrderItem.UnitPrice * OrderItem.Quantity) AS 'TotalSales'
FROM Category
JOIN Product 
ON Category.CategoryID = Product.CategoryID
JOIN OrderDetails 
ON Product.ProductID = OrderDetails.ProductID
JOIN Orders 
ON Orders.OrderID = OrderDetails.OrderID
JOIN OrderItem
ON Orders.OrderID =OrderItem.OrderID
WHERE Orders.OrderDate BETWEEN '2018-07-16' AND '2020-12-02'
GROUP BY Category.CategoryID, Category.CategoryName, Product.ProductName
GO

SELECT * FROM SalesByCategory


-------------------------------------------------------------------------
-- FUNCTION AND EXECUTION STATEMENT
-------------------------------------------------------------------------
-- 1) Function to get the Full Name of the Customer
CREATE FUNCTION GetCustomerName(@customerID int)
RETURNS varchar(100)
AS
BEGIN  
DECLARE @customer_name varchar(100) 
SELECT @customer_name = customer.FirstName + ' ' + customer.MiddleName + ' ' + customer.LastName
from Customer customer 
WHERE customer.CustomerID = @customerID
RETURN @customer_name
END
GO

--select GetCustomerName(CustomerID = 1001) as FullName from Customer

DECLARE @fullName VARCHAR(100)
  EXEC @fullName = GetCustomerName '1001'
  SELECT @fullName AS FullName

-----------------------------------------------------------------------
-- FUNCTION AND EXECUTION STATEMENT
-----------------------------------------------------------------------
-- 2) Function to Calculate the Count of the types of Shipping Modes Used for delivery of orders
CREATE FUNCTION CalculateNoOfShippingType(@shippingtype CHAR(20))
RETURNS INT
AS
BEGIN
DECLARE @noOfShippingType INT
SELECT @noOfShippingType = COUNT(ShippingType)
FROM Orders
WHERE Orders.ShippingType = @shippingtype
RETURN @noOfShippingType
END
GO

DECLARE @count VARCHAR(100)
  EXEC @count = CalculateNoOfShippingType 'Speedy Delivery'
  SELECT @count AS NoOfTimes


---------------------------------------------------------------------------
-- TRIGGERS AND EXECUTION STATEMENT
---------------------------------------------------------------------------
-- 1) Trigger to get an Update on Product Quantity

CREATE TRIGGER UpdateProductQuantity
ON Payment 
AFTER INSERT
AS 
BEGIN
UPDATE Product 
SET UnitsInStock = UnitsInStock - OrderItem.Quantity
FROM Payment
INNER JOIN OrderItem
ON OrderItem.OrderID = Payment.OrderID
INNER JOIN Product
ON Product.ProductID = OrderItem.ProductID
END


-------------------------------------------------------------------------------
-- NON - CLUSTERED INDEXES AND EXECUTION STATEMENT
-------------------------------------------------------------------------------
USE Electronica;
GO
CREATE NONCLUSTERED INDEX idx_cust_phone ON Customer(Phone)
GO
CREATE NONCLUSTERED INDEX idx_cust_lastName ON Customer(LastName)
GO
CREATE NONCLUSTERED INDEX idx_zip_city ON Zip(City)
GO
CREATE NONCLUSTERED INDEX idx_zip_state ON Zip([State])
GO
CREATE NONCLUSTERED INDEX idx_prod_productName ON Product(ProductName)
GO
CREATE NONCLUSTERED INDEX idx_supp_location ON Supplier(SupplierLocation)
GO

