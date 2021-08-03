USE vizsga
GO

DROP TRIGGER IF EXISTS Product.trgDontChangeType
GO

CREATE TRIGGER trgDontChangeType on Product.Type
INSTEAD OF UPDATE,DELETE
AS
BEGIN
	PRINT('If you change or delete the already existing types or their IDs
		   it going to cause inconsistence and chaos.
		   These actions cannot be executed.
		   If you have any problem with it, ask DBO.')
END