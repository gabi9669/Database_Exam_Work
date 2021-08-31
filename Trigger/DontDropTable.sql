USE vizsga
GO
DROP TRIGGER IF EXISTS DontDropTablePls
GO

CREATE TRIGGER DontDropTablePls 
ON DATABASE 
FOR DROP_TABLE 
AS 
   PRINT '---------------------------------------------------------------------------------
Ask dbo to delete table or to turn off the trigger, if you want to delete tables!
---------------------------------------------------------------------------------' 
   ROLLBACK