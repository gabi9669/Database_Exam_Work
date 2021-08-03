USE vizsga
GO

DROP FUNCTION IF EXISTS GetGenId
GO

CREATE FUNCTION GetGenId(@value varchar(max))
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
set @z = (select g.Genre_ID from Product.Genre g where @x = g.GenreName)
set @y = CONCAT_WS(';',@y,@z)
FETCH NEXT FROM getid into @x
END
CLOSE getid
DEALLOCATE getid
RETURN @y
END
GO


--declare @genre varchar(max) = 'Action;RPG;Open World;Adventure;Exploration;Survival'
--DECLARE @genreID int = (select g.Genre_ID from Product.Genre g where g.GenreName like @genre)
--declare @NEWID int = 5

--SELECT @NEWID, dbo.GetGenId(value) from string_split(@genre, ';')