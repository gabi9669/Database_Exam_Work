------------FULL GAME LIST AND PROPERTIES + PRICE--------------
USE vizsga
GO
DROP VIEW IF EXISTS Product.FullProduct
GO
CREATE VIEW Product.FullProduct AS
with gg as (
select g.Game_ID, g.game_name as Game, string_agg(ge.GenreName, ', ') as Genre from Product.Game g
join Product.GameGenre gg on g.Game_ID=gg.Game_ID
join Product.Genre ge on ge.Genre_ID=gg.Genre_ID
group by g.Game_ID, g.game_name),
gf as (
select g.Game_ID, g.Game_name as Game, string_agg(f.FeatureName, ', ') as Features from Product.Game g
join Product.GameFeature gf on gf.Game_ID=g.Game_ID
join Product.Feature f on f.Feature_ID=gf.Feature_ID
group by g.Game_ID, g.Game_name),
gt as (
select g.Game_ID, g.Game_name as Game, string_agg(t.TypeName, ', ') as [Type] from Product.Game g
left join Product.GameType gt on gt.Game_ID=g.Game_ID
left join Product.Type t on t.Type_ID=gt.Type_ID
group by g.Game_ID, g.Game_name),
gp as (
select g.Game_ID, g.Game_name as Game, string_agg(p.PlatformName, ', ') as [Platform] from Product.Game g
join Product.GamePlatform gp on gp.Game_ID=g.Game_ID
join Product.Platform p on p.Platform_ID=gp.Platform_ID
group by g.Game_ID, g.Game_name),
gpr as (
select g.Game_ID,
Replace(REPLACE(string_agg(concat(p.PlatformName, '-', t.TypeName, ' -> ', isnull(gpr.Price,''),'€ ', '(','-',isnull(gpr.Modifier,'100'),'%',' ','discount',')'), ' ||| ' ), '-100%', 'No'),'0.00€', 'Unknown') as Price from Product.Game g
join Product.GamePlatform gp on gp.Game_ID=g.Game_ID
join Product.Platform p on p.Platform_ID=gp.Platform_ID
join Product.GameType gt on gt.Game_ID=g.Game_ID
join Product.Type t on t.Type_ID=gt.Type_ID
join Product.GamePrice gpr on gpr.Game_ID=g.Game_ID and gpr.Platform_ID=gp.Platform_ID and gpr.Type_ID=gt.Type_ID
group by g.Game_ID
)

select gg.Game_ID, gg.Game, gg.Genre, gf. Features, isnull(gt.Type,'Unknown') as [Type], gp.Platform, isnull(gpr.Price,'Unknown') Price
from gg
left join gf on gf.Game_ID=gg.Game_ID
left join gt on gt.Game_ID=gg.Game_ID
left join gp on gp.Game_ID=gg.Game_ID
left join gpr on gpr.Game_ID=gg.Game_ID



/*select * from Product.FullProduct
where Type is null or Price like '%Unk%'*/