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