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
--	ELSE
--		BEGIN
--			UPDATE Orders.Orders
--			SET OrderStatus_ID = 3
--			WHERE Order_ID = (select MAX(Order_ID) from Orders.Orders)
--		END
END