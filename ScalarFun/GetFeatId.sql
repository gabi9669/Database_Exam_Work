USE vizsga
Go

DROP FUNCTION IF EXISTS GetFeatId
GO

CREATE FUNCTION GetFeatId(@value varchar(max))
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
set @z = (select f.Feature_ID from Product.Feature f where @x = f.FeatureName)
set @y = CONCAT_WS(';',@y,@z)
FETCH NEXT FROM getid into @x
END
CLOSE getid
DEALLOCATE getid
RETURN @y
END
GO


--declare @feat varchar(max) = 'Single Player;Multi Player;Co-op;VR;Controller support'
--DECLARE @featID int = (select f.Feature_ID from Product.Feature f where f.FeatureName like @feat)
--declare @NEWID int = 5

--SELECT @NEWID, dbo.GetFeatId(value) from string_split(@feat, ';')