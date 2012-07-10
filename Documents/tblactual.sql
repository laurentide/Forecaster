use forecaster
go
truncate table tblactual
go
insert into tblactual (ForecastYearID,ProductCategoryID, Actual, EnterpriseID, CustomerID, TerritoryCodeID,TeamID)
select forecastyearid,ProductCategoryID, sum(d2dgva) as actual, EnterpriseID, CustomerID, TerritoryCodeID,teamid
--into tblactual
from Nomis.S1018252.BOOKING.BPTPHY01
inner join Nomis.S1018252.NOMDBF95.FRA1REL4
on d2c5aa = a1c5aa
inner join tblproductcategories
on a1fxtu = productcategory
inner join tblcustomers
on NomisCustomerNum = d2zxnb
inner join tblforecastyears
on d2iyma = year 
group by forecastyearid,ProductCategoryID, EnterpriseID, CustomerID, TerritoryCodeID,teamid
go
