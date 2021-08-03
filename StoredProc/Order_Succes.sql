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


----------------USEAGE----------------
--EXEC dbo.Order_Succes 19
--------------------------------------