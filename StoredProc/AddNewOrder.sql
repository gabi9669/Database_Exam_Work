USE vizsga
GO
DROP PROC IF EXISTS Orders.NewOrder
GO

CREATE PROC Orders.NewOrder(@whatName nvarchar(100),@whatPlat nvarchar(100),@whatType nvarchar(100),@whom nvarchar(100))
AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @PID int = (select cp.Person_ID from Customer.Person cp where cp.DisplayName like @whom)
DECLARE @GID int = (select g.Game_ID from Product.Game g where g.Game_name like @whatName)
DECLARE @PLID int = (select p.Platform_ID from Product.Platform p where p.PlatformName like @whatPlat)
DECLARE @TID int = (select t.Type_ID from Product.Type t where t.TypeName like @whatType)
DECLARE @OID TABLE (OrderID int)

INSERT INTO Orders.Orders(Person_ID,OrderStatus_ID,Order_Date,DiscountedPrice)
OUTPUT inserted.Order_ID INTO @OID
VALUES(@PID,1,GETDATE(),dbo.DiscPrice(@whatName,@whatPlat,@whatType))

INSERT INTO Orders.OrderDetails(Game_ID,Order_ID,Platform_ID,Type_ID)
	SELECT @GID, o.OrderID, @PLID, @TID
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
---------------------------------
-------------EXAMPLE-------------
---------------------------------
--EXEC Orders.NewOrder 'which game','which platform','which type','customers displayname'
--EXEC Orders.NewOrder 'Battlef%','win%','base%','Traffaic%'