--Use forecaster
--go
--create PROCEDURE [dbo].[getForecastUser]
--	(@user nvarchar(50), @Current_year int)
--go
declare @user nvarchar(50)
declare @current_year int
set @user = 'LCLMTL\Duc-DuyN'
set @current_year = 2011
select enterprisename,year,sum(actual)
from tblforecasts a
inner join tblteams b 
on a.teamid = b.teamid
inner join tblforecastdetails c
on a.forecastid = c.forecastid
inner join tblenterprises d
on c.enterpriseid = d.enterpriseid
inner join tblusers e
on e.teamid = b.teamid
inner join tblactual f
on d.enterpriseid = f.enterpriseid
and f.productcategoryid = c.productcategoryid
and f.teamid = a.teamid
inner join tblforecastyears g
on f.forecastyearid = g.forecastyearid
inner join dbo.tblTerritoryCodes h
on d.territorycodeid = h.territorycodeid
where upper(Windows_log_on) = upper(@user)
group by enterprisename,year
--order by SEGMENTID