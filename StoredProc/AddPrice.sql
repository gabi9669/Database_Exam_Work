DROP PROC IF EXISTS Product.AddPrice
GO

CREATE PROCEDURE Product.AddPrice (
									@game nvarchar(200),
									@plat nvarchar(200),
									@type nvarchar(200),
									@price nvarchar(200),
									@mod nvarchar(200)
									)
AS
SET NOCOUNT ON
BEGIN TRY

DECLARE @GameID TABLE (id int) 
INSERT INTO @GameID (id)
SELECT g.Game_ID FROM Product.Game g WHERE @game = g.Game_name

DECLARE @PlatID TABLE (id int)
INSERT INTO @PlatID (id)
SELECT dbo.GetPlatId(value) from string_split(@plat, ';')

DECLARE @TypeID TABLE (id int)
INSERT INTO @TypeID (id)
SELECT dbo.GetTypeId(value) from string_split(@type, ';')

DECLARE @PRICE_SPLIT TABLE (rownum int,price money)
INSERT INTO @PRICE_SPLIT (rownum,price)
SELECT ROW_NUMBER() over (order by (SELECT NULL)),cast(value as money) from string_split(@price, ';')

DECLARE @MOD_SPLIT TABLE (rownum int,modif int)
INSERT INTO @MOD_SPLIT (rownum,modif)
SELECT ROW_NUMBER() over (order by (SELECT NULL)),cast(value as int) from string_split(@mod, ';')

DECLARE @GAMETABLE TABLE(rownum int, GameID int, PlatformID int, TypeID int)
INSERT INTO @GAMETABLE (rownum,GameID,PlatformID,TypeID)
SELECT distinct ROW_NUMBER() over (order by (SELECT NULL)) as rownum, g.id as GameId,p.id as PlatformID,t.id as TypeID
from @GameID g
cross join @PlatID p
cross join @TypeID t

--select * from @GAMETABLE
--select * from @PRICE_SPLIT
--select * from @MOD_SPLIT
INSERT INTO Product.GamePrice
SELECT g.GameID,g.PlatformID,g.TypeID,ps.price as Price,ms.modif as Modifier
from @GAMETABLE g
 left join @PRICE_SPLIT ps on ps.rownum=g.rownum 
 left join @MOD_SPLIT ms on ms.rownum=g.rownum

END TRY
BEGIN CATCH
	PRINT CONCAT('Error number: ', ERROR_NUMBER(),' || Error state: ', ERROR_STATE(),' || Error severity: ', ERROR_SEVERITY());
	PRINT CONCAT('Error message: ', ERROR_MESSAGE());
	PRINT CONCAT('Error occured in the ', ERROR_LINE() ,'. line of ', ERROR_PROCEDURE());
	PRINT '-----------------------------------------------------------------------------
Something went wrong. Check again data you would like to insert.
If you think that every input is correct, contact with DBO.
-----------------------------------------------------------------------------'
END CATCH



												------------
---------------------------------------------------USEAGE-------------------------------------------------------------
												------------
--EXEC Product.AddPrice 'GAMENAME',
--						'PLAT[1];PLAT[2]',
--						'TYPE[1];TYPE[2]',
--						'(PLAT[1]TYPE[1]PRICE;PLAT[2]TYPE[1])'s PRICE;(PLAT[1]TYPE[2]PRICE,PLAT[2]TYPE[2])'s PRICE',
--						'(PLAT[1]TYPE[1]MODIF;PLAT[2]TYPE[1])'s MODIF;(PLAT[1]TYPE[2]MODIF,PLAT[2]TYPE[2])'s MODIF'
--						
--EXAMPLE:						
--EXEC Product.AddPrice 'Might and Magic Heroes III-HD Edition',
--						'Windows;Mac OS',
--						'Base Game;Gold Edition',
--						'15.99 ; 15.99; 19.99; 19.99',
--						'100; 100; 100; 100'

--If values is string you cannot/should not use whitespace before or after the semicolon 'Windows; Mac OS' <- like that
--Make sure before execution, that you have written every value right
--Before using it make sure, that the game exists in the database
------------------------------------------------------------------------------------------------------------------------