USE vizsga
GO

DROP TRIGGER IF EXISTS Product.trgDontChangeFeature
GO

CREATE TRIGGER trgDontChangeFeature on Product.Feature
INSTEAD OF UPDATE,DELETE
AS
BEGIN
	PRINT('If you change or delete the already existing features or their IDs
		   it going to cause inconsistence and chaos.
		   These actions cannot be executed.
		   If you have any problem with it, ask DBO.')
END