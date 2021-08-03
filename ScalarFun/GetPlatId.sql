USE vizsga
GO

DROP FUNCTION IF EXISTS GetPlatId
GO

CREATE FUNCTION GetPlatId(@value varchar(max))
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
set @z = (select p.Platform_ID from product.Platform p where @x = p.PlatformName)
set @y = CONCAT_WS(';',@y,@z)
FETCH NEXT FROM getid into @x
END
CLOSE getid
DEALLOCATE getid
RETURN @y
END
GO


--declare @plat varchar(max) = 'Xbox ONE;Windows;PlayStation5;Linux;PlayStation4'
--DECLARE @platID int = (select p.Platform_ID from product.Platform p where p.PlatformName like @plat)
--declare @NEWID int = 5

--SELECT @NEWID, dbo.GetPlatID(value) from string_split(@plat, ';')