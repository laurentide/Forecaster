truncate table tblactual
go
select ForecastID,ProductCategoryID,sum(d2dgva) as Actual, d.CustomerID, d.enterpriseid
--into tblActual
from tblforecasts a
inner join tblteams b
on a.teamid = b.teamid
inner join tblforecastyears c
on a.forecastyearid = c.forecastyearid
inner join Nomis.S1018252.BOOKING.BPTPHY01 f
on d2iyma = year
and d2rdcd = sls
inner join Nomis.S1018252.NOMDBF95.FRA1REL4
on a1c5aa = d2c5aa
inner join dbo.tblProductCategories
on a1fxtu = ProductCategory
inner join tblcustomers d
on f.d2zxnb = NomisCustomerNum
group by forecastid,productcategoryid,d.CustomerID, d.enterpriseid
