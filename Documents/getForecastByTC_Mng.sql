USE [Forecaster]
GO
/****** Object:  StoredProcedure [dbo].[getforecastbyTCs_Mng]    Script Date: 08/17/2011 13:45:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getforecastbyTCs_Mng]
	(@Current_year int, @teamid int)
as
--declare @user nvarchar(50)
--declare @current_year int
--set @user = 'LCLMTL\Duc-DuyN'
--set @current_year = 2011
select TeamName,
	   b.teamid,
	   max(case when i.year = @current_year then Approved else 0 end) as Approved,
	   TerritoryCode,
	   d.Enterpriseid,
       EnterpriseName,
       CustomerName,
       NomisCustomerNum,
       sum(case when g.year = @current_year - 2 then actual else 0 end) as Two_Year_Ago_Actual,
       sum(case when g.year = @current_year - 1 then actual else 0 end) as Last_Year_Actual,
       0 as Last_Year_Budget,
       0 as Budgeted,
       sum(case when g.year = @current_year then actual else 0 end) as Current_Year_Actual,
       max(case when i.year = @current_year then a.forecastid else 0 end) as forecastid,
       max(case when i.year = @current_year then c.forecastdetailid else 0 end) as forecastdetailid,
       0 as managerBudget
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
left join tblactual f
on d.enterpriseid = f.enterpriseid
and f.productcategoryid = c.productcategoryid
and f.teamid = a.teamid
and f.customerid = j.customerid
inner join tblforecastyears g
on f.forecastyearid = g.forecastyearid
inner join dbo.tblTerritoryCodes h
on d.territorycodeid = h.territorycodeid
where(upper(b.teamid) = upper(@teamid) or @teamid = 0)
--where upper(Windows_log_on) = upper(@user)
group by teamname,b.teamid,d.enterpriseid,enterprisename,customername,NomisCustomerNum,TerritoryCode
union
select TeamName,
	   b.teamid,
	   max(case when i.year = @current_year then Approved else 0 end) as Approved,
	   TerritoryCode,
	   d.Enterpriseid,
       EnterpriseName,
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
	inner join tblteams b 
	on a.teamid = b.teamid
	inner join tblforecastdetails c
	on a.forecastid = c.forecastid
	inner join tblenterprises d
	on c.enterpriseid = d.enterpriseid
	inner join dbo.tblTerritoryCodes h
	on d.territorycodeid = h.territorycodeid
	left join  (select enterpriseid,
					   teamid,
	              sum(case when g.year = @current_year - 2 then actual else 0 end) as Two_Year_Ago_Actual,
                  sum(case when g.year = @current_year - 1 then actual else 0 end) as Last_Year_Actual,
                  sum(case when g.year = @current_year then actual else 0 end) as Current_Year_Actual 
                  from 
	            tblactual f
				inner join tblforecastyears g
				on f.forecastyearid = g.forecastyearid
				group by enterpriseid,teamid) as f
	on d.enterpriseid = f.enterpriseid
	and b.teamid= f.teamid
	where (upper(b.teamid) = upper(@teamid) or @teamid = 0)
group by teamname,b.teamid,d.enterpriseid,enterprisename,TerritoryCode,Two_Year_Ago_Actual,Last_Year_Actual,Current_Year_Actual
order by teamname,b.teamid,d.enterpriseid,enterprisename,Customername
go
exec [getforecastbyTCs_Mng] 2012,0