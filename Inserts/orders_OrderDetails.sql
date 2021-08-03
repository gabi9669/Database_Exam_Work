USE vizsga
GO

EXEC dbo.NewOrder 'Battlef%','win%','base%','Tricor%'
EXEC dbo.NewOrder 'Subna%','win%','gold%','Tricor%'
EXEC dbo.NewOrder 'Returnal%','PlayStation5%','Ulti%','Fluconazole%'
EXEC dbo.NewOrder 'Crusade%','win%','base%','Clonazepam%'
EXEC dbo.NewOrder 'Rachet%','Playstation5%','base%','CitalopramHBr%'
EXEC dbo.NewOrder 'Scarlet%','xbox one%','ulti%','PenicillinVK%'
EXEC dbo.NewOrder 'DOOM Eternal','win%','ulti%','Zetian%'
EXEC dbo.NewOrder 'Doom Eternal: The Ancient Gods - Part One%','win%','add%','Zetian%'
EXEC dbo.NewOrder 'Doom Eternal: The Ancient Gods - Part Two%','win%','add%','Zetian%'
EXEC dbo.NewOrder 'INSIDE%','mac%','base%','Januvia%'
EXEC dbo.NewOrder 'S.T.A.L.K.E.R. 2: Heart of Chernobyl%','xbox series%','gold%','TriNessa%'
EXEC dbo.NewOrder 'Werewolf%','playstation4%','base%','Januvia%'
EXEC dbo.NewOrder 'It Takes Two%','playstation5%','base%','VitaminD(Rx)%'
EXEC dbo.NewOrder 'Valheim%','linux%','base%','Hydrochlorothiazide%'
EXEC dbo.NewOrder 'Resident Evil: Village%','win%','ultimate%','Doxycycline%'
EXEC dbo.NewOrder 'Valheim%','win%','base%','Citalopra%'
EXEC dbo.NewOrder 'Call of Duty: Black Ops Cold War%','win%','gold%','Alprazolam%'
EXEC dbo.NewOrder 'Wolcen: Lords of Mayhem%','win%','base%','Lisino%'
EXEC dbo.NewOrder 'Red Dead Redemption 2%','xbox one%','ulti%','Ventolin%'
EXEC dbo.NewOrder 'Death Stranding%','win%','base%','Benicar%'
EXEC dbo.NewOrder 'Ori and the Will of the Wisps%','nintendo switch%','base%','PantoprazoleSod%'
EXEC dbo.NewOrder 'Far Cry 6%','win%','base%','BenicarHCT%'



---------------------------------------------------------------------
--------------------Hogy legyen valami a MarkStat viewba-------------
---------------------------------------------------------------------
UPDATE Orders.Orders set OrderStatus_ID = 3
where Order_ID between 2 and 10

UPDATE Orders.Orders set OrderStatus_ID = 3
where Order_ID between 12 and 18