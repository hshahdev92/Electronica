USE [Electronica]
GO

INSERT INTO [dbo].[Customer]
           ([FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[EmailID]
           ,[DateOfBirth]
           ,[Phone])
     VALUES
           ('Harsh','Kunal','Shahdev','shahdev.h@northeastern.edu','1984-08-19','6177579164'),
		   ('Kamini','Prem','Prakash','prakash.k@northeastern.edu','1987-02-20','6178759161'),
		   ('Sakshi','Dharmesh','Gupta','gupta.s@northeastern.edu','1982-10-09','8771579194'),
		   ('Nandika','Sanjay','Vasanthmurali','vasanthmurali.n@northeastern.edu','1979-12-21','9177577787'),
		   ('Steve','George','Smith','smith.h@northeastern.edu','1964-01-27','7176578762'),
		   ('Vyoma','Tejas','Patel','patel.vy@northeastern.edu','1964-10-20','8577577814'),
		   ('Karan','Brijesh','Soni','soni.ka@northeastern.edu','1975-09-21','7171572161'),
		   ('Kelly','Stuart','Moore','moore.k@northeastern.edu','1991-01-10','9144471243'),
		   ('Andrew','Craig','Mark','mark.a@northeastern.edu','1982-10-29','6177578784'),
		   ('Akash','Prasanta','Sinha','sinha.ak@northeastern.edu','1987-10-20','6474719174')
GO

INSERT INTO [dbo].[Cart]
           ([CartID]
           ,[CustomerID]
           ,[TotalNoOfItems]
           ,[TotalPrice])
     VALUES
           (1, 1001, 7, 4900),
		   (2, 1002, 10, 6100),
		   (3, 1003, 8, 2000),
		   (4, 1004, 12, 3000),
		   (5, 1005, 7, 4690),
		   (6, 1006, 4, 1800),
		   (7, 1007, 7, 5950),
		   (8, 1008, 2, 1560),
		   (9, 1009, NULL, NULL),
		   (10,1010, NULL, NULL)
GO


INSERT INTO [dbo].[Wishlist]
           ([WishListID]
           ,[CustomerID]
           ,[CartID])
     VALUES
           (1, 1001, 1),
		   (2, 1002, 2),
		   (3, 1003, 3),
		   (4, 1004, 4),
		   (5, 1005, 5),
		   (6, 1006, 6),
		   (7, 1007, 7),
		   (8, 1008, 8),
		   (9, 1009, 9),
		   (10, 1010, 10)
GO

INSERT INTO [dbo].[Account]
           ([AccountType]
           ,[CustomerID]
           ,[CartID]
           ,[WishlistID])
     VALUES
           ('Prime', 1001, 1, 1),
		   ('Regular', 1002, 2, 2),
		   ('Regular', 1003, 3, 3),
		   ('Prime', 1004, 4, 4),
		   ('Regular', 1005, 5, 5),
		   ('Prime', 1006, 6, 6),
		   ('Prime', 1007, 7, 7),
		   ('Regular', 1008, 8, 8),
		   ('Regular', 1009, 9, 9),
		   ('Prime', 1010, 10, 10)	   

GO

INSERT INTO [dbo].[Carrier]
           ([CarrierID]
           ,[CarrierName])
     VALUES
           (5001, 'UPS'),
		   (5002, 'FedEx'),
		   (5003, 'DHL'),
		   (5004, 'Maersk'),
		   (5005, 'Atlantic'),
		   (5006, 'BlueDart'),
		   (5007, 'FirstFlight'),
		   (5008, 'Professional'),
		   (5009, 'USPS'),
		   (5010, 'DTDC'),
		   (5011, 'TNT Express'),
		   (5012, 'Aramex'),
		   (5013, 'Royal Mail'),
		   (5014, 'Deutche Post')
GO

INSERT INTO [dbo].[Zip]
           ([ZipCode]
           ,[City]
           ,[State]
           ,[Country])
     VALUES
           ('02120', 'Boston', 'MA', 'USA'),
		   ('02122', 'Quincy', 'MA', 'USA'),
		   ('02130', 'Jamaica Plain', 'MA', 'USA'),
		   ('02135', 'New York City', 'NY', 'USA'),
		   ('02256', 'Los Angeles', 'CA', 'USA'),
		   ('02476', 'Arlington', 'TX', 'USA'),
		   ('10001', 'Ney York', 'NY', 'USA'),
		   ('28105', 'Charlotte', 'NC', 'USA'),
		   ('32003', 'Orange Park', 'FL', 'USA'),
		   ('32006', 'Fleming Island', 'FL', 'USA'),
		   ('75001', 'Dallas', 'TX', 'USA')
GO

INSERT INTO [dbo].[Address]
           ([StreetName]
           ,[AptNo]
           ,[ZipCode])
     VALUES
           ('Tetlow Street', '31', '02120'),
		   ('Columbus Ave', '40', '02122'),
		   ('Mass Avenue', '9', '02130'),
		   ('30 South Huntington Ave', '1', '02130'),
		   ('Islington Street', '41', '02135'),
		   ('Harvard Avenue', '37', '02256'),
		   ('Ward Street', '110 B', '02476'),
		   ('Wall Street', '778', '10001'),
		   ('Beacon Street', '25 A', '32006'),
		   ('Verndale Street', '34', '32003'),
		   ('Huntington Avenue', '807', '28105'),
		   ('South End Corner', '1204', '75001'),
		   ('Allston Street', '704', '75001'),
		   ('Commonwealth Avenue', '331', '02120')
GO

INSERT INTO [dbo].[CustomerHasAddress]
           ([CustomerID]
           ,[AddressID])
     VALUES
           (1001, 1),
		   (1001, 2),
		   (1002, 3),
		   (1003, 4),
		   (1004, 5),
		   (1005, 3),
		   (1006, 6),
		   (1007, 7),
		   (1008, 8),
		   (1009, 9),
		   (1010, 10)

GO


INSERT INTO [dbo].[Orders]
           ([OrderDate]
           ,[ShippedDate]
           ,[OrderQuanitiy]
           ,[ShippingType]
           ,[OrderAmount]
           ,[CustomerID]
           ,[CarrierID]
           ,[CartID]
           ,[AddressID]
           ,[ShippingCharges])
     VALUES
           ('2020-12-02', '2020-12-05', 7, 'Standard Shipping', 4900, 1001, 5003, 1, 1, 10.0),
		   ('2020-11-20', '2020-11-24', 10, 'Standard Shipping', 6100, 1002, 5002, 2, 3, 20.0),
		   ('2020-10-12', '2020-10-13', 8, 'Speedy Delivery', 2000, 1003, 5004, 3, 4, 15.0),
		   ('2020-09-12', '2020-09-13', 12, 'Speedy Delivery', 3000, 1004, 5005, 4, 5, 18.0),
		   ('2020-08-01', '2020-08-06 ', 4, 'Standard Shipping', 1800, 1006, 5006, 6, 6, 5.0),
		   ('2020-07-01', '2020-07-05', 7, 'Standard Shipping', 5950, 1007, 5011, 7, 7, 9.0),
		   ('2020-10-10', '2020-10-14', 2, 'Standard Shipping', 1560, 1008, 5008, 8, 8, 0.0),
		   ('2020-11-11', '2020-11-12', 3, 'Speedy Delivery', 936, 1008, 5009, 8, 8, 5.0),
		   ('2020-07-15', '2020-07-19', 10, 'Standard Shipping', 1700, 1008, 5014, 8, 8, 10.0),
		   ('2019-09-15', '2019-09-19', 7, 'Standard Shipping', 4690, 1005, 5010, 5, 3, 5.0),
		   ('2018-07-16', '2018-07-17', 6, 'Speedy Delivery', 4020, 1001, 5007, 1, 2, 7.0)
GO

INSERT INTO [dbo].[BillingInfo]
           ([CardType]
           ,[CardNumber]
           ,[BillDate]
           ,[CardExpDate]
           ,[CustomerID]
           ,[OrderID])
     VALUES
           ('Debit Card', '1235467580', '2020-12-02', '2025-01-01', 1001, 1),
		   ('Debit Card', '3435467587', '2020-11-20', '2025-11-01', 1002, 2),
		   ('Credit Card', '4435467586', '2020-10-12', '2024-10-01', 1003, 3),
		   ('Credit Card', '7734468582', '2020-09-12', '2023-09-01', 1004, 4),
		   ('Debit Card', '8723467581', '2020-08-01', '2023-08-11', 1006, 5),
		   ('Debit Card', '7787455580', '2020-07-01', '2025-06-01', 1007, 6),
		   ('Credit Card', '9786675802', '2020-10-10', '2025-10-01', 1008, 7),
		   ('Debit Card', '4644527120', '2020-11-11', '2025-11-01', 1008, 8),
		   ('Debit Card', '4645488580', '2020-07-15', '2021-07-01', 1008, 9),
		   ('Credit Card', '5461247580', '2019-09-15', '2025-09-01', 1005, 10),
		   ('Debit Card', '4624758014', '2018-07-16', '2023-07-01', 1001, 11)
GO

INSERT INTO [dbo].[Category]
           ([CategoryID]
           ,[CategoryName])
     VALUES
           (1, 'Mobile Devices'),
		   (2, 'Television'),
		   (3, 'Computers'),
		   (4, 'Laptops'),
		   (5, 'Car Electronics and GPS'),
		   (6, 'Printers'),
		   (7, 'Cameras'),
		   (8, 'Home Appliances'),
		   (9, 'Speakers'),
		   (10, 'Headphones')
GO

INSERT INTO [dbo].[Manufacturer]
           ([ManufacturerID]
           ,[ManufacturerName]
           ,[AdditionalInfo]
           ,[CategoryID])
     VALUES
           (1, 'Delta',NULL, 1),
		   (2, 'Welt', NULL, 2),
		   (3, 'Vertex', NULL, 3),
		   (4, 'Omega', NULL, 1),
		   (5, 'Avzilla', NULL, 4),
		   (6, 'Beacon', NULL, 5),
		   (7, 'Eagle', NULL, 6),
		   (8, 'Concord', NULL, 1),
		   (9, 'Mind', NULL, 7),
		   (10, 'Impluse', NULL, 8),
		   (11, 'Climax', NULL, 9),
		   (12, 'Apple', 'Mobile Manufacturer', 1),
		   (13, 'Dell', 'Laptop Manufacturer', 4),
		   (14, 'Bose Inc', 'Headphones and Speakers', 10)
GO

INSERT INTO [dbo].[Product]
           ([ProductName]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsInOrder]
           ,[CategoryID]
           ,[ManufacturerID])
     VALUES
           ('Samsung Galaxy S10', 700, 40, 2, 1, 1),
		   ('Sony Bravia', 400, 26, 1, 2, 2),
		   ('Iphone 12', 750, 50, 3, 1, 12),
		   ('Bose Headphones 700', 250, 13, 4, 10, 14),
		   ('Insignia TV', 450, 20, 2, 2, 2),
		   ('Dell PC', 850, 45, 4, 3, 13),
		   ('Lenovo Yoga', 780, 56, 7, 4, 5),
		   ('Hp Printer 3380', 312, 12, 5, 6, 7),
		   ('Oseter Blender', 170, 67, 10, 8, 10),
		   ('Nikon 5200', 670, 34, 15, 7, 9)

GO

INSERT INTO [dbo].[WishlistHasProduct]
           ([WishlistID]
           ,[ProductID])
     VALUES
           (1,1),
		   (2,2),
		   (3,3),
		   (4,4),
		   (5,5),
		   (6,6),
		   (7,7),
		   (8,8),
		   (9,9),
		   (10,10)
GO

INSERT INTO [dbo].[Review]
           ([ReviewID]
           ,[ReviewDescription]
           ,[Ratings]
           ,[ProductID]
           ,[CustomerID])
     VALUES
           (1, 'Great Produt. Would recommend 100%', '5', 1, 1001),
		   (2, 'Poor Performance', '1', 2, 1002),
		   (3, 'Poor Quality, would not recommend this product', '2', 3, 1002),
		   (4, 'Decent built quality and good performance', '4', 4, 1003),
		   (5, 'Got this for my Mom, she loved it', '5', 5, 1006),
		   (6, 'Facing trouble with battery life', '1', 6, 1007),
		   (7, 'Loving it. Easy to setup. One of the best buys I have made.', '5', 7, 1008),
		   (8, 'Great print quality', '3', 8, 1008),
		   (9, 'DO NOT BUY THIS', '1', 9, 1008),
		   (10, 'Terrific picture quality, easy to use', '5', 10, 1005)
GO

INSERT INTO [dbo].[Payment]
           ([PaymentID]
           ,[PaymentDate]
           ,[PaymentAmount]
           ,[PaymentMode]
           ,[CustomerID]
           ,[OrderID])
     VALUES
           (1, '2020-12-02', 4900, 'Debit Card', 1001, 1),
		   (2, '2020-11-20', 6100, 'Debit Card', 1002, 2),
		   (3, '2020-10-12', 2000, 'Credit Card', 1003, 3),
		   (4, '2020-09-12', 3000, 'Credit Card', 1004, 4),
		   (5, '2020-08-01', 1800, 'Debit Card', 1006, 5),
		   (6, '2020-07-01', 5950, 'Debit Card', 1007, 6),
		   (7, '2020-10-10', 1560, 'Credit Card', 1008, 7),
		   (8, '2020-11-11', 936, 'Debit Card', 1008, 8),
		   (9, '2020-07-15', 1700, 'Debit Card', 1008, 9),
		   (10, '2019-09-15', 4690, 'Credit Card', 1005, 10),
		   (11, '2018-07-16', 4020, 'Debit Card', 1001, 11)
GO

INSERT INTO [dbo].[OrderItem]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity])
     VALUES
           (1, 1, 700, 7),
		   (2, 2, 400, 4),
		   (2, 3, 750, 6),
		   (3, 4, 250, 8),
		   (4, 4, 250, 12),
		   (5, 5, 450, 4),
		   (6, 6, 850, 7),
		   (7, 7, 780, 2),
		   (8, 8, 312, 3),
		   (9, 9, 170, 10),
		   (10, 10, 670, 7),
		   (11, 10, 670, 6)
GO

INSERT INTO [dbo].[Supplier]
           ([SupplierID]
           ,[SupplierName]
           ,[SupplierContact]
           ,[SupplierLocation])
     VALUES
           (1, 'Gadget Zone', '987123456', 'California'),
		   (2, 'Agilis Electronics', '876543120', 'New York'),
		   (3, 'Every Gadget', '789012354', 'Massachusetts'),
		   (4, 'JNK Sons', '678912345', 'Utah'),
		   (5, '3am Labs', '567817292', 'New Jersey'),
		   (6, 'Philips', '456782932', 'New Mexico'),
		   (7, 'Ace Electronics', '234156780', 'Texas'),
		   (8, 'Bell & Hovell', '781923415', 'California'),
		   (9, 'Ebix', '671823940', 'Illinois'),
		   (10, 'Dayton Groups', '876594034', 'Utah')
GO

INSERT INTO [dbo].[RawMaterial]
           ([RawMaterialID]
           ,[NoOfParts]
           ,[CostPerPart])
     VALUES
           (1, 20, 100),
		   (2, 30, 150),
		   (3, 15, 75),
		   (4, 80, 50),
		   (5, 45, 250),
		   (6, 50, 275),
		   (7, 75, 175),
		   (8, 35, 365),
		   (9, 40, 400),
		   (10, 19, 318)
GO

INSERT INTO [dbo].[SupplierHasRawMaterial]
           ([SupplierID]
           ,[RawMaterialID]
           ,[RawMaterialPartNum])
     VALUES
           (1,2,1234),
		   (2,1,3456),
		   (3,3,7890),
		   (4,4,1256),
		   (5,5,9870),
		   (6,6,3459),
		   (7,7,8345),
		   (8,8,2345),
		   (9,9,1267),
		   (10,10,2837)
GO

INSERT INTO [dbo].[SupplierHasManufacturer]
           ([SupplierID]
           ,[ManufacturerID])
     VALUES
           (1,1),
		   (2,1),
		   (3,12),
		   (3,14),
		   (4,4),
		   (5,13),
		   (6,6),
		   (7,7),
		   (8,8),
		   (9,9),
		   (10,10)
GO