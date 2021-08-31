------------------------------------------------------------------------
--------------------Create John Login and User--------------------------
------------------------------------------------------------------------
USE [master]
GO
IF NOT EXISTS 
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'John')
BEGIN
CREATE LOGIN [John] WITH PASSWORD=N'JohnProductManager' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [John]
PRINT 'John Login Created'
END
ELSE
BEGIN
DROP LOGIN [John]

CREATE LOGIN [John] WITH PASSWORD=N'JohnProductManager' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [John]
PRINT 'John Login Recreated'
END

use [vizsga];
GO
IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = 'John')
BEGIN
CREATE USER [John] FOR LOGIN [John]
ALTER USER [John] WITH DEFAULT_SCHEMA=[Product]
ALTER ROLE [ProductManager] ADD MEMBER [John]
PRINT 'John User Created'
END
ELSE
BEGIN
DROP USER [John]

CREATE USER [John] FOR LOGIN [John]
ALTER USER [John] WITH DEFAULT_SCHEMA=[Product]
ALTER ROLE [ProductManager] ADD MEMBER [John]
Print 'John User Recreated'
END
GO
------------------------------------------------------------------------
--------------------Create Magnus Login and User------------------------
------------------------------------------------------------------------
USE [master]
GO
IF NOT EXISTS 
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'Magnus')
BEGIN
CREATE LOGIN [Magnus] WITH PASSWORD=N'MagnusOM' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [Magnus]
PRINT 'Magnus Login Created'
END
ELSE
BEGIN
DROP LOGIN [Magnus]

CREATE LOGIN [Magnus] WITH PASSWORD=N'MagnusOM' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [Magnus]
PRINT 'Magnus Login Recreated'
END

USE [vizsga]
GO
IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = 'Magnus')
BEGIN
CREATE USER [Magnus] FOR LOGIN [Magnus]
ALTER USER [Magnus] WITH DEFAULT_SCHEMA=[Orders]
ALTER ROLE [OrderManager] ADD MEMBER [Magnus]
PRINT 'Magnus User Created'
END
ELSE
BEGIN
DROP USER [Magnus]

CREATE USER [Magnus] FOR LOGIN [Magnus]
ALTER USER [Magnus] WITH DEFAULT_SCHEMA=[Orders]
ALTER ROLE [OrderManager] ADD MEMBER [Magnus]
PRINT 'Magnus User Recreated'
END
------------------------------------------------------------------------
--------------------Create Silvia Login and User------------------------
------------------------------------------------------------------------
USE [master]
GO
IF NOT EXISTS 
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'Silvia')
BEGIN
CREATE LOGIN [Silvia] WITH PASSWORD=N'SilviaMS' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
PRINT 'Silvia Login Created'
END
ELSE
BEGIN
DROP LOGIN [Silvia]

CREATE LOGIN [Silvia] WITH PASSWORD=N'SilviaMS' MUST_CHANGE,
DEFAULT_DATABASE=[vizsga], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
PRINT 'Silvia Login Recreated'
END

USE [vizsga]
GO
IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = 'Silvia')
BEGIN
CREATE USER [Silvia] FOR LOGIN [Silvia]
ALTER USER [Silvia] WITH DEFAULT_SCHEMA=[Customer]
ALTER ROLE [MarketingStat] ADD MEMBER [Silvia]
PRINT 'Silvia User Created'
END
ELSE
BEGIN
DROP USER [Silvia]

CREATE USER [Silvia] FOR LOGIN [Silvia]
ALTER USER [Silvia] WITH DEFAULT_SCHEMA=[Customer]
ALTER ROLE [MarketingStat] ADD MEMBER [Silvia]
PRINT 'Silvia User Recreated'
END