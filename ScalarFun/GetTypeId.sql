USE vizsga
GO

DROP FUNCTION IF EXISTS GetTypeId
GO

CREATE FUNCTION GetTypeId(@value varchar(max))
RETURNS varchar(max)
AS
BEGIN
DECLARE @x nvarchar(max)
DECLARE @y varchar(max)
DECLARE @z varchar(max)

DECLARE getid CURSOR
    FOR SELECT * FROM string_split(@value,';')

OPEN getid
FETCH NEXT FROM getid into @x
WHILE @@FETCH_STATUS = 0
BEGIN
set @z = (select t.Type_ID from Product.Type t where @x = t.TypeName)
set @y = CONCAT_WS(';',@y,@z)
FETCH NEXT FROM getid into @x
END
CLOSE getid
DEALLOCATE getid
RETURN @y
END
GO

--declare @type varchar(max) = 'Base Game;Ultimate Edition;Add-on'
--DECLARE @typeID int = (select t.Type_ID from Product.Type t where t.TypeName like @type)
--declare @NEWID int = 5

--SELECT @NEWID, dbo.GetTypeId(value) from string_split(@type, ';