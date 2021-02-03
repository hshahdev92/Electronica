DROP DATABASE IF EXISTS [Electronica];
CREATE DATABASE [Electronica]
GO

USE [Electronica]

GO 


-- Creating Customer
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer(
	CustomerID INT NOT NULL IDENTITY(1001,1),
	FirstName CHAR(25) NOT NULL,
	MiddleName CHAR(25) DEFAULT NULL,
	LastName CHAR(25) NOT NULL,
	EmailID VARCHAR(55) NOT NULL,
	DateOfBirth DATE DEFAULT NULL,
	Phone VARCHAR(10) NOT NULL,
CONSTRAINT Customer_PK PRIMARY KEY (CustomerID)
);


-- Creating Cart
DROP TABLE IF EXISTS Cart;
CREATE TABLE Cart(
	CartID INT NOT NULL,
	CustomerID INT NOT NULL,
	TotalNoOfItems INT DEFAULT NULL,
	TotalPrice FLOAT DEFAULT NULL,
CONSTRAINT Cart_PK PRIMARY KEY (CartID),
CONSTRAINT CrtCust_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


-- Creating Wishlist
DROP TABLE IF EXISTS Wishlist;
CREATE TABLE Wishlist(
	WishListID INT NOT NULL,
	CustomerID INT NOT NULL,
	CartID INT NOT NULL,
CONSTRAINT Wishlist_PK PRIMARY KEY (WishListID, CustomerID),
CONSTRAINT WishCust_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT WishCrt_FK FOREIGN KEY (CartID) REFERENCES Cart(CartID)
);


-- Creating Account
DROP TABLE IF EXISTS Account;
CREATE TABLE Account(
	AccountID INT NOT NULL IDENTITY(1,1),
	AccountType CHAR(7) NOT NULL,
	CustomerID INT NOT NULL,
	CartID INT NOT NULL,
	WishlistID INT NOT NULL,
CONSTRAINT Account_PK PRIMARY KEY(AccountID),
CHECK(AccountType IN ('Regular', 'Prime')),
CONSTRAINT AccCust_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT AccCrt_FK FOREIGN KEY (CartID) REFERENCES Cart(CartID),
CONSTRAINT AccWish_FK FOREIGN KEY (WishlistID, CustomerID) REFERENCES Wishlist(WishlistID, CustomerID)
);


-- Creating Carrier
DROP TABLE IF EXISTS Carrier;
CREATE TABLE Carrier(
	CarrierID INT NOT NULL,
	CarrierName VARCHAR(45) NOT NULL,
CONSTRAINT Carrier_PK PRIMARY KEY (CarrierID)
);


-- Creating Zip
DROP TABLE IF EXISTS Zip;
CREATE TABLE Zip(
    ZipCode VARCHAR(6) NOT NULL, -- added 6 on VARCHAR
 	City CHAR(25) NOT NULL,
	[State] CHAR(25) NOT NULL,
	Country CHAR(25) NOT NULL
CONSTRAINT Zip_PK PRIMARY KEY (ZipCode)
);


-- Creating Address (Incomplete / we can break into two trabvles as zipcode and address) and changed the name to [Address] and [state]
DROP TABLE IF EXISTS [Address];
CREATE TABLE [Address](
	AddressID INT NOT NULL IDENTITY(1,1),
	StreetName VARCHAR(45) DEFAULT NULL,
	AptNo VARCHAR(10) DEFAULT NULL,
	ZipCode VARCHAR(6) NOT NULL, -- added 6 on VARCHAR
CONSTRAINT Address_PK PRIMARY KEY (AddressID),
CONSTRAINT AddZip_FK FOREIGN KEY (ZipCode) REFERENCES Zip(ZipCode)
);


-- Creating Customer Has Address // Added the whole table
DROP TABLE IF EXISTS CustomerHasAddress
CREATE TABLE CustomerHasAddress(
    CustomerID INT NOT NULL,
	AddressID INT NOT NULL,
CONSTRAINT CustHasAdd_PK PRIMARY KEY (CustomerID,AddressID),
CONSTRAINT CustHasAddAdd_FK FOREIGN KEY (AddressID) REFERENCES [Address](AddressID),
CONSTRAINT CustHasAddCus_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


-- Creating Orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
	OrderID INT NOT NULL IDENTITY(1,1),
	OrderDate DATETIME NOT NULL,
	ShippedDate DATETIME DEFAULT NULL,
	OrderQuanitiy INT DEFAULT NULL,
	ShippingType CHAR(20) NOT NULL DEFAULT 'Standard Shipping',
	OrderAmount FLOAT DEFAULT NULL,
	CustomerID INT NOT NULL,
	CarrierID INT NOT NULL,
	CartID INT NOT NULL,
	AddressID INT DEFAULT NULL,
	ShippingCharges FLOAT NOT NULL,
CONSTRAINT Orders_PK PRIMARY KEY (OrderID),
CHECK(ShippingType IN ('Standard Shipping','Speedy delivery')),
CONSTRAINT OrdCust_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT OrdCarr_FK FOREIGN KEY (CarrierID) REFERENCES Carrier(CarrierID),
CONSTRAINT OrdCrt_FK FOREIGN KEY (CartID) REFERENCES Cart(CartID),
CONSTRAINT OrdAdd_FK FOREIGN KEY (AddressID) REFERENCES [Address](AddressID)
);


-- Creating BillingInfo (Composite Primary key -- Have discussion about OrderID --- Explain DEFAULT--- Should we include customerID in the foreign key reference ?)
DROP TABLE IF EXISTS BillingInfo;
CREATE TABLE BillingInfo (
	BillingID INT NOT NULL IDENTITY(1,1),
	CardType CHAR(15) NOT NULL,
	CardNumber INT DEFAULT NULL,
	BillDate DATETIME DEFAULT NULL,
	CardExpDate DATE DEFAULT NULL,
	CustomerID INT NOT NULL,
	OrderID INT DEFAULT NULL,
CONSTRAINT BillingInfo_PK PRIMARY KEY (BillingID,CustomerID),
CONSTRAINT BillCust_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT BillOrd_FK FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CHECK(CardType in ('Debit Card', 'Credit Card'))
);


-- Creating Category
DROP TABLE IF EXISTS Category;
CREATE TABLE Category(
	CategoryID INT NOT NULL ,
	CategoryName CHAR(25) NOT NULL,
CONSTRAINT Category_PK PRIMARY KEY (CategoryID)
);


-- Creating Manufacturer
DROP TABLE IF EXISTS Manufacturer;
CREATE TABLE Manufacturer(
	ManufacturerID INT NOT NULL,
	ManufacturerName VARCHAR(45) NOT NULL,
	AdditionalInfo VARCHAR(45) DEFAULT NULL,
	CategoryID INT NOT NULL
CONSTRAINT Manufacturer_PK PRIMARY KEY (ManufacturerID),
CONSTRAINT ManCat_FK FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);


-- Creating Product
DROP TABLE IF EXISTS Product;
CREATE TABLE Product(
	ProductID INT NOT NULL IDENTITY(1,1),
	ProductName VARCHAR(65) NOT NULL,
    UnitPrice FLOAT DEFAULT NULL,
    UnitsInStock INT DEFAULT NULL,
    UnitsInOrder INT DEFAULT NULL,
    CategoryID INT NOT NULL,
    ManufacturerID INT NOT NULL,
CONSTRAINT Product_PK PRIMARY KEY(ProductID), 
CONSTRAINT ProCat_FK FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
CONSTRAINT ProMan_FK FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);


-- Creating  Wishlist Has Product// Associative Entity
DROP TABLE IF EXISTS WishlistHasProduct;
CREATE TABLE WishlistHasProduct(
	WishlistID INT NOT NULL,
	ProductID INT NOT NULL,
CONSTRAINT WishHasProd_PK PRIMARY KEY (WishlistID, ProductID),
CONSTRAINT WishHasProdProd_FK FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Creating Review
DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
	ReviewID INT NOT NULL,
	ReviewDescription VARCHAR(250) DEFAULT NULL,
	Ratings CHAR(1) NOT NULL,
	ProductID INT NOT NULL,
	CustomerID INT NOT NULL,
CONSTRAINT Review_PK PRIMARY KEY (ReviewID),
CHECK(Ratings in ('1','2','3','4','5')), -- comma
CONSTRAINT RevCust_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT RevProd_FK FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Creating Payment
DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment(
	PaymentID INT NOT NULL,
	PaymentDate DATETIME NOT NULL,
	PaymentAmount FLOAT NOT NULL,
    PaymentMode CHAR(15) NOT NULL,
	CustomerID INT NOT NULL,
	OrderID INT NOT NULL,
CONSTRAINT Payment_PK PRIMARY KEY (PaymentID),
CONSTRAINT PayCust_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT PayOrd_FK FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CHECK(PaymentMode IN ('Debit Card','Credit Card','Cash'))
);


-- Creating OrderItem --- (Discuss)
DROP TABLE IF EXISTS OrderItem;
CREATE TABLE OrderItem(
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	UnitPrice FLOAT DEFAULT NULL, -- Added
	Quantity INT DEFAULT NULL,  -- Added
CONSTRAINT OrdItem_PK PRIMARY KEY (OrderID, ProductID),
CONSTRAINT OrdItemOrd_FK FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CONSTRAINT OrdItemProd_FK FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Creating Supplier
DROP TABLE IF EXISTS Supplier;
CREATE TABLE Supplier(
	SupplierID INT NOT NULL,
	SupplierName CHAR(25) NOT NULL,
	SupplierContact VARCHAR(10) DEFAULT NULL,
	SupplierLocation VARCHAR(50) NOT NULL
CONSTRAINT Supplier_PK PRIMARY KEY (SupplierID)
);


-- Creating RawMaterial
DROP TABLE IF EXISTS RawMaterial;
CREATE TABLE RawMaterial(
	RawMaterialID INT NOT NULL,
	NoOfParts INT NOT NULL,
	CostPerPart FLOAT DEFAULT NULL,
CONSTRAINT RawMaterial_PK PRIMARY KEY (RawMaterialID)
);


-- Creating Supplier Has RawMaterial // Associative Entity
DROP TABLE IF EXISTS SupplierHasRawMaterial;
CREATE TABLE SupplierHasRawMaterial(
	SupplierID INT NOT NULL,
	RawMaterialID INT NOT NULL,
	RawMaterialPartNum INT NOT NULL,
CONSTRAINT SupHasRM_PK PRIMARY KEY (SupplierID, RawMaterialID),
CONSTRAINT SupHasRMSup_FK FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
CONSTRAINT SupHasRMMat_FK FOREIGN KEY (RawMaterialID) REFERENCES RawMaterial(RawMaterialID)
);


-- Creating Supplier Has Manufacturer // Associative Entity
DROP TABLE IF EXISTS SupplierHasManufacturer;
CREATE TABLE SupplierHasManufacturer(
	SupplierID INT NOT NULL,
	ManufacturerID INT NOT NULL,	
CONSTRAINT SupHasMan_PK PRIMARY KEY (SupplierID, ManufacturerID),
CONSTRAINT SupHasManSup_FK FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
CONSTRAINT SupHasManMan_FK FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);

