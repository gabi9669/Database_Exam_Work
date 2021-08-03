USE vizsga
GO

DROP FUNCTION IF EXISTS dbo.DiscPrice
GO

CREATE FUNCTION dbo.DiscPrice (@GameName nvarchar(100),@PlatName varchar(75),@TypeName varchar(40))
RETURNS MONEY
AS
BEGIN
RETURN (select ROUND((cast(gp.Modifier as money)/100)*gp.Price,2)
		from Product.GamePrice gp
		join Product.Game g on g.Game_ID=gp.Game_ID
		join Product.Platform p on p.Platform_ID=gp.Platform_ID
		join Product.Type t on t.Type_ID=gp.Type_ID
		where g.Game_name like @GameName and p.PlatformName like @PlatName and t.TypeName like @TypeName
		)
END
GO


--select dbo.DiscPrice('Subnautica%','win%','base%')