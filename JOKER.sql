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


-----------------------------------------------------------------------------------------------------------
---------------------------------------------SCHEAM END----------------------------------------------------
-----------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-----------------------------Create ProductManager DBRole--------------------------
-----------------------------------------------------------------------------------
USE vizsga
GO
CREATE ROLE [ProductManager] AUTHORIZATION [dbo]
GO
GRANT SELECT ON SCHEMA::[Product] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Product] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT ALTER ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT CONTROL ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT CREATE SEQUENCE ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT DELETE ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT EXECUTE ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT INSERT ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT REFERENCES ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT UPDATE ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT VIEW DEFINITION ON SCHEMA::[Product] TO [ProductManager]
GO
DENY TAKE OWNERSHIP ON SCHEMA::[Product] TO [ProductManager]
GO
GRANT SELECT ON [Product].[Type] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT VIEW CHANGE TRACKING ON [Product].[Type] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT CONTROL ON [Product].[Type] TO [ProductManager]
GO
GRANT VIEW DEFINITION ON [Product].[Type] TO [ProductManager]
GO
DENY ALTER ON [Product].[Type] TO [ProductManager]
GO
DENY DELETE ON [Product].[Type] TO [ProductManager]
GO
DENY INSERT ON [Product].[Type] TO [ProductManager]
GO
DENY REFERENCES ON [Product].[Type] TO [ProductManager]
GO
DENY TAKE OWNERSHIP ON [Product].[Type] TO [ProductManager]
GO
DENY UPDATE ON [Product].[Type] TO [ProductManager]
GO
GRANT SELECT ON [Product].[Feature] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT VIEW CHANGE TRACKING ON [Product].[Feature] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT CONTROL ON [Product].[Feature] TO [ProductManager]
GO
GRANT VIEW DEFINITION ON [Product].[Feature] TO [ProductManager]
GO
DENY DELETE ON [Product].[Feature] TO [ProductManager]
GO
DENY INSERT ON [Product].[Feature] TO [ProductManager]
GO
DENY REFERENCES ON [Product].[Feature] TO [ProductManager]
GO
DENY TAKE OWNERSHIP ON [Product].[Feature] TO [ProductManager]
GO
DENY UPDATE ON [Product].[Feature] TO [ProductManager]
GO
GRANT SELECT ON [Product].[Platform] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT VIEW CHANGE TRACKING ON [Product].[Platform] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT CONTROL ON [Product].[Platform] TO [ProductManager]
GO
GRANT VIEW DEFINITION ON [Product].[Platform] TO [ProductManager]
GO
DENY ALTER ON [Product].[Platform] TO [ProductManager]
GO
DENY DELETE ON [Product].[Platform] TO [ProductManager]
GO
DENY INSERT ON [Product].[Platform] TO [ProductManager]
GO
DENY REFERENCES ON [Product].[Platform] TO [ProductManager]
GO
DENY TAKE OWNERSHIP ON [Product].[Platform] TO [ProductManager]
GO
DENY UPDATE ON [Product].[Platform] TO [ProductManager]
GO
GRANT SELECT ON [Product].[Genre] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT VIEW CHANGE TRACKING ON [Product].[Genre] TO [ProductManager] WITH GRANT OPTION 
GO
GRANT CONTROL ON [Product].[Genre] TO [ProductManager]
GO
GRANT VIEW DEFINITION ON [Product].[Genre] TO [ProductManager]
GO
DENY ALTER ON [Product].[Genre] TO [ProductManager]
GO
DENY DELETE ON [Product].[Genre] TO [ProductManager]
GO
DENY INSERT ON [Product].[Genre] TO [ProductManager]
GO
DENY REFERENCES ON [Product].[Genre] TO [ProductManager]
GO
DENY TAKE OWNERSHIP ON [Product].[Genre] TO [ProductManager]
GO
DENY UPDATE ON [Product].[Genre] TO [ProductManager]
GO

-----------------------------------------------------------------------------------
-----------------------------Create OrderManager DBRole----------------------------
-----------------------------------------------------------------------------------
USE vizsga
GO
CREATE ROLE [OrderManager] AUTHORIZATION [dbo]
GO
GRANT CONTROL ON SCHEMA::[Customer] TO [OrderManager]
GO
GRANT SELECT ON SCHEMA::[Customer] TO [OrderManager]
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Customer] TO [OrderManager]
GO
GRANT VIEW DEFINITION ON SCHEMA::[Customer] TO [OrderManager]
GO
DENY ALTER ON SCHEMA::[Customer] TO [OrderManager]
GO
DENY CREATE SEQUENCE ON SCHEMA::[Customer] TO [OrderManager]
GO
DENY DELETE ON SCHEMA::[Customer] TO [OrderManager]
GO
DENY EXECUTE ON SCHEMA::[Customer] TO [OrderManager]
GO
DENY INSERT ON SCHEMA::[Customer] TO [OrderManager]
GO
DENY REFERENCES ON SCHEMA::[Customer] TO [OrderManager]
GO
DENY TAKE OWNERSHIP ON SCHEMA::[Customer] TO [OrderManager]
GO
DENY UPDATE ON SCHEMA::[Customer] TO [OrderManager]
GO
GRANT SELECT ON SCHEMA::[Orders] TO [OrderManager] WITH GRANT OPTION 
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Orders] TO [OrderManager] WITH GRANT OPTION 
GO
GRANT ALTER ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT CONTROL ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT CREATE SEQUENCE ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT DELETE ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT EXECUTE ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT INSERT ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT REFERENCES ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT UPDATE ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT VIEW DEFINITION ON SCHEMA::[Orders] TO [OrderManager]
GO
DENY TAKE OWNERSHIP ON SCHEMA::[Orders] TO [OrderManager]
GO
GRANT CONTROL ON SCHEMA::[Product] TO [OrderManager]
GO
GRANT SELECT ON SCHEMA::[Product] TO [OrderManager]
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Product] TO [OrderManager]
GO
GRANT VIEW DEFINITION ON SCHEMA::[Product] TO [OrderManager]
GO
DENY ALTER ON SCHEMA::[Product] TO [OrderManager]
GO
DENY CREATE SEQUENCE ON SCHEMA::[Product] TO [OrderManager]
GO
DENY DELETE ON SCHEMA::[Product] TO [OrderManager]
GO
DENY EXECUTE ON SCHEMA::[Product] TO [OrderManager]
GO
DENY INSERT ON SCHEMA::[Product] TO [OrderManager]
GO
DENY REFERENCES ON SCHEMA::[Product] TO [OrderManager]
GO
DENY TAKE OWNERSHIP ON SCHEMA::[Product] TO [OrderManager]
GO
DENY UPDATE ON SCHEMA::[Product] TO [OrderManager]
GO
GRANT SELECT ON [Orders].[OrderStatus] TO [OrderManager] WITH GRANT OPTION 
GO
GRANT VIEW CHANGE TRACKING ON [Orders].[OrderStatus] TO [OrderManager] WITH GRANT OPTION 
GO
GRANT CONTROL ON [Orders].[OrderStatus] TO [OrderManager]
GO
GRANT VIEW DEFINITION ON [Orders].[OrderStatus] TO [OrderManager]
GO
DENY ALTER ON [Orders].[OrderStatus] TO [OrderManager]
GO
DENY DELETE ON [Orders].[OrderStatus] TO [OrderManager]
GO
DENY INSERT ON [Orders].[OrderStatus] TO [OrderManager]
GO
DENY REFERENCES ON [Orders].[OrderStatus] TO [OrderManager]
GO
DENY TAKE OWNERSHIP ON [Orders].[OrderStatus] TO [OrderManager]
GO
DENY UPDATE ON [Orders].[OrderStatus] TO [OrderManager]
GO
-----------------------------------------------------------------------------------
------------------------Create MarketingStatistician DBRole------------------------
-----------------------------------------------------------------------------------
USE vizsga
GO
CREATE ROLE [MarketingStat] AUTHORIZATION [dbo]
GO
GRANT SELECT ON SCHEMA::[Customer] TO [MarketingStat]
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Customer] TO [MarketingStat]
GO
GRANT SELECT ON SCHEMA::[Orders] TO [MarketingStat]
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Orders] TO [MarketingStat]
GO
GRANT SELECT ON SCHEMA::[Product] TO [MarketingStat]
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Product] TO [MarketingStat]
GO

-----------------------------------------------------------------------------------
----------------------------------DBRole END---------------------------------------
-----------------------------------------------------------------------------------

------------------------------------------------------------------------
--------------------Create John Login and User--------------------------
------------------------------------------------------------------------
USE [master]
GO
CREATE LOGIN [John] WITH PASSWORD=N'JohnProductManager' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [John]
GO
use [vizsga];
GO
CREATE USER [John] FOR LOGIN [John]
GO
ALTER USER [John] WITH DEFAULT_SCHEMA=[Product]
GO
ALTER ROLE [ProductManager] ADD MEMBER [John]
GO
------------------------------------------------------------------------
--------------------Create Magnus Login and User------------------------
------------------------------------------------------------------------
USE [master]
GO
CREATE LOGIN [Magnus] WITH PASSWORD=N'MagnusOM' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [Magnus]
GO
USE [vizsga]
GO
CREATE USER [Magnus] FOR LOGIN [Magnus]
GO
ALTER USER [Magnus] WITH DEFAULT_SCHEMA=[Orders]
GO
ALTER ROLE [OrderManager] ADD MEMBER [Magnus]
GO
------------------------------------------------------------------------
--------------------Create Silvia Login and User------------------------
------------------------------------------------------------------------
USE [master]
GO
CREATE LOGIN [Silvia] WITH PASSWORD=N'SilviaMS' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [vizsga]
GO
CREATE USER [Silvia] FOR LOGIN [Silvia]
GO
ALTER USER [Silvia] WITH DEFAULT_SCHEMA=[Customer]
GO
ALTER ROLE [MarketingStat] ADD MEMBER [Silvia]
GO

------------------------------------------------------------------------
-------------------------Login and User END-----------------------------
------------------------------------------------------------------------

USE [vizsga]
GO
CREATE APPLICATION ROLE [AppRole] WITH DEFAULT_SCHEMA = [Customer], PASSWORD = N'AppRole2021'
GO
GRANT ALTER ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT CONTROL ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT CREATE SEQUENCE ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT DELETE ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT EXECUTE ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT INSERT ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT REFERENCES ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT SELECT ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT UPDATE ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT VIEW DEFINITION ON SCHEMA::[Customer] TO [AppRole]
GO
DENY TAKE OWNERSHIP ON SCHEMA::[Customer] TO [AppRole]
GO
GRANT ALTER ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT CONTROL ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT CREATE SEQUENCE ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT DELETE ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT EXECUTE ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT INSERT ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT REFERENCES ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT SELECT ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT UPDATE ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT VIEW DEFINITION ON SCHEMA::[Orders] TO [AppRole]
GO
DENY TAKE OWNERSHIP ON SCHEMA::[Orders] TO [AppRole]
GO
GRANT ALTER ON SCHEMA::[Product] TO [AppRole]
GO
GRANT CONTROL ON SCHEMA::[Product] TO [AppRole]
GO
GRANT CREATE SEQUENCE ON SCHEMA::[Product] TO [AppRole]
GO
GRANT DELETE ON SCHEMA::[Product] TO [AppRole]
GO
GRANT EXECUTE ON SCHEMA::[Product] TO [AppRole]
GO
GRANT INSERT ON SCHEMA::[Product] TO [AppRole]
GO
GRANT REFERENCES ON SCHEMA::[Product] TO [AppRole]
GO
GRANT SELECT ON SCHEMA::[Product] TO [AppRole]
GO
GRANT UPDATE ON SCHEMA::[Product] TO [AppRole]
GO
GRANT VIEW CHANGE TRACKING ON SCHEMA::[Product] TO [AppRole]
GO
GRANT VIEW DEFINITION ON SCHEMA::[Product] TO [AppRole]
GO
DENY TAKE OWNERSHIP ON SCHEMA::[Product] TO [AppRole]
GO
-------------------------------------------------------------------------------
--------------------------------APPROLE END------------------------------------
-------------------------------------------------------------------------------

USE vizsga
GO

INSERT INTO Customer.Person([DisplayName],[Firstname],[Lastname],[EmailAddress],[AddressLine],[City],[Region],[PostalCode],[Country])
VALUES
('ProairHFA','Arsenio','Weiss','aliquet.vel@rutrumeuultrices.ca','P.O. Box 144, 7906 Ultrices, Avenue','Durness','SU',35819,'Bahamas'),
('Zetian','Mona','Willis','tristique.aliquet.Phasellus@nuncsitamet.org','933 Nascetur Rd.','Upplands Väsby','Stockholms län',84082,'Angola'),
('Alprazolam','Hanae','Hernandez','aliquet@pede.com','Ap #921-5258 Dapibus St.','Woerden','U.',49306,'New Caledonia'),
('Tricor','Kyle','Carney','magna.Phasellus.dolor@Curabitur.co.uk','Ap #127-1010 Risus. St.','Morelia','Michoacán',98246,'Guadeloupe'),
('Hydrochlorothiazide','Kirk','Cain','fermentum.metus.Aenean@egestaslacinia.net','P.O. Box 354, 395 Vel Av.','Chiclayo','Lambayeque',68873,'Brazil'),
('Fluconazole','Caesar','Mcmahon','Pellentesque.ut.ipsum@accumsanneque.com','457-7983 Et, Ave','Hamilton','Ontario',52673,'Guyana'),
('Clonazepam','Eric','Strickland','malesuada.ut@aliquet.org','727-4727 Non, Rd.','Ede','Gelderland',19256,'Uzbekistan'),
('Lisinopril','Xander','Espinoza','ac.urna.Ut@semperNam.org','Ap #566-1149 Non Road','Wasseiges','Luik',20925,'Cuba'),
('DoxycyclineHyclate','Yoko','Newman','cubilia.Curae@anteipsumprimis.co.uk','1856 Semper. Avenue','Balfour','OK',90134,'Nigeria'),
('TriNessa','Colton','Black','nascetur@libero.com','438-8571 Purus, St.','Paranaguá','Paraná',47613,'Kuwait'),
('CitalopramHBr','Kylie','Riddle','nulla@fringillaporttitorvulputate.ca','7789 Eu St.','Cusco','Cusco',14147,'Equatorial Guinea'),
('BenicarHCT','Chava','Wong','facilisis.facilisis.magna@Vivamus.org','Ap #698-5104 Dolor, Avenue','Des Moines','IA',98983,'Sao Tome and Principe'),
('FluticasonePropionate','Craig','Johnson','cursus.Nunc.mauris@Morbi.ca','P.O. Box 667, 2537 Aliquam Rd.','Suncheon','Jeo',57976,'Falkland Islands'),
('Januvia','Tad','Berg','tellus.lorem.eu@Suspendissealiquet.edu','P.O. Box 694, 4324 Ut, Avenue','Olathe','KS',26274,'Madagascar'),
('Azithromycin','Alika','Vaughn','amet.lorem.semper@Fuscemollis.edu','722-8677 Pretium Rd.','Kharabali','Astrakhan Oblast',27997,'Korea, North'),
('PenicillinVK','Daniel','Juarez','lacinia.vitae.sodales@apurusDuis.edu','P.O. Box 469, 5089 Dui St.','Carbonear','Newfoundland and Labrador',58129,'Somalia'),
('PantoprazoleSodium','Cole','Fletcher','et@etmagnisdis.co.uk','P.O. Box 700, 7701 Pede Rd.','Castelbaldo','Veneto',84970,'Singapore'),
('VentolinHFA','Alden','Chaney','Ut@vestibulumnequesed.net','412-3231 Est. St.','Legnica','Dolnośląskie',71930,'Latvia'),
('VitaminD(Rx)','Gannon','Holder','volutpat@interdum.com','Ap #632-4367 Luctus Ave','Pogliano Milanese','Lombardia',97570,'Turkey'),
('LosartanPotassium','Darryl','Ellis','viverra@etcommodo.net','612-4870 Velit. Avenue','Georgia','GA',56769,'Brunei');

----------------------------------------------------------------------------------------
-------------------------------Customer Insert end--------------------------------------
----------------------------------------------------------------------------------------

Use vizsga
GO

INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Rachet & Clank: Rift Apart','2021-06-11','Insomniac Games','Sony Interactive Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Dungeons & Dragons: Dark Alliance','2021-06-25','Tuque Games','Wizards of the Coast')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Scarlet Nexus','2021-06-29','BANDAI NAMCO Entertainment (America)','Bandai Namco Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Necromunda: Hired Gun','2021-06-04','Streum On Studio','Focus Home Interactive')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Backbone','2021-05-30','EggNut','Raw Fury/EggNut')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Sniper: Ghost Warrior Contracts 2','2021-06-07','CI Games','CI Games')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Legend of Mana','2021-06-24','Square Enix/M2 Co','Square Enix')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('The Last Spell','2021-05-31','CCCP','CCCP')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('The Elder Scrolls Online: Blackwood','2021-06-08','Zenimax Online Studios','Bethesda Softworks')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('The Medium','2021-01-28','Bloober Team','Bloober Team')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Resident Evil: Village','2021-05-15','Capcom','Capcom')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Outriders','2021-04-01','People Can Fly','Square Enix')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Biomutant','2021-05-25','Experiment 101','THQ Nordic')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Valheim','2021-02-02','Dvoid/Richard Svensson','Coffee Stain')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('It Takes Two','2021-03-26','Hazelight/Mohammad Almajali','Electronic Arts/Mohammad Almajali')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Mass Effect: Legendary Edition','2021-05-14','BioWare/Ea Swiss','Electronic Arts')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Subnautica: Below Zero','2021-05-14','Unknown Worlds Entertainment','Unknown Worlds Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Far Cry 6','2021-10-07','Ubisoft/Ubisoft Toronto','Ubisoft Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Returnal','2021-05-30','Housemarque','Sony Interactive Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Werewolf: The Apocalypse - Earthblood','2021-02-04','Cyanide Studio','Bigben Interactive')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Battlefield 2042','2021-10-22','Electronic Arts DICE/Citerion Games','Electronic Arts')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('The Dark Pictures Anthology: House of Ashes','2021-10-22','Supermassive Games','Bandai Namco Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Cyberpunk 2077','2020-12-10','CD PROJEKT RED/CD PROJEKT','CD PROJEKT RED')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('The Last of Us Part II','2020-06-19','Naughty Dog','Sony Interactive Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Ghost of Tsushima','2020-07-17','Sucker Punch Productions','Sony Interactive Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('DOOM Eternal','2020-03-20','Bethesda Softworks/id Software','Bethesda Softworks')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Doom Eternal: The Ancient Gods - Part One','2020-10-20','id Software','Bethesda Softworks')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Doom Eternal: The Ancient Gods - Part Two','2021-03-18','id Software','Bethesda Softworks')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Ori and the Will of the Wisps','2020-03-10','Moon Studios','Microsoft Studios/Xbox Game Studios')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Immortals: Fenyx Rising','2020-12-03','Ubisoft/Ubisoft Quebec','Ubisoft Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Crusade Kings III','2020-09-01','Paradox Development Studios','Paradox Interactive')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Call of Duty: Black Ops Cold War','2020-11-13','Raven Software/Treyarch','Activision')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Crash Bandicoot 4: Its About Time','2020-10-01','Toys for Bob','Activision Blizzard')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Wolcen: Lords of Mayhem','2020-02-13','WOLCEN Studio','WOLCEN Studio')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Mortal Shell','2020-08-18','PlayStack/Cold Symmetry','PlayStack')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Grounded','2020-07-28','Obsidian Entertainment','Xbox Game Studios')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Total War Saga: TROY','2020-08-13','Creative Assembly','SEGA')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Crysis Remastered','2020-09-18','Saber Interactive','Crytek')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('The Witcher 3: Wild Hunt','2015-05-18','CD PROJEKT RED','CD PROJEKT RED')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Red Dead Redemption 2','2018-10-26','Rockstar Games','Rockstar Games')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('S.T.A.L.K.E.R. 2: Heart of Chernobyl','2022-04-28','GSC Game World','GSC Game World')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Mass Effect 2','2010-01-26','BioWare','Electronic Arts')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Star Wars: Knights of the Old Republic','2003-07-15','Aspyr Media/BioWare/Lucasfilm','Aspyr/ LucasArts Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Star Wars: Knights of the Old Republic II - The Sith Lords','2004-12-06','Aspyr Media/Obsidian Entertainment/Lucasfilm','Aspyr/Disney Interactive/LucasArts Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('BioShock Infinite','2013-05-26','Aspyr Media/2K Australia/Irrational Games','2K Games/Aspyr')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Death Stranding','2019-11-08','Kojima Productions','505 Games/Sony Interactive Entertainment')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Age of Empires II: Age of Kings','1999-09-30','Ensemble Studios','Microsoft Studios')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('The Elder Scrolls V: Skyrim','2011-11-11','Bethesda Softworks/Bethesda Game Studios','Bethesda Softworks')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('INSIDE','2016-06-28','Playdead','Playdead')
INSERT INTO Product.Game([Game_name],[ReleaseDate],[Developer],[Publisher]) VALUES ('Dark Souls III','2016-05-11','BANDAI NAMCO Entertainment America/FromSoftware','Bandai Namco Entertainment/BANDAI NAMCO Entertainment US/FromSoftware')

----------------------------------------------------------------------------------------
-----------------------------------GAME Insert end--------------------------------------
----------------------------------------------------------------------------------------

USE vizsga
GO

--('Single Player'),('Multi Player'),('Co-op'),('VR'),('Controller support')
--      1                 2               3      4            5


INSERT INTO [Product].[GameFeature]([Game_ID],[Feature_ID])
VALUES
(1,1),(1,5),
(2,1),(2,2),(2,3),(2,5),
(3,1),(3,5),
(4,1),(4,5),
(5,1),(5,5),
(6,1),(6,5),
(7,1),(7,2),(7,3),(7,5),
(8,1),
(9,2),(9,5),
(10,1),(10,5),
(11,1),(11,2),(11,5),
(12,1),(12,2),(12,3),(12,5),
(13,1),(13,5),
(14,1),(14,2),(14,3),
(15,2),(15,3),(15,5),
(16,1),(16,5),
(17,1),(17,5),
(18,1),(18,2),(18,3),(18,5),
(19,1),(19,5),
(20,1),(20,5),
(21,5),(21,2),(21,3),
(22,1),(22,5),
(23,1),(23,5),
(24,1),(24,5),
(25,1),(25,5),
(26,1),(26,2),(26,3),(26,5),
(27,1),(27,2),(27,3),(27,5),
(28,1),(28,2),(28,3),(28,5),
(29,1),(29,5),
(30,1),(30,5),
(31,1),(31,2),
(32,1),(32,2),(32,3),(32,5),
(33,1),(33,5),
(34,1),(34,2),
(35,1),(35,5),
(36,1),(36,2),(36,5),
(37,1),(37,2),
(38,1),(38,5),
(39,1),(39,5),
(40,1),(40,2),(43,5),
(41,1),(41,2),(41,5),
(42,1),(42,5),
(43,1),(43,5),
(44,1),(44,5),
(45,1),(45,5),
(46,1),(46,5),
(47,1),(47,2),(47,3),
(48,1),(48,4),(48,5),
(49,1),(49,5),
(50,1),(50,2),(50,5)

-----------------------------------------------------------------------------------

USE vizsga
GO
-- ('Action'),('Adventure'),('Indie'),('RPG'),('Strategy'),('Open World'),('Shooter'),
--     1            2           3        4         5              6            7 
-- ('Puzzle'),('First Person'),('Narration'),('Simulation'),('Casual'),('Turn-based'),('Exploration'),
--     8             9               10            11           12             13            14
-- ('Horror'),('Platformer'),('Party'),('Survival'),('Trivia'),('City builder'),('Stealth'),('Fighting'),
--     15           16          17          18           19          20               21           22 
-- ('Comedy'),('Action-adventure'),('Racing'),('Rogue-lite'),('Card game'),('Sport')
--      23             24              25           26            27          28
INSERT INTO [Product].[GameGenre]([Game_ID],[Genre_ID])
VALUES
(1,24),(1,1),(1,2),
(2,1),(2,4),
(3,1),(3,2),(3,4),(3,24),
(4,1),(4,7),(4,5),
(5,2),(5,3),
(6,1),(6,7),(6,9),
(7,1),(7,4),
(8,3),(8,4),(8,5),
(9,24),(9,6),(9,1),(9,2),
(10,24),(10,1),(10,2),
(11,1),(11,2),(11,15),(11,24),
(12,1),(12,2),(12,4),(12,7),(12,24),
(13,1),(13,4),(13,6),
(14,1),(14,2),(14,3),(14,6),(14,14),(14,24),
(15,1),(15,2),(15,8),(15,16),(15,24),
(16,1),(16,2),(16,4),(16,6),(16,7),(16,24),
(17,2),(17,3),(17,6),(17,14),(17,18),
(18,1),(18,6),(18,7),(18,18),
(19,1),(19,7),(19,16),(19,26),
(20,1),(20,2),(20,3),(20,4),(20,24),
(21,1),(21,7),(21,9),
(22,24),(22,15),(22,1),(22,2),
(23,1),(23,2),(23,4),(23,6),(23,9),(23,24),
(24,1),(24,2),(24,7),(24,15),(24,18),(24,21),(24,24),
(25,1),(25,2),(25,4),(25,6),(25,24),
(26,1),(26,7),(26,9),(26,15),
(27,1),(27,7),(27,9),(27,15),
(28,1),(28,7),(28,9),(28,15),
(29,24),(29,6),(29,16),(29,1),(29,2),
(30,1),(30,2),(30,6),(30,8),(30,10),(30,14),(30,6),(30,24),
(31,4),(31,5),(31,11),
(32,7),(32,9),(32,1),
(33,1),(33,16),(33,23),
(34,24),(34,3),(34,4),(34,6),(34,14),(34,1),(34,2),
(35,1),(35,4),
(36,2),(36,3),(36,4),(36,6),(36,9),(36,14),(36,18),
(37,1),(37,5),(37,11),
(38,24),(38,6),(38,7),(38,9),(38,14),(38,21),(38,1),(38,2),
(39,1),(39,2),(39,4),(39,6),(39,24),
(40,1),(40,2),(40,24),(40,4),(40,6),(40,9),
(41,1),(41,2),(41,24),(41,4),(41,7),(41,18),
(42,1),(42,2),(42,24),(42,4),(42,7),
(43,1),(43,2),(43,24),(43,4),(43,13),
(44,1),(44,2),(44,24),(44,4),(44,13),
(45,1),(45,4),(45,7),(45,9),
(46,1),(46,2),(46,24),(46,6),(46,4),(46,14),(46,15),(46,21),
(47,5),
(48,1),(48,2),(48,24),(48,4),(48,6),(48,14),
(49,1),(49,2),(49,24),(49,3),(49,8),(49,16),(49,15),(49,21),
(50,1),(50,4),(50,6),(50,14),(50,15)

------------------------------------------------------------------------------------------

USE vizsga
GO

--('Base Game'),('Gold Edition'),('Ultimate Edition'),('Add-on')
--      1              2                  3                4

INSERT INTO [Product].[GameType]([Game_ID],[Type_ID])
VALUES
(1,1),(1,3),
(2,1),(2,3),
(3,1),(3,3),
(4,1),
(5,1),
(6,1),(6,3),
(7,1),
(8,1),
(9,1),(9,2),(9,3),
(10,1),(10,2),
(11,1),(11,2),(11,3),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),(17,2),
(18,1),
(19,1),(19,3),
(20,1),
(21,1),(21,2),(21,3),
--(22,1),
(23,1),
(24,1),(24,3),
(25,1),(25,3),
(26,1),(26,2),(26,3),
(27,4),
(28,4),
(29,1),(29,2),
(30,1),(30,2),
(31,1),(31,2),(31,3),
(32,1),(32,2),(32,3),
(33,1),
(34,1),
(35,1),
(36,1),
(37,1),
(38,1),
(39,1),(39,3),
(40,1),(40,3),
(41,1),(41,2),(41,3),
(42,1),(42,3),
(43,1),
(44,1),
(45,1),(45,2),(45,3),
(46,1),(46,3),
(47,1),(47,2),
(48,1),(48,3),
(49,1),
(50,1),(50,3)

----------------------------------------------------------------------------------

--('Windows'),('Mac OS'),('Xbox 360'),('Xbox ONE'),('Xbox Series S/X'),('PlayStation3'),
--     1           2          3             4                5                6
--('PlayStation4'),('PlayStation5'),('Nintendo Switch'),('Nintendo DS'),('Linux')
--     7                  8                 9                 10            11
USE vizsga 
GO
INSERT INTO [Product].[GamePlatform]([Game_ID],[Platform_ID])
VALUES
(1,8),
(2,1),(2,4),(2,5),(2,7),(2,8),
(3,1),(3,4),(3,5),(3,7),(3,8),
(4,1),(4,4),(4,5),(4,7),(4,8),
(5,1),(5,2),(5,9),(5,11),
(6,1),(6,4),(6,5),(6,7),
(7,1),(7,7),(7,9),
(8,1),
(9,1),(9,4),(9,7),
(10,1),(10,4),(10,5),(10,8),
(11,1),(11,4),(11,5),(11,7),(11,8),
(12,1),(12,4),(12,5),(12,7),(12,8),
(13,1),(13,4),(13,7),
(14,1),(14,2),(14,11),
(15,1),(15,2),(15,4),(15,5),(15,7),(15,8),
(16,1),(16,4),(16,5),(16,7),(16,8),
(17,1),(17,2),(17,4),(17,5),(17,7),(17,8),(17,9),
(18,1),(18,4),(18,5),(18,7),(18,8),
(19,8),
(20,1),(20,4),(20,5),(20,7),(20,8),
(21,1),(21,4),(21,5),(21,7),(21,8),
(22,1),(22,4),(22,5),(22,7),(22,8),
(23,1),(23,4),(23,5),(23,7),(23,8),
(24,7),(24,8),
(25,7),(25,8),
(26,1),(26,4),(26,7),(26,9),
(27,1),(27,4),(27,7),
(28,1),(28,4),(28,7),
(29,1),(29,4),(29,5),(29,9),
(30,1),(30,4),(30,5),(30,7),(30,8),(30,9),
(31,1),(31,2),(31,11),
(32,1),(32,4),(32,5),(32,7),(32,8),
(33,1),(33,4),(33,5),(33,7),(33,8),(33,9),
(34,1),
(35,1),(35,4),(35,7),
(36,1),(36,4),(36,5),
(37,1),(37,2),
(38,1),(38,4),(38,7),(38,9),
(39,1),(39,4),(39,7),(39,9),
(40,1),(40,4),(40,7),
(41,1),(41,5),
(42,1),(42,3),(42,4),(42,6),
(43,1),(43,2),(43,3),(43,4),
(44,1),(44,2),(44,3),(44,4),(44,11),
(45,1),(45,3),(45,4),(45,6),(45,7),(45,9),(45,11),
(46,1),(46,7),
(47,1),
(48,1),(48,3),(48,6),(48,9),
(49,1),(49,2),(49,4),(49,7),(49,9),
(50,1),(50,4),(50,7)


-----------------------------------------------------------------------------------------


USE vizsga
GO
INSERT INTO [Product].[GamePrice]([Game_ID],[Type_ID],[Platform_ID],[Price],[Modifier]) VALUES
(1,1,8,69.99,null),
(1,3,8,79.99,null),
(2,1,1,39.99,null),
(2,3,1,59.99,null),
(2,1,4,39.99,null),
(2,3,4,59.99,null),
(2,1,5,39.99,null),
(2,3,5,59.99,null),
(2,1,7,39.99,null),
(2,3,7,59.99,null),
(2,1,8,39.99,null),
(2,3,8,59.99,null),
(3,1,1,49.99,null),
(3,3,1,64.99,null),
(3,1,4,59.99,null),
(3,3,4,79.99,null),
(3,1,5,59.99,null),
(3,3,5,79.99,null),
(3,1,7,59.99,null),
(3,3,7,79.99,null),
(3,1,8,59.99,null),
(3,3,8,79.99,null),
(4,1,1,39.99,null),
(4,1,4,39.99,null),
(4,1,5,39.99,null),
(4,1,7,39.99,null),
(4,1,8,39.99,null),
(5,1,1,24.99,null),
(5,1,2,24.99,null),
(5,1,9,24.99,null),
(5,1,11,24.99,null),
(6,1,1,39.99,null),
(6,3,1,49.99,null),
(6,1,4,39.99,null),
(6,3,4,49.99,null),
(6,1,5,39.99,null),
(6,3,5,49.99,null),
(6,1,7,39.99,null),
(6,3,7,49.99,null),
(7,1,1,29.99,null),
(7,1,7,29.99,null),
(7,1,9,29.99,null),
(8,1,1,19.99,null),
(9,1,1,39.99,15),
(9,2,1,59.99,15),
(9,3,1,65.99,10),
(9,1,4,39.99,15),
(9,2,4,59.99,15),
(9,3,4,65.99,10),
(9,1,7,39.99,null),
(9,2,7,59.99,null),
(9,3,7,69.99,null),
(10,1,1,49.99,20),
(10,2,1,54.99,25),
(10,1,4,49.99,null),
(10,2,4,54.99,null),
(10,1,5,49.99,null),
(10,2,5,54.99,null),
(10,1,8,null,null),
(10,2,8,null,null),
(11,1,1,59.99,null),
(11,2,1,69.99,null),
(11,3,1,79.99,null),
(11,1,4,59.99,null),
(11,2,4,69.99,null),
(11,3,4,79.99,null),
(11,1,5,59.99,null),
(11,2,5,69.99,null),
(11,3,5,79.99,null),
(11,1,7,59.99,null),
(11,2,7,69.99,null),
(11,3,7,79.99,null),
(11,1,8,59.99,null),
(11,2,8,69.99,null),
(11,3,8,79.99,null),
(12,1,1,null,null),
(12,1,4,null,null),
(12,1,5,null,null),
(12,1,7,null,null),
(12,1,8,null,null),
(13,1,1,59.99,null),
(13,1,4,59.99,null),
(13,1,7,59.99,null),
(14,1,1,16.79,null),
(14,1,2,16.79,null),
(14,1,11,16.79,null),
(15,1,1,39.99,25),
(15,1,2,39.99,null),
(15,1,4,39.99,null),
(15,1,5,39.99,null),
(15,1,7,39.99,null),
(15,1,8,39.99,null),
(16,1,1,59.99,null),
(16,1,4,59.99,null),
(16,1,5,59.99,null),
(16,1,7,79.99,null),
(16,1,8,79.99,null),
(17,1,1,29.99,null),
(17,2,1,39.99,null),
(17,1,2,29.99,null),
(17,2,2,39.99,null),
(17,1,4,29.99,null),
(17,2,4,39.99,null),
(17,1,5,29.99,null),
(17,2,5,39.99,null),
(17,1,7,29.99,null),
(17,2,7,39.99,null),
(17,1,8,29.99,null),
(17,2,8,39.99,null),
(17,1,9,29.99,null),
(17,2,9,39.99,null),
(18,1,1,59.99,null),
(18,1,4,59.99,null),
(18,1,5,59.99,null),
(18,1,7,59.99,null),
(18,1,8,59.99,null),
(19,1,8,69.99,null),
(19,3,8,79.99,null),
(20,1,1,29.99,null),
(20,1,4,49.99,null),
(20,1,5,49.99,null),
(20,1,7,49.99,null),
(20,1,8,49.99,null),
(21,1,1,59.99,10),
(21,2,1,99.99,10),
(21,3,1,119.99,10),
(21,1,4,59.99,10),
(21,2,4,99.99,10),
(21,3,4,119.99,10),
(21,1,5,59.99,10),
(21,2,5,99.99,10),
(21,3,5,119.99,10),
(21,1,7,59.99,null),
(21,2,7,99.99,null),
(21,3,7,119.99,null),
(21,1,8,59.99,null),
(21,2,8,99.99,null),
(21,3,8,119.99,null),
(23,1,1,59.99,33),
(23,1,4,59.99,null),
(23,1,5,59.99,null),
(23,1,7,49.99,null),
(23,1,8,49.99,null),
(24,1,7,59.99,null),
(24,3,7,69.99,null),
(24,1,8,59.99,null),
(24,3,8,69.99,null),
(25,1,7,59.99,null),
(25,3,7,69.99,null),
(25,1,8,69.99,null),
(25,3,8,79.99,null),
(26,1,1,59.99,null),
(26,2,1,75.99,null),
(26,3,1,89.99,33),
(26,1,4,59.99,25),
(26,2,4,74.99,25),
(26,3,4,89.99,25),
(26,1,7,59.99,null),
(26,2,7,74.99,null),
(26,3,7,89.99,null),
(26,1,9,59.99,null),
(26,2,9,74.99,null),
(26,3,9,89.99,null),
(27,4,1,19.99,25),
(27,4,4,19.99,null),
(27,4,7,19.99,null),
(28,4,1,19.99,25),
(28,4,4,19.99,null),
(28,4,7,19.99,null),
(29,1,1,29.99,50),
(29,2,1,29.99,49),
(29,1,4,29.99,null),
(29,2,4,34.99,null),
(29,1,5,29.99,null),
(29,2,5,34.99,null),
(29,1,9,29.99,null),
(29,2,9,34.99,null),
(30,1,1,54.99,null),
(30,2,1,89.99,null),
(30,1,4,59.99,null),
(30,2,4,99.99,null),
(30,1,5,59.99,null),
(30,2,5,99.99,null),
(30,1,7,59.99,60),
(30,2,7,99.99,60),
(30,1,8,59.99,60),
(30,2,8,99.99,60),
(30,1,9,59.99,null),
(30,2,9,99.99,null),
(31,1,1,49.99,20),
(31,2,1,64.99,20),
(31,3,1,74.99,10),
(31,1,2,49.99,20),
(31,2,2,64.99,20),
(31,3,2,74.99,10),
(31,1,11,49.99,20),
(31,2,11,64.99,20),
(31,3,11,74.99,10),
(32,1,1,59.99,null),
(32,2,1,69.99,null),
(32,3,1,89.99,null),
(32,1,4,59.99,null),
(32,2,4,69.99,null),
(32,3,4,89.99,null),
(32,1,5,59.99,null),
(32,2,5,69.99,null),
(32,3,5,89.99,null),
(32,1,7,59.99,null),
(32,2,7,69.99,null),
(32,3,7,89.99,null),
(32,1,8,59.99,null),
(32,2,8,69.99,null),
(32,3,8,89.99,null),
(33,1,1,39.99,25),
(33,1,4,59.99,null),
(33,1,5,59.99,null),
(33,1,7,59.99,40),
(33,1,8,59.99,40),
(33,1,9,39.99,null),
(34,1,1,34.99,30),
(35,1,1,29.99,null),
(35,1,4,29.99,null),
(35,1,7,29.99,35),
(36,1,1,29.99,null),
(36,1,4,29.99,null),
(36,1,5,29.99,null),
(37,1,1,49.99, null),
(37,1,2,49.99,null),
(38,1,1,29.99,null),
(38,1,4,29.99,null),
(38,1,7,29.99,null),
(38,1,9,29.99,null),
(39,1,1,29.99,80),
(39,3,1,49.99,80),
(39,1,4,39.99,null),
(39,3,4,49.99,null),
(39,1,7,39.99,80),
(39,3,7,49.99,null),
(39,1,9,39.99,null),
(39,3,9,59.99,null),
(40,1,1,59.99,33),
(40,3,1,89.99,40),
(40,1,4,59.99,null),
(40,3,4,99.99,null),
(40,1,7,59.99,55),
(40,3,7,69.99,null),
(41,1,1,59.99,null),
(41,2,1,79.99,null),
(41,3,1,109.99,null),
(41,1,5,59.99,null),
(41,2,5,79.99,null),
(41,3,5,109.99,null),
(42,1,1,19.99,null),
(42,3,1,29.99,null),
(42,1,3,19.99,null),
(42,3,3,29.99,null),
(42,1,4,19.99,null),
(42,3,4,29.99,null),
(42,1,6,19.99,null),
(42,3,6,29.99,null),
(43,1,1,8.19,65),
(43,1,2,8.19,65),
(43,1,3,9.99,null),
(43,1,4,9.99,null),
(44,1,1,8.19,65),
(44,1,2,8.19,null),
(44,1,3,9.99,null),
(44,1,4,9.99,null),
(44,1,11,9.99,null),
(45,1,1,29.99,75),
(45,2,1,49.99,75),
(45,3,1,59.99,80),
(45,1,3,19.99,null),
(45,2,3,29.99,null),
(45,3,3,49.99,null),
(45,1,4,19.99,null),
(45,2,4,29.99,null),
(45,3,4,49.99,null),
(45,1,6,19.99,null),
(45,2,6,29.99,null),
(45,3,6,49.99,null),
(45,1,7,19.99,null),
(45,2,7,29.99,null),
(45,3,7,49.99,null),
(45,1,9,19.99,null),
(45,2,9,29.99,null),
(45,3,9,49.99,null),
(45,1,11,19.99,null),
(45,2,11,29.99,null),
(45,3,11,49.99,null),
(46,1,1,39.99,null),
(46,3,1,59.99,60),
(46,1,7,39.99,null),
(46,3,7,59.99,null),
(47,1,1,9.99,null),
(47,2,1,19.99,null),
(48,1,1,14.99,null),
(48,3,1,24.99,null),
(48,1,3,19.99,null),
(48,3,3,29.99,null),
(48,1,6,29.99,null),
(48,3,6,39.99,null),
(48,1,9,39.99,null),
(48,3,9,59.99,null),
(49,1,1,19.99,75),
(49,1,2,19.99,null),
(49,1,4,19.99,null),
(49,1,7,19.99,null),
(49,1,9,19.99,null),
(50,1,1,59.99,75),
(50,3,1,84.99,75),
(50,1,4,59.99,null),
(50,3,4,84.99,null),
(50,1,7,59.99,null),
(50,3,7,84.99,null)
GO

UPDATE Product.GamePrice set Modifier=100
where Modifier is NULL

------------------------------------------------------------------------------------------

------------FULL GAME LIST AND PROPERTIES + PRICE--------------
USE vizsga
GO
DROP VIEW IF EXISTS Product.FullProduct
GO
CREATE VIEW Product.FullProduct AS
with gg as (
select g.Game_ID, g.game_name as Game, string_agg(ge.GenreName, ', ') as Genre from Product.Game g
join Product.GameGenre gg on g.Game_ID=gg.Game_ID
join Product.Genre ge on ge.Genre_ID=gg.Genre_ID
group by g.Game_ID, g.game_name),
gf as (
select g.Game_ID, g.Game_name as Game, string_agg(f.FeatureName, ', ') as Features from Product.Game g
join Product.GameFeature gf on gf.Game_ID=g.Game_ID
join Product.Feature f on f.Feature_ID=gf.Feature_ID
group by g.Game_ID, g.Game_name),
gt as (
select g.Game_ID, g.Game_name as Game, string_agg(t.TypeName, ', ') as [Type] from Product.Game g
left join Product.GameType gt on gt.Game_ID=g.Game_ID
left join Product.Type t on t.Type_ID=gt.Type_ID
group by g.Game_ID, g.Game_name),
gp as (
select g.Game_ID, g.Game_name as Game, string_agg(p.PlatformName, ', ') as [Platform] from Product.Game g
join Product.GamePlatform gp on gp.Game_ID=g.Game_ID
join Product.Platform p on p.Platform_ID=gp.Platform_ID
group by g.Game_ID, g.Game_name),
gpr as (
select g.Game_ID,
Replace(REPLACE(string_agg(concat(p.PlatformName, '-', t.TypeName, ' -> ', isnull(gpr.Price,''),'€ ', '(','-',isnull(gpr.Modifier,'1000'),'%',' ','discount',')'), ' ||| ' ), '-100%', 'No'),'0.00€', 'Unknown') as Price from Product.Game g
join Product.GamePlatform gp on gp.Game_ID=g.Game_ID
join Product.Platform p on p.Platform_ID=gp.Platform_ID
join Product.GameType gt on gt.Game_ID=g.Game_ID
join Product.Type t on t.Type_ID=gt.Type_ID
join Product.GamePrice gpr on gpr.Game_ID=g.Game_ID and gpr.Platform_ID=gp.Platform_ID and gpr.Type_ID=gt.Type_ID
group by g.Game_ID
)

select gg.Game_ID, gg.Game, gg.Genre, gf. Features, isnull(gt.Type,'Unknown') as [Type], gp.Platform, isnull(gpr.Price,'Unknown') Price
from gg
left join gf on gf.Game_ID=gg.Game_ID
left join gt on gt.Game_ID=gg.Game_ID
left join gp on gp.Game_ID=gg.Game_ID
left join gpr on gpr.Game_ID=gg.Game_ID
GO

------------------------------------------------------------------------------------------------

USE vizsga
GO

DROP TRIGGER IF EXISTS Product.trgDontChangeFeature
GO

CREATE TRIGGER trgDontChangeFeature on Product.Feature
INSTEAD OF UPDATE,DELETE
AS
BEGIN
	PRINT('If you change or delete the already existing features or their IDs
		   it going to cause inconsistence and chaos.
		   These actions cannot be executed.
		   If you have any problem with it, ask DBO.')
END
GO
--------------------------------------------------------------------------------

USE vizsga
GO

DROP TRIGGER IF EXISTS Product.trgDontChangeGenre
GO

CREATE TRIGGER trgDontChangeGenre on Product.Genre
INSTEAD OF UPDATE,DELETE
AS
BEGIN
	PRINT('If you change or delete the already existing genres or their IDs
		   it going to cause inconsistence and chaos.
		   These actions cannot be executed.
		   If you have any problem with it, ask DBO.')
END
GO

---------------------------------------------------------------------

USE vizsga
GO

DROP TRIGGER IF EXISTS Product.trgDontChangePlatform
GO

CREATE TRIGGER trgDontChangePlatform on Product.Platform
INSTEAD OF UPDATE,DELETE
AS
BEGIN
	PRINT('If you change or delete the already existing platforms or their IDs
		   it going to cause inconsistence and chaos.
		   These actions cannot be executed.
		   If you have any problem with it, ask DBO.')
END
GO
-------------------------------------------------------------------------------

USE vizsga
GO

DROP TRIGGER IF EXISTS Product.trgDontChangeType
GO

CREATE TRIGGER trgDontChangeType on Product.Type
INSTEAD OF UPDATE,DELETE
AS
BEGIN
	PRINT('If you change or delete the already existing types or their IDs
		   it going to cause inconsistence and chaos.
		   These actions cannot be executed.
		   If you have any problem with it, ask DBO.')
END
GO
----------------------------------------------------------------------------------

USE vizsga
GO

DROP TRIGGER IF EXISTS Orders.trgDontChangeStatus
GO

CREATE TRIGGER trgDontChangeStatus on Orders.OrderStatus
INSTEAD OF UPDATE,DELETE
AS
BEGIN
	PRINT('If you change or delete the already existing statuses or their IDs
		   it going to cause inconsistence and chaos.
		   These actions cannot be executed.
		   If you have any problem with it, ask DBO.')
END
GO
------------------------------------------------------------------------------------------

USE vizsga
GO

DROP FUNCTION IF EXISTS dbo.DiscPrice
GO

CREATE FUNCTION dbo.DiscPrice (@GameName nvarchar(100),@PlatName varchar(75),@TypeName varchar(40))
RETURNS MONEY
AS
BEGIN
RETURN (select ROUND((cast(gp.Modifier as money)/100)*gp.Price,2)
		from Product.GamePrice gp
		join Product.Game g on g.Game_ID=gp.Game_ID
		join Product.Platform p on p.Platform_ID=gp.Platform_ID
		join Product.Type t on t.Type_ID=gp.Type_ID
		where g.Game_name like @GameName and p.PlatformName like @PlatName and t.TypeName like @TypeName
		)
END
GO

-------------------------------------------------------------------------------------------------------------

USE vizsga
GO
DROP PROC IF EXISTS dbo.NewOrder
GO

CREATE PROC dbo.NewOrder(@whatName nvarchar(100),@whatPlat nvarchar(100),@whatType nvarchar(100),@whom nvarchar(100))
AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @PID int = (select cp.Person_ID from Customer.Person cp where cp.DisplayName like @whom)
DECLARE @GID int = (select g.Game_ID from Product.Game g where g.Game_name like @whatName)
DECLARE @OID TABLE (OrderID int)

INSERT INTO Orders.Orders(Person_ID,OrderStatus_ID,Order_Date,DiscountedPrice)
OUTPUT inserted.Order_ID INTO @OID
VALUES(@PID,1,GETDATE(),dbo.DiscPrice(@whatName,@whatPlat,@whatType))

INSERT INTO Orders.OrderDetails(Game_ID,Order_ID)
	SELECT @GID, o.OrderID
	from @OID o
END TRY
BEGIN CATCH
	PRINT CONCAT('Error number: ', ERROR_NUMBER(),' || Error state: ', ERROR_STATE(),' || Error severity: ', ERROR_SEVERITY());
	PRINT CONCAT('Error message: ', ERROR_MESSAGE());
	PRINT CONCAT('Error occured in the ', ERROR_LINE() ,'. line of ', ERROR_PROCEDURE());
	PRINT '-----------------------------------------------------------------------------
Something went wrong. Check again data you would like to insert.
If you think that every input is correct, contact with DBO.
-----------------------------------------------------------------------------'
END CATCH
GO

----------------------------------------------------------------------------------------------------

USE vizsga
GO

DROP TRIGGER IF EXISTS [Orders].trgOnNewOrder
GO

CREATE TRIGGER trgOnNewOrder on Orders.OrderDetails
FOR INSERT
AS
BEGIN
DECLARE @OD date = (select o.Order_Date from inserted i
					join Orders.Orders o on o.Order_ID=i.Order_ID)
DECLARE @RD date = (select g.ReleaseDate
					from inserted i
					join Product.Game g on g.Game_ID=i.Game_ID)
	IF @RD>@OD
		BEGIN
			UPDATE Orders.Orders
			SET OrderStatus_ID = 2
			WHERE Order_ID = (select MAX(Order_ID) from Orders.Orders)
			PRINT '------------------------------------------------------------------
Game does not released yet.
It will appear in orders, but status will be cancalled by default.
------------------------------------------------------------------'
		END
	-- ELSE
	-- 	BEGIN
	-- 		UPDATE Orders.Orders
	-- 		SET OrderStatus_ID = 3
	-- 		WHERE Order_ID = (select MAX(Order_ID) from Orders.Orders)
	-- 	END
END
GO
-----------------------------------------------------------------------------------------------------

USE vizsga
GO

DROP PROCEDURE IF EXISTS Order_Succes
GO

CREATE PROCEDURE Order_Succes(@Order_ID int)
AS
BEGIN
	UPDATE Orders.Orders
	SET OrderStatus_ID = 3
	WHERE Order_ID = @Order_ID
END
GO
---------------------------------------------------------------------------------------------------------

USE vizsga
GO

EXEC dbo.NewOrder 'Battlef%','win%','base%','Tricor%'
EXEC dbo.NewOrder 'Subna%','win%','gold%','Tricor%'
EXEC dbo.NewOrder 'Returnal%','PlayStation5%','Ulti%','Fluconazole%'
EXEC dbo.NewOrder 'Crusade%','win%','base%','Clonazepam%'
EXEC dbo.NewOrder 'Rachet%','Playstation5%','base%','CitalopramHBr%'
EXEC dbo.NewOrder 'Scarlet%','xbox one%','ulti%','PenicillinVK%'
EXEC dbo.NewOrder 'DOOM Eternal','win%','ulti%','Zetian%'
EXEC dbo.NewOrder 'Doom Eternal: The Ancient Gods - Part One%','win%','add%','Zetian%'
EXEC dbo.NewOrder 'Doom Eternal: The Ancient Gods - Part Two%','win%','add%','Zetian%'
EXEC dbo.NewOrder 'INSIDE%','mac%','base%','Januvia%'
EXEC dbo.NewOrder 'S.T.A.L.K.E.R. 2: Heart of Chernobyl%','xbox series%','gold%','TriNessa%'
EXEC dbo.NewOrder 'Werewolf%','playstation4%','base%','Januvia%'
EXEC dbo.NewOrder 'It Takes Two%','playstation5%','base%','VitaminD(Rx)%'
EXEC dbo.NewOrder 'Valheim%','linux%','base%','Hydrochlorothiazide%'
EXEC dbo.NewOrder 'Resident Evil: Village%','win%','ultimate%','Doxycycline%'
EXEC dbo.NewOrder 'Valheim%','win%','base%','Citalopra%'
EXEC dbo.NewOrder 'Call of Duty: Black Ops Cold War%','win%','gold%','Alprazolam%'
EXEC dbo.NewOrder 'Wolcen: Lords of Mayhem%','win%','base%','Lisino%'
EXEC dbo.NewOrder 'Red Dead Redemption 2%','xbox one%','ulti%','Ventolin%'
EXEC dbo.NewOrder 'Death Stranding%','win%','base%','Benicar%'
EXEC dbo.NewOrder 'Ori and the Will of the Wisps%','nintendo switch%','base%','PantoprazoleSod%'
EXEC dbo.NewOrder 'Far Cry 6%','win%','base%','BenicarHCT%'

UPDATE Orders.Orders set OrderStatus_ID = 3
where Order_ID between 2 and 10

UPDATE Orders.Orders set OrderStatus_ID = 3
where Order_ID between 12 and 18

---------------------------------------------------------------------------------------
USE vizsga
Go

DROP FUNCTION IF EXISTS GetFeatId
GO

CREATE FUNCTION GetFeatId(@value varchar(max))
RETURNS varchar(max)
AS
BEGIN
DECLARE @x nvarchar(max)
DECLARE @y varchar(max)
DECLARE @z varchar(max)

DECLARE getid CURSOR
    FOR SELECT * FROM string_split(@value,';')

OPEN getid
FETCH NEXT FROM getid into @x
WHILE @@FETCH_STATUS = 0
BEGIN
set @z = (select f.Feature_ID from Product.Feature f where @x = f.FeatureName)
set @y = CONCAT_WS(';',@y,@z)
FETCH NEXT FROM getid into @x
END
CLOSE getid
DEALLOCATE getid
RETURN @y
END
GO
---------------------------------------------------------------------------------------
USE vizsga
GO

DROP FUNCTION IF EXISTS GetGenId
GO

CREATE FUNCTION GetGenId(@value varchar(max))
RETURNS varchar(max)
AS
BEGIN
DECLARE @x nvarchar(max)
DECLARE @y varchar(max)
DECLARE @z varchar(max)

DECLARE getid CURSOR
    FOR SELECT * FROM string_split(@value,';')

OPEN getid
FETCH NEXT FROM getid into @x
WHILE @@FETCH_STATUS = 0
BEGIN
set @z = (select g.Genre_ID from Product.Genre g where @x = g.GenreName)
set @y = CONCAT_WS(';',@y,@z)
FETCH NEXT FROM getid into @x
END
CLOSE getid
DEALLOCATE getid
RETURN @y
END
GO
---------------------------------------------------------------------------------------
USE vizsga
GO

DROP FUNCTION IF EXISTS GetPlatId
GO

CREATE FUNCTION GetPlatId(@value varchar(max))
RETURNS varchar(max)
AS
BEGIN
DECLARE @x nvarchar(max)
DECLARE @y varchar(max)
DECLARE @z varchar(max)

DECLARE getid CURSOR
    FOR SELECT * FROM string_split(@value,';')

OPEN getid
FETCH NEXT FROM getid into @x
WHILE @@FETCH_STATUS = 0
BEGIN
set @z = (select p.Platform_ID from product.Platform p where @x = p.PlatformName)
set @y = CONCAT_WS(';',@y,@z)
FETCH NEXT FROM getid into @x
END
CLOSE getid
DEALLOCATE getid
RETURN @y
END
GO

---------------------------------------------------------------------------------------
USE vizsga
GO

DROP FUNCTION IF EXISTS GetTypeId
GO

CREATE FUNCTION GetTypeId(@value varchar(max))
RETURNS varchar(max)
AS
BEGIN
DECLARE @x nvarchar(max)
DECLARE @y varchar(max)
DECLARE @z varchar(max)

DECLARE getid CURSOR
    FOR SELECT * FROM string_split(@value,';')

OPEN getid
FETCH NEXT FROM getid into @x
WHILE @@FETCH_STATUS = 0
BEGIN
set @z = (select t.Type_ID from Product.Type t where @x = t.TypeName)
set @y = CONCAT_WS(';',@y,@z)
FETCH NEXT FROM getid into @x
END
CLOSE getid
DEALLOCATE getid
RETURN @y
END
GO

---------------------------------------------------------------------------------------

USE vizsga
GO
DROP PROCEDURE IF EXISTS Product.AddNewProduct
GO

CREATE PROC Product.AddNewProduct (
									@name nvarchar(255),
									@reldate date,
									@dev varchar(255),
									@pub varchar(255),
									@plat varchar(255),
									@type varchar(255),
									@genre varchar(255),
									@feat varchar(255)
									)
AS
BEGIN TRY

DECLARE @ID table (ID int)
DECLARE @platID int = (select p.Platform_ID from Product.Platform p where p.PlatformName like @plat)
DECLARE @typeID int = (select t.Type_ID from Product.Type t where t.TypeName like @type)
DECLARE @genreID int = (select g.Genre_ID from Product.Genre g where g.GenreName like @genre)
DECLARE @featID int = (select f.Feature_ID from Product.Feature f where f.FeatureName like @feat)

INSERT INTO Product.Game(Game_name,ReleaseDate,Developer,Publisher)
OUTPUT inserted.Game_ID into @ID
VALUES(@name,@reldate,@dev,@pub)

INSERT INTO Product.GamePlatform (Game_ID,Platform_ID)
SELECT i.ID, dbo.GetPlatId(value) from string_split(@plat, ';')
CROSS JOIN @ID i

INSERT INTO Product.GameType(Game_ID,Type_ID)
SELECT i.ID, dbo.GetTypeId(value) from string_split(@type, ';')
CROSS JOIN @ID i

INSERT INTO Product.GameGenre(Game_ID,Genre_ID)
SELECT i.ID, dbo.GetGenId(value) from string_split(@genre, ';')
CROSS JOIN @ID i

INSERT INTO Product.GameFeature(Game_ID,Feature_ID)
SELECT i.ID, dbo.GetFeatId(value) from string_split(@feat, ';')
CROSS JOIN @ID i

END TRY
BEGIN CATCH
	PRINT CONCAT('Error number: ', ERROR_NUMBER(),' || Error state: ', ERROR_STATE(),' || Error severity: ', ERROR_SEVERITY());
	PRINT CONCAT('Error message: ', ERROR_MESSAGE());
	PRINT CONCAT('Error occured in the ', ERROR_LINE() ,'. line of ', ERROR_PROCEDURE());
	PRINT '-----------------------------------------------------------------------------
Something went wrong. Check again data you would like to insert.
If you think that every input is correct, contact with DBO.
-----------------------------------------------------------------------------'
END CATCH
GO

------------------------------------------------------------------------------------------------------------

DROP PROC IF EXISTS Product.AddPrice
GO

CREATE PROCEDURE Product.AddPrice (
									@game nvarchar(200),
									@plat nvarchar(200),
									@type nvarchar(200),
									@price nvarchar(200),
									@mod nvarchar(200)
									)
AS
SET NOCOUNT ON
BEGIN TRY

DECLARE @GameID TABLE (id int) 
INSERT INTO @GameID (id)
SELECT g.Game_ID FROM Product.Game g WHERE @game = g.Game_name

DECLARE @PlatID TABLE (id int)
INSERT INTO @PlatID (id)
SELECT dbo.GetPlatId(value) from string_split(@plat, ';')

DECLARE @TypeID TABLE (id int)
INSERT INTO @TypeID (id)
SELECT dbo.GetTypeId(value) from string_split(@type, ';')

DECLARE @PRICE_SPLIT TABLE (rownum int,price money)
INSERT INTO @PRICE_SPLIT (rownum,price)
SELECT ROW_NUMBER() over (order by (SELECT NULL)),cast(value as money) from string_split(@price, ';')

DECLARE @MOD_SPLIT TABLE (rownum int,modif int)
INSERT INTO @MOD_SPLIT (rownum,modif)
SELECT ROW_NUMBER() over (order by (SELECT NULL)),cast(value as int) from string_split(@mod, ';')

DECLARE @GAMETABLE TABLE(rownum int, GameID int, PlatformID int, TypeID int)
INSERT INTO @GAMETABLE (rownum,GameID,PlatformID,TypeID)
SELECT distinct ROW_NUMBER() over (order by (SELECT NULL)) as rownum, g.id as GameId,p.id as PlatformID,t.id as TypeID
from @GameID g
cross join @PlatID p
cross join @TypeID t

--select * from @GAMETABLE
--select * from @PRICE_SPLIT
--select * from @MOD_SPLIT
INSERT INTO Product.GamePrice
SELECT g.GameID,g.PlatformID,g.TypeID,ps.price as Price,ms.modif as Modifier
from @GAMETABLE g
 left join @PRICE_SPLIT ps on ps.rownum=g.rownum 
 left join @MOD_SPLIT ms on ms.rownum=g.rownum

END TRY
BEGIN CATCH
	PRINT CONCAT('Error number: ', ERROR_NUMBER(),' || Error state: ', ERROR_STATE(),' || Error severity: ', ERROR_SEVERITY());
	PRINT CONCAT('Error message: ', ERROR_MESSAGE());
	PRINT CONCAT('Error occured in the ', ERROR_LINE() ,'. line of ', ERROR_PROCEDURE());
	PRINT '-----------------------------------------------------------------------------
Something went wrong. Check again data you would like to insert.
If you think that every input is correct, contact with DBO.
-----------------------------------------------------------------------------'
END CATCH

-------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS customer.MarkStat
GO

CREATE VIEW Customer.MarkStat AS 
WITH msge AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, pge.GenreName,count(pgg.Genre_ID) as Most_Selled_Genre FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Product.Game pga on pga.Game_ID=od.Game_ID
join Product.GameGenre pgg on pgg.Game_ID=pga.Game_ID
join Product.Genre pge on pge.Genre_ID=pgg.Genre_ID
WHERE o.OrderStatus_ID=3
GROUP BY pge.GenreName
ORDER BY count(pgg.Genre_ID) DESC, pge.GenreName ASC
OFFSET 0 ROWS
),
msga AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, pga.Game_name,count(od.Game_ID) as Most_Selled_Game FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Product.Game pga on pga.Game_ID=od.Game_ID
WHERE o.OrderStatus_ID = 3
GROUP BY pga.Game_name
ORDER BY count(od.Game_ID) DESC, pga.Game_name ASC
OFFSET 0 ROWS
),
mup AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, pp.PlatformName,count(pp.Platform_ID) as Most_Used_Platform FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Product.Game pga on pga.Game_ID=od.Game_ID
join Product.GamePlatform pgp on pgp.Game_ID=pga.Game_ID
join Product.Platform pp on pp.Platform_ID=pgp.Platform_ID
WHERE o.OrderStatus_ID=3
GROUP BY pp.PlatformName
ORDER BY count(pp.Platform_ID) DESC, pp.PlatformName ASC
OFFSET 0 ROWS
),
mst AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, pt.TypeName, count(pt.Type_ID) as Most_Selled_Type FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Product.Game pga on pga.Game_ID=od.Game_ID
join Product.GameType pgt on pgt.Game_ID=pga.Game_ID
join Product.Type pt on pt.Type_ID=pgt.Type_ID
WHERE o.OrderStatus_ID=3
GROUP BY pt.TypeName
ORDER BY count(pt.Type_ID) DESC, pt.TypeName ASC
OFFSET 0 ROWS
),
mpc AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, cp.DisplayName, SUM(o.DiscountedPrice) as Most_Payed_Customer FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Customer.Person cp on cp.Person_ID=o.Person_ID 
WHERE o.OrderStatus_ID=3
GROUP BY cp.DisplayName
ORDER BY Most_Payed_Customer DESC, cp.DisplayName ASC
OFFSET 0 ROWS
)

SELECT
	REPLACE(CONCAT(msge.GenreName,' (',msge.Most_Selled_Genre,')'), '()', '---------') as Most_Selled_Genre,
	REPLACE(CONCAT(msga.Game_name,' (',msga.Most_Selled_Game,')'), '()', '---------') as Most_Selled_Game,
	REPLACE(CONCAT(mup.PlatformName,' (',mup.Most_Used_Platform,')'), '()', '---------') as Most_Used_Platform,
	REPLACE(CONCAT(mst.TypeName,' (',mst.Most_Selled_Type,')'), '()', '---------') as Most_Selled_Type,
	REPLACE(CONCAT(mpc.DisplayName,' (Total spent: ',mpc.Most_Payed_Customer,'€)'), ' (Total spent: €)', '---------') as Favorite_Customer 
FROM msge
FULL OUTER JOIN msga on msga.ROWNUMBER=msge.ROWNUMBER
FULL OUTER JOIN mup on mup.ROWNUMBER=msge.ROWNUMBER
FULL OUTER JOIN mst on mst.ROWNUMBER=msge.ROWNUMBER
FULL OUTER JOIN mpc on mpc.ROWNUMBER=msge.ROWNUMBER
GO

--select * from customer.MarkStat

-------------------------------------------------------------------------------------------------------------
USE vizsga
GO

CREATE NONCLUSTERED INDEX IX_Poduct_GameName_ByReleaseDate
ON Product.Game (Game_name)
INCLUDE (ReleaseDate)
GO


CREATE NONCLUSTERED INDEX IX_Orders_OrderDate_ByDiscPrice
ON Orders.Orders (Order_Date)
INCLUDE (DiscountedPrice)
GO


CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_Person_DisplayName
ON Customer.Person (DisplayName)
GO

------------------------------------------------------------------------------------------------------------

USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'FULL_BACKUP', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DESKTOP-H1TDU4S\User', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'FULL_BACKUP', @server_name = N'DESKTOP-H1TDU4S'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'FULL_BACKUP', @step_name=N'FULLBACKUP', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=2, 
		@retry_interval=15, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @BackupName nvarchar(200)
SELECT @BackupName = ''E:\Codecool1\DBSPEC\MSSQL15.MSSQLSERVER\MSSQL\Backup\vizsga_FULL_'' + REPLACE(convert(nvarchar(20),GetDate(),120),'':'',''-'') +''.bak''

BACKUP DATABASE [vizsga] TO  DISK = @BackupName
						 WITH NOFORMAT,
						 NOINIT,
						 NAME = ''vizsga_FULLBACKUP'',
						 SKIP,
						 NOREWIND,
						 NOUNLOAD,
						 STATS = 10

BACKUP LOG [vizsga] TO  DISK = @BackupName
						 WITH NOFORMAT,
						 NOINIT,
						 NAME = ''vizsga_TR_LOGBACKUP'',
						 SKIP,
						 NOREWIND,
						 NOUNLOAD,
						 STATS = 10
GO', 
		@database_name=N'master', 
		@database_user_name=N'dbo', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'FULL_BACKUP', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DESKTOP-H1TDU4S\User', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'FULL_BACKUP', @name=N'FULL_BACKUP', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=2, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20210802, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO
--------------------------------------------------------------------------------------------------------
USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'DIFF_BACKUP', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DESKTOP-H1TDU4S\User', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'DIFF_BACKUP', @server_name = N'DESKTOP-H1TDU4S'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'DIFF_BACKUP', @step_name=N'DIFFBACKUP', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=2, 
		@retry_interval=10, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @BackupName nvarchar(200)
SELECT @BackupName = ''E:\Codecool1\DBSPEC\MSSQL15.MSSQLSERVER\MSSQL\Backup\vizsga_DIFF_'' + REPLACE(convert(nvarchar(20),GetDate(),120),'':'',''-'') +''.bak''


BACKUP DATABASE [vizsga] TO  DISK = @BackupName
			 WITH  DIFFERENTIAL,
			 NOFORMAT,
			 NOINIT,
			 NAME = ''vizsga_DIFF_BACKUP'',
			 SKIP,
			 NOREWIND,
			 NOUNLOAD,
			 STATS = 10
GO', 
		@database_name=N'master', 
		@database_user_name=N'dbo', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'DIFF_BACKUP', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DESKTOP-H1TDU4S\User', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DIFF_BACKUP', @name=N'DIFFBACKUP', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=12, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20210802, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO
--------------------------------------------------------------------------------------------------------


USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'LOG_BACKUP', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DESKTOP-H1TDU4S\User', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'LOG_BACKUP', @server_name = N'DESKTOP-H1TDU4S'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'LOG_BACKUP', @step_name=N'LOGABACKUP', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=2, 
		@retry_interval=5, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @BackupName nvarchar(200)
SELECT @BackupName = ''E:\Codecool1\DBSPEC\MSSQL15.MSSQLSERVER\MSSQL\Backup\vizsga_LOG_'' + REPLACE(convert(nvarchar(20),GetDate(),120),'':'',''-'') +''.bak''

BACKUP LOG [vizsga] TO  DISK = @BackupName
			WITH NOFORMAT,
			NOINIT,
			NAME = ''vizsga_TR_LOGBACKUP'',
			SKIP,
			NOREWIND,
			NOUNLOAD,
			STATS = 10', 
		@database_name=N'master', 
		@database_user_name=N'dbo', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'LOG_BACKUP', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DESKTOP-H1TDU4S\User', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'LOG_BACKUP', @name=N'TR_LOG_BACKUP', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20210802, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO
