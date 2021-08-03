USE vizsga
GO
DROP PROCEDURE IF EXISTS Product.AddNewProduct
GO

CREATE PROC Product.AddNewProduct (
									@name nvarchar(255),
									@reldate date,
									@dev varchar(255),
									@pub varchar(255),
									@plat varchar(255),
									@type varchar(255),
									@genre varchar(255),
									@feat varchar(255)
									)
AS
SET NOCOUNT ON
BEGIN TRY

DECLARE @ID table (ID int)

INSERT INTO Product.Game(Game_name,ReleaseDate,Developer,Publisher)
OUTPUT inserted.Game_ID into @ID
VALUES(@name,@reldate,@dev,@pub)

INSERT INTO Product.GamePlatform (Game_ID,Platform_ID)
SELECT i.ID, dbo.GetPlatId(value) from string_split(@plat, ';')
CROSS JOIN @ID i

INSERT INTO Product.GameType(Game_ID,Type_ID)
SELECT i.ID, dbo.GetTypeId(value) from string_split(@type, ';')
CROSS JOIN @ID i

INSERT INTO Product.GameGenre(Game_ID,Genre_ID)
SELECT i.ID, dbo.GetGenId(value) from string_split(@genre, ';')
CROSS JOIN @ID i

INSERT INTO Product.GameFeature(Game_ID,Feature_ID)
SELECT i.ID, dbo.GetFeatId(value) from string_split(@feat, ';')
CROSS JOIN @ID i

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
GO


-------------------------------EXAMPLE NEW PRODUCT------------------------------------------
------------------USE SEMICOLON between values int platform, type, genre, feature-----------
--------------Make sure you spelled everything right and use full 'name' of the values------
-----------------------------***********************************----------------------------
--EXEC Product.AddNewProduct 'GAMENAME','2021-08-17','Amplitude Studios','SEGA','Windows;Mac OS',
--'Base Game;Ultimate Edition','Action;Strategy;Turn-based','Single Player;Multi Player'
----------------*********************************************************--------------------