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