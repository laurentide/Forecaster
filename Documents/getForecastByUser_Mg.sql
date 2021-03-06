USE [Forecaster]
GO
/****** Object:  StoredProcedure [dbo].[getForecastByUser_Mg]    Script Date: 08/17/2011 13:29:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getForecastByUser_Mg]
	(@team nvarchar(50), @current_year int)
AS
select --TeamName,
	   --max(case when i.year = @current_year then Approved else 0 end) as Approved,
	   productcategory,
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
left join  (select productcategoryid, 
	              sum(case when g.year = @current_year - 2 then actual else 0 end) as Two_Year_Ago_Actual,
                  sum(case when g.year = @current_year - 1 then actual else 0 end) as Last_Year_Actual,
                  sum(case when g.year = @current_year then actual else 0 end) as Current_Year_Actual 
                  from 
	            tblactual f
				inner join tblforecastyears g
				on f.forecastyearid = g.forecastyearid
				where (upper(teamid) = upper(@team) or @team = 0)
				group by productcategoryid) as f
	on c.productcategoryid = f.productcategoryid
inner join tblproductcategories k
on c.productcategoryid = k.productcategoryid
where (upper(b.teamid) = upper(@team) or @team = 0)
and productcategory not in ('','TAX','VALVAXION','EMERSON MARINE','LCL SALES')
group by productcategory,Two_Year_Ago_Actual,Last_Year_Actual,Current_Year_Actual
go
exec [getForecastByUser_Mg] 0,2012