USE vizsga
GO

EXEC Orders.NewOrder 'Battlef%','win%','base%','Tricor%'
EXEC Orders.NewOrder 'Subna%','win%','gold%','Tricor%'
EXEC Orders.NewOrder 'Returnal%','PlayStation5%','Ulti%','Fluconazole%'
EXEC Orders.NewOrder 'Crusade%','win%','base%','Clonazepam%'
EXEC Orders.NewOrder 'Rachet%','Playstation5%','base%','CitalopramHBr%'
EXEC Orders.NewOrder 'Scarlet%','xbox one%','ulti%','PenicillinVK%'
EXEC Orders.NewOrder 'DOOM Eternal','win%','ulti%','Zetian%'
EXEC Orders.NewOrder 'Doom Eternal: The Ancient Gods - Part One%','win%','add%','Zetian%'
EXEC Orders.NewOrder 'Doom Eternal: The Ancient Gods - Part Two%','win%','add%','Zetian%'
EXEC Orders.NewOrder 'INSIDE%','mac%','base%','Januvia%'
EXEC Orders.NewOrder 'S.T.A.L.K.E.R. 2: Heart of Chernobyl%','xbox series%','gold%','TriNessa%'
EXEC Orders.NewOrder 'Werewolf%','playstation4%','base%','Januvia%'
EXEC Orders.NewOrder 'It Takes Two%','playstation5%','base%','VitaminD(Rx)%'
EXEC Orders.NewOrder 'Valheim%','linux%','base%','Hydrochlorothiazide%'
EXEC Orders.NewOrder 'Resident Evil: Village%','win%','ultimate%','Doxycycline%'
EXEC Orders.NewOrder 'Valheim%','win%','base%','Citalopra%'
EXEC Orders.NewOrder 'Call of Duty: Black Ops Cold War%','win%','gold%','Alprazolam%'
EXEC Orders.NewOrder 'Wolcen: Lords of Mayhem%','win%','base%','Lisino%'
EXEC Orders.NewOrder 'Red Dead Redemption 2%','xbox one%','ulti%','Ventolin%'
EXEC Orders.NewOrder 'Death Stranding%','win%','base%','Benicar%'
EXEC Orders.NewOrder 'Ori and the Will of the Wisps%','nintendo switch%','base%','PantoprazoleSod%'
EXEC Orders.NewOrder 'Far Cry 6%','win%','base%','BenicarHCT%'



---------------------------------------------------------------------
--------------------Hogy legyen valami a MarkStat viewba-------------
---------------------------------------------------------------------
UPDATE Orders.Orders set OrderStatus_ID = 3
where Order_ID between 2 and 10

UPDATE Orders.Orders set OrderStatus_ID = 3
where Order_ID between 12 and 18