USE vizsga
GO
DROP PROC IF EXISTS dbo.DelOrder
GO

CREATE PROC dbo.DelOrder(@OrderNumber int)
AS
SET NOCOUNT on
DECLARE @SPID int =(		SELECT TOP 1
							P.SPID
							FROM master.dbo.sysprocesses P
							WHERE P.SPID> 50
							AND P.status not in ('background', 'sleeping')
							AND P.cmd not in ('AWAITING COMMAND',
											  'MIRROR HANDLER',
											  'LAZY WRITER',
											  'CHECKPOINT SLEEP',
											  'RA MANAGER')
							ORDER BY RIGHT(CONVERT(varchar,
										  DATEADD(ms, DATEDIFF(ms, P.last_batch, GETDATE()), '1900-01-01'),
										  121), 12) DESC)
DECLARE @delmess varchar(150) = (SELECT CONCAT('You have now 1 hour to stop the delete if you want, with the KILL command.
SPID to terminate the delete: ', @SPID))
RAISERROR (@delmess,0,1) WITH NOWAIT
WAITFOR DELAY '01:00'
BEGIN TRY
	DELETE FROM Orders.OrderDetails WHERE Order_ID = @OrderNumber
	DELETE FROM Orders.Orders WHERE Order_ID = @OrderNumber
END TRY
BEGIN CATCH
	PRINT CONCAT('Error number: ', ERROR_NUMBER(),' || Error state: ', ERROR_STATE(),' || Error severity: ', ERROR_SEVERITY());
	PRINT CONCAT('Error message: ', ERROR_MESSAGE());
	PRINT CONCAT('Error occured in the ', ERROR_LINE() ,'. line of ', ERROR_PROCEDURE());
END CATCH

exec dbo.DelOrder 1
