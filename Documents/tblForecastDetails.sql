--truncate table tblforecastdetails
go
insert into tblforecastdetails
(ForecastID, ProductCategoryID, Budgeted, SegmentID, TerritoryCodeID, EnterpriseID,  ManagerBudget, SpecialistBudget)
select ForecastID, ProductCategoryID, 0, SegmentID, a.TerritoryCodeID, a.EnterpriseID, 0, 0
from tblenterprises a
inner join tblcustomers b
on a.enterpriseid = b.enterpriseid
inner join tblteams c
on b.teamid = c.teamid
inner join tblforecasts d
on d.teamid = c.teamid
cross join tblproductcategories
--where b.enterpriseid = 261
where ForecastYearID = 4
group by ForecastID, ProductCategoryID,SegmentID, a.TerritoryCodeID, a.EnterpriseID
go
