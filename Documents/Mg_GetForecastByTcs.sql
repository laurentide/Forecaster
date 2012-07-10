USE [Forecaster]
GO
/****** Object:  StoredProcedure [dbo].[GetForecastByTCs]    Script Date: 10/01/2010 14:18:36 ******/
SET ANSI_NULLS ON
go
drop procedure mg_getforecastbytcs
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Mg_GetForecastByTCs]
	(@Current_year int)
as
select TeamName,
	   max(case when i.year = @current_year then Approved else 0 end) as Approved,
	   TerritoryCode,
	   d.Enterpriseid,
       EnterpriseName,
       CustomerName,
       sum(case when g.year = @current_year - 2 then actual else 0 end) as FY09_Actual,
       sum(case when g.year = @current_year - 1 then actual else 0 end) as FY10_Actual,
       0 as Budgeted,
       sum(case when g.year = @current_year then actual else 0 end) as FY11_Actual,
       max(case when i.year = @current_year then a.forecastid else 0 end) as forecastid,
       max(case when i.year = @current_year then c.forecastdetailid else 0 end) as forecastdetailid,
       max(case when i.year = @current_year then c.managerbudget else 0 end ) as managerBudget
from tblforecasts a
inner join tblforecastyears i
on a.forecastyearid = i.forecastyearid
inner join tblteams b 
on a.teamid = b.teamid
inner join tblforecastdetails c
on a.forecastid = c.forecastid
inner join tblenterprises d
on c.enterpriseid = d.enterpriseid
left join tblCustomers j
on j.enterpriseid = d.enterpriseid
inner join tblusers e
on e.teamid = b.teamid
left join tblactual f
on d.enterpriseid = f.enterpriseid
and f.productcategoryid = c.productcategoryid
and f.teamid = a.teamid
and f.customerid = j.customerid
inner join tblforecastyears g
on f.forecastyearid = g.forecastyearid
inner join dbo.tblTerritoryCodes h
on d.territorycodeid = h.territorycodeid
group by TeamName,h.segmentid,teamname,d.enterpriseid,enterprisename,customername,TerritoryCode
union
select TeamName,
	   max(case when i.year = 2011 then Approved else 0 end) as Approved,
	   TerritoryCode,
	   d.Enterpriseid,
       EnterpriseName,
       null,
       FY09_Actual,
       FY10_Actual,
       sum(case when i.year = 2011 then budgeted  else 0 end) as Budgeted,
       FY11_Actual,
       max(case when i.year = 2011 then a.forecastid else 0 end) as forecastid,
       max(case when i.year = 2011 then c.forecastdetailid else 0 end) as forecastdetailid,
       max(case when i.year = 2011 then c.managerbudget else 0 end ) as managerBudget
	from tblforecasts a
	inner join tblforecastyears i
	on a.forecastyearid = i.forecastyearid
	inner join tblteams b 
	on a.teamid = b.teamid
	inner join tblforecastdetails c
	on a.forecastid = c.forecastid
	inner join tblenterprises d
	on c.enterpriseid = d.enterpriseid
	inner join dbo.tblTerritoryCodes h
	on d.territorycodeid = h.territorycodeid
	inner join tblusers e
	on e.teamid = b.teamid
	left join  (select enterpriseid, 
	              sum(case when g.year = 2011 - 2 then actual else 0 end) as FY09_Actual,
                  sum(case when g.year = 2011 - 1 then actual else 0 end) as FY10_Actual,
                  sum(case when g.year = 2011 then actual else 0 end) as FY11_Actual 
                  from 
	            tblactual f
				inner join tblforecastyears g
				on f.forecastyearid = g.forecastyearid
				group by enterpriseid) as f
	on d.enterpriseid = f.enterpriseid
group by TeamName,h.segmentid,teamname,d.enterpriseid,enterprisename,TerritoryCode,FY09_Actual,FY10_Actual,FY11_Actual
go
exec Mg_getForecastbytcs @current_Year = 2011
