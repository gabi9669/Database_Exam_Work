USE vizsga
GO

DROP VIEW IF EXISTS Orders.Orders_Extended
GO

CREATE VIEW Orders.Orders_Extended as
SELECT o.Order_ID,
	   cp.DisplayName,
	   os.StatusDescription,
	   g.Game_name,
	   ISNULL(gpr.Price,'0') AS BasePrice,
	   o.DiscountedPrice,
	   gpr.Price-o.DiscountedPrice AS [Save],
	   o.Order_Date
FROM Product.Game g
join Orders.OrderDetails od on od.Game_ID=g.Game_ID
join Orders.Orders o on o.Order_ID=od.Order_ID
join Orders.OrderStatus os on os.OrderStatus_ID=o.OrderStatus_ID
join Customer.Person cp on cp.Person_ID=o.Person_ID
join Product.Platform p on p.Platform_ID=od.Platform_ID
join Product.Type t on t.Type_ID=od.Type_ID
join Product.GamePrice gpr on gpr.Game_ID=od.Game_ID and gpr.Platform_ID=od.Platform_ID and gpr.Type_ID=od.Type_ID
ORDER BY Order_ID
OFFSET 0 ROWS


--select * from Orders.Orders_Extended