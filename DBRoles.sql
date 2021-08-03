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