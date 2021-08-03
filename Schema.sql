USE master
GO
DROP DATABASE IF EXISTS vizsga
CREATE DATABASE vizsga
GO
USE vizsga
GO

CREATE SCHEMA [Product]
GO
CREATE SCHEMA [Customer]
GO
CREATE SCHEMA [Orders]
GO

--------------------------------------------------------------------------------------------------------
------------------------------------------PRODUCTSCHEMA-------------------------------------------------
--------------------------------------------------------------------------------------------------------

CREATE TABLE [Product].[Game] (
  [Game_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Game_name] nvarchar(255) UNIQUE NOT NULL,
  [ReleaseDate] date NOT NULL,
  [Developer] nvarchar(255) NOT NULL,
  [Publisher] nvarchar(255) NOT NULL,
)
GO

CREATE TABLE [Product].[Type] (
  [Type_ID] int PRIMARY KEY IDENTITY(1, 1),
  [TypeName] nvarchar(50)
)
GO
INSERT INTO [Product].[Type] VALUES
('Base Game'),('Gold Edition'),('Ultimate Edition'),('Add-on')
GO
---INSTEAD TRIGERREK---
--Delete-re, Update-re csak PRINT

CREATE TABLE [Product].[GameType] (
  [Type_ID] int,
  [Game_ID] int
)
GO

CREATE TABLE [Product].[Platform] (
  [Platform_ID] int PRIMARY KEY IDENTITY(1, 1),
  [PlatformName] nvarchar(100) NOT NULL
)
GO
INSERT INTO [Product].[Platform] VALUES
('Windows'),('Mac OS'),
('Xbox 360'),('Xbox ONE'),('Xbox Series S/X'),
('PlayStation3'),('PlayStation4'),('PlayStation5'),
('Nintendo Switch'),('Nintendo DS'),
('Linux')
GO
---INSTEAD TRIGERREK---
--Delete-re, Update-re csak PRINT

CREATE TABLE [Product].[GamePlatform] (
  [Platform_ID] int,
  [Game_ID] int
)
GO

CREATE TABLE [Product].[GamePrice] (
  [Game_ID] int,
  [Platform_ID] int,
  [Type_ID] int,
  [Price] money DEFAULT (0),
  [Modifier] int
  PRIMARY KEY ([Game_ID],[Platform_ID],[Type_ID])
)
GO
ALTER TABLE [Product].[GamePrice] ADD CONSTRAINT DiscountCheck CHECK([Modifier] <= 100 and [Modifier] >= 1)
GO

CREATE TABLE [Product].[Feature] (
  [Feature_ID] int PRIMARY KEY IDENTITY(1, 1),
  [FeatureName] nvarchar(100)
)
GO
INSERT INTO [Product].[Feature] VALUES
('Single Player'),('Multi Player'),('Co-op'),('VR'),('Controller support')
GO
---INSTEAD TRIGERREK---
--Delete-re, Update-re csak PRINT

CREATE TABLE [Product].[GameFeature] (
  [Feature_ID] int,
  [Game_ID] int
)
GO

CREATE TABLE [Product].[Genre] (
  [Genre_ID] int PRIMARY KEY IDENTITY(1, 1),
  [GenreName] nvarchar(150)
)
GO
INSERT INTO [Product].[Genre] VALUES
('Action'),('Adventure'),('Indie'),('RPG'),('Strategy'),('Open World'),('Shooter'),
('Puzzle'),('First Person'),('Narration'),('Simulation'),('Casual'),('Turn-based'),('Exploration'),
('Horror'),('Platformer'),('Party'),('Survival'),('Trivia'),('City builder'),('Stealth'),('Fighting'),
('Comedy'),('Action-adventure'),('Racing'),('Rogue-lite'),('Card game'),('Sport')
GO
---INSTEAD TRIGERREK---
--Delete-re, Update-re csak PRINT

CREATE TABLE [Product].[GameGenre] (
  [Genre_ID] int,
  [Game_ID] int
)
GO

--------------------------------------------------------------------------------------------------------
-----------------------------------------CUSTOMERSCHEMA-------------------------------------------------
--------------------------------------------------------------------------------------------------------


CREATE TABLE [Customer].[Person] (
  [Person_ID] int PRIMARY KEY IDENTITY(1, 1),
  [DisplayName] nvarchar(100) UNIQUE NOT NULL,
  [Firstname] nvarchar(100),
  [Lastname] nvarchar(100),
  [EmailAddress] nvarchar(255) UNIQUE NOT NULL,
  [AddressLine] nvarchar(150) NOT NULL,
  [City] nvarchar(100) NOT NULL,
  [Region] nvarchar(100) NOT NULL,
  [PostalCode] int NOT NULL,
  [Country] nvarchar(100) NOT NULL
)
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT FirstNameLEN CHECK(LEN([Firstname]) >= 2)
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT LastNameLEN CHECK(LEN([Lastname]) >= 2)
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT CityLEN CHECK(LEN([City]) >= 2)
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT RegionLEN CHECK(LEN([Region]) >= 2)
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT PostLEN CHECK(LEN([PostalCode]) >= 4)
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT DispNameLEN CHECK(LEN([DisplayName]) >=6)
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT DispNameSPACE CHECK(LEN([DisplayName]) not like '% % %')
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT EmaiCheck CHECK([EmailAddress] like '%@%.%')
GO

--------------------------------------------------------------------------------------------------------
------------------------------------------ORDERSCHEMA---------------------------------------------------
--------------------------------------------------------------------------------------------------------

CREATE TABLE [Orders].[Orders] (
  [Order_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Person_ID] int NOT NULL,
  [OrderStatus_ID] tinyint NOT NULL,
  [Order_Date] DATETIME2 NOT NULL,
  [DiscountedPrice] money NOT NULL, /*[GamePrice.Price-(GamePrice.Price*GamePrice.modifier/100)]*/
)
GO
---TRIGGER---
--Default status az InProgress
--instead on delete where order status is complete
---------------------------
--�j ordern�l a discounted price a gamepriceb�l beker�l kisz�molva

CREATE TABLE [Orders].[OrderStatus] (
  [OrderStatus_ID] tinyint PRIMARY KEY IDENTITY(1, 1),
  [StatusDescription] nvarchar(20) UNIQUE NOT NULL
)
GO
INSERT INTO [Orders].[OrderStatus] VALUES('In Progress'), ('Cancelled'), ('Complete')
GO
---INSTEAD TRIGERREK---
--Delete-re, Update-re csak PRINT

CREATE TABLE [Orders].[OrderDetails] (
  [Game_ID] int NOT NULL,
  [Order_ID] int NOT NULL
)
GO
---TRIGGER---
--Delete ha order cancalled lesz

------------------------------------------------------------------------------------------
---------------------------------FOREIGNKEYS--------------------------------------------------
------------------------------------------------------------------------------------------
ALTER TABLE [Product].[GameType] ADD FOREIGN KEY ([Type_ID]) REFERENCES [Product].[Type] ([Type_ID])
GO

ALTER TABLE [Product].[GameType] ADD FOREIGN KEY ([Game_ID]) REFERENCES [Product].[Game] ([Game_ID])
GO

ALTER TABLE [Product].[GamePrice] ADD FOREIGN KEY ([Game_ID]) REFERENCES [Product].[Game] ([Game_ID])
GO

ALTER TABLE [Product].[GamePrice] ADD FOREIGN KEY ([Platform_ID]) REFERENCES [Product].[Platform] ([Platform_ID])
GO

ALTER TABLE [Product].[GamePrice] ADD FOREIGN KEY ([Type_ID]) REFERENCES [Product].[Type] ([Type_ID])
GO

ALTER TABLE [Product].[GamePlatform] ADD FOREIGN KEY ([Platform_ID]) REFERENCES [Product].[Platform] ([Platform_ID])
GO

ALTER TABLE [Product].[GamePlatform] ADD FOREIGN KEY ([Game_ID]) REFERENCES [Product].[Game] ([Game_ID])
GO

ALTER TABLE [Product].[GameFeature] ADD FOREIGN KEY ([Feature_ID]) REFERENCES [Product].[Feature] ([Feature_ID])
GO

ALTER TABLE [Product].[GameFeature] ADD FOREIGN KEY ([Game_ID]) REFERENCES [Product].[Game] ([Game_ID])
GO

ALTER TABLE [Product].[GameGenre] ADD FOREIGN KEY ([Genre_ID]) REFERENCES [Product].[Genre] ([Genre_ID])
GO

ALTER TABLE [Product].[GameGenre] ADD FOREIGN KEY ([Game_ID]) REFERENCES [Product].[Game] ([Game_ID])
GO

ALTER TABLE [Orders].[Orders] ADD FOREIGN KEY ([Person_ID]) REFERENCES [Customer].[Person] ([Person_ID])
GO

ALTER TABLE [Orders].[Orders] ADD FOREIGN KEY ([OrderStatus_ID]) REFERENCES [Orders].[OrderStatus] ([OrderStatus_ID])
GO

ALTER TABLE [Orders].[OrderDetails] ADD FOREIGN KEY ([Game_ID]) REFERENCES [Product].[Game] ([Game_ID])
GO

ALTER TABLE [Orders].[OrderDetails] ADD FOREIGN KEY ([Order_ID]) REFERENCES [Orders].[Orders] ([Order_ID])
GO