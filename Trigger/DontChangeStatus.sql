USE vizsga
GO

DROP TRIGGER IF EXISTS Orders.trgDontChangeStatus
GO

CREATE TRIGGER trgDontChangeStatus on Orders.OrderStatus
INSTEAD OF UPDATE,DELETE
AS
BEGIN
	PRINT('If you change or delete the already existing statuses or their IDs
		   it going to cause inconsistence and chaos.
		   These actions cannot be executed.
		   If you have any problem with it, ask DBO.')
END