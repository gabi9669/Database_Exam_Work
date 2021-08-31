USE vizsga
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_OrderDetails_OrderID_INC_ALL
ON Orders.OrderDetails (Order_ID)
INCLUDE (Game_ID,Platform_ID,Type_ID)
GO

CREATE NONCLUSTERED INDEX IX_GameType_INC_TypeID
ON Product.GameType (Game_ID)
INCLUDE (Type_ID)
GO


CREATE NONCLUSTERED INDEX IX_GameGenre_INC_GenreID
ON Product.GameGenre (Game_ID)
INCLUDE (Genre_ID)
GO

CREATE NONCLUSTERED INDEX IX_GamePlatform_INC_PlatID
ON Product.GamePlatform (Game_ID)
INCLUDE (Platform_ID)
GO

CREATE NONCLUSTERED INDEX IX_GameFeature_INC_FeatID
ON Product.GameFeature (Game_ID)
INCLUDE (Feature_ID)
GO