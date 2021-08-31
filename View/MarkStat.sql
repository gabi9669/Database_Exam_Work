USE vizsga
GO
DROP VIEW IF EXISTS customer.MarkStat
GO

CREATE VIEW Customer.MarkStat AS 
WITH msge AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, pge.GenreName,count(pgg.Genre_ID) as Most_Selled_Genre FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Product.Game pga on pga.Game_ID=od.Game_ID
join Product.GameGenre pgg on pgg.Game_ID=pga.Game_ID
join Product.Genre pge on pge.Genre_ID=pgg.Genre_ID
WHERE o.OrderStatus_ID=3
GROUP BY pge.GenreName
ORDER BY count(pgg.Genre_ID) DESC, pge.GenreName ASC
OFFSET 0 ROWS
),
msga AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, pga.Game_name,count(od.Game_ID) as Most_Selled_Game FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Product.Game pga on pga.Game_ID=od.Game_ID
WHERE o.OrderStatus_ID = 3
GROUP BY pga.Game_name
ORDER BY count(od.Game_ID) DESC, pga.Game_name ASC
OFFSET 0 ROWS
),
mup AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, pp.PlatformName,count(pp.Platform_ID) as Most_Used_Platform FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Product.Game pga on pga.Game_ID=od.Game_ID
join Product.GamePlatform pgp on pgp.Game_ID=pga.Game_ID
join Product.Platform pp on pp.Platform_ID=pgp.Platform_ID
WHERE o.OrderStatus_ID=3
GROUP BY pp.PlatformName
ORDER BY count(pp.Platform_ID) DESC, pp.PlatformName ASC
OFFSET 0 ROWS
),
mst AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, pt.TypeName, count(pt.Type_ID) as Most_Selled_Type FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Product.Game pga on pga.Game_ID=od.Game_ID
join Product.GameType pgt on pgt.Game_ID=pga.Game_ID
join Product.Type pt on pt.Type_ID=pgt.Type_ID
WHERE o.OrderStatus_ID=3
GROUP BY pt.TypeName
ORDER BY count(pt.Type_ID) DESC, pt.TypeName ASC
OFFSET 0 ROWS
),
mpc AS (
SELECT ROW_NUMBER() over (order by (SELECT NULL)) AS ROWNUMBER, cp.DisplayName, SUM(o.DiscountedPrice) as Most_Payed_Customer FROM Orders.Orders o
join Orders.OrderDetails od on o.Order_ID=od.Order_ID
join Customer.Person cp on cp.Person_ID=o.Person_ID 
WHERE o.OrderStatus_ID=3
GROUP BY cp.DisplayName
ORDER BY Most_Payed_Customer DESC, cp.DisplayName ASC
OFFSET 0 ROWS
)

SELECT
	REPLACE(CONCAT(msge.GenreName,' (',msge.Most_Selled_Genre,')'), '()', '---------') as Most_Selled_Genre,
	REPLACE(CONCAT(msga.Game_name,' (',msga.Most_Selled_Game,')'), '()', '---------') as Most_Selled_Game,
	REPLACE(CONCAT(mup.PlatformName,' (',mup.Most_Used_Platform,')'), '()', '---------') as Most_Used_Platform,
	REPLACE(CONCAT(mst.TypeName,' (',mst.Most_Selled_Type,')'), '()', '---------') as Most_Selled_Type,
	REPLACE(CONCAT(mpc.DisplayName,' (Total spent: ',mpc.Most_Payed_Customer,'€)'), ' (Total spent: €)', '---------') as Favorite_Customer 
FROM msge
FULL OUTER JOIN msga on msga.ROWNUMBER=msge.ROWNUMBER
FULL OUTER JOIN mup on mup.ROWNUMBER=msge.ROWNUMBER
FULL OUTER JOIN mst on mst.ROWNUMBER=msge.ROWNUMBER
FULL OUTER JOIN mpc on mpc.ROWNUMBER=msge.ROWNUMBER


--select * from customer.MarkStat