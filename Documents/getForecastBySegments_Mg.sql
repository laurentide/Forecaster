USE [Forecaster]
GO
/****** Object:  StoredProcedure [dbo].[getForecastBySegments_Mng]    Script Date: 08/17/2011 11:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getForecastBySegments_Mng]
	(@current_year int)
AS
select TerritoryCode,
	   h.territorycodeid,
	   d.Enterpriseid,
       EnterpriseName,
       Two_Year_Ago_Actual as Two_Year_Ago_Actual,
       Last_Year_Actual as Last_Year_Actual,
       sum(case when i.year = @current_year - 1 then c.managerbudget else 0 end ) as Last_Year_Budget,
       sum(case when i.year = @current_year then budgeted  else 0 end) as Budgeted,
       Current_Year_Actual as Current_Year_Actual,
       max(case when i.year = @current_year then a.forecastid else 0 end) as forecastid,
       max(case when i.year = @current_year then c.forecastdetailid else 0 end) as forecastdetailid,
       sum(case when i.year = @current_year then c.managerbudget else 0 end ) as managerBudget
	from tblforecasts a
	inner join tblforecastyears i
	on a.forecastyearid = i.forecastyearid
	inner join tblforecastdetails c
	on a.forecastid = c.forecastid
	inner join tblenterprises d
	on c.enterpriseid = d.enterpriseid
	inner join dbo.tblTerritoryCodes h
	on d.territorycodeid = h.territorycodeid
	left join  (select enterpriseid,
	              sum(case when g.year = @current_year - 2 then actual else 0 end) as Two_Year_Ago_Actual,
                  sum(case when g.year = @current_year - 1 then actual else 0 end) as Last_Year_Actual,
                  sum(case when g.year = @current_year then actual else 0 end) as Current_Year_Actual 
                  from 
	            tblactual f
				inner join tblforecastyears g
				on f.forecastyearid = g.forecastyearid
				group by enterpriseid) as f
	on d.enterpriseid = f.enterpriseid
group by TerritoryCode,h.territorycodeid,d.enterpriseid,enterprisename,TerritoryCode,Two_Year_Ago_Actual,Last_Year_Actual,Current_Year_Actual
union all
select TerritoryCode,
	   h.territorycodeid,
	   null,
       null,
       Two_Year_Ago_Actual,
	   Last_Year_Actual,
	   sum(case when i.year = @current_year - 1 then c.managerbudget else 0 end ) as Last_Year_Budget,
       sum(case when i.year = @current_year then budgeted  else 0 end) as Budgeted,
       Current_Year_Actual,
       max(case when i.year = @current_year then a.forecastid else 0 end) as forecastid,
       max(case when i.year = @current_year then c.forecastdetailid else 0 end) as forecastdetailid,
       sum(case when i.year = @current_year then c.managerbudget else 0 end ) as managerBudget
	from tblforecasts a
	inner join tblforecastyears i
	on a.forecastyearid = i.forecastyearid
	inner join tblforecastdetails c
	on a.forecastid = c.forecastid
	inner join tblenterprises d
	on c.enterpriseid = d.enterpriseid
	--left join tblCustomers j
	--on j.enterpriseid = d.enterpriseid
	inner join dbo.tblTerritoryCodes h
	on d.territorycodeid = h.territorycodeid
	left join  (select territorycodeid,
	              sum(case when g.year = @current_year - 2 then actual else 0 end) as Two_Year_Ago_Actual,
                  sum(case when g.year = @current_year - 1 then actual else 0 end) as Last_Year_Actual,
                  sum(case when g.year = @current_year then actual else 0 end) as Current_Year_Actual 
                  from 
	            tblactual f
				inner join tblforecastyears g
				on f.forecastyearid = g.forecastyearid
				group by territorycodeid) as f
	on h.territorycodeid = f.territorycodeid
group by TerritoryCode,h.territorycodeid,Two_Year_Ago_Actual,Last_Year_Actual,Current_Year_Actual
order by TerritoryCode,h.territorycodeid,Enterprisename
go
exec [getForecastBySegments_Mng] 2012
