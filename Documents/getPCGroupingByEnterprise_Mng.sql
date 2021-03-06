USE [Forecaster]
GO
/****** Object:  StoredProcedure [dbo].[getPCGroupingByEnterprise_Mng]    Script Date: 08/17/2011 13:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[getPCGroupingByEnterprise_Mng]
(@Current_year int,@enterpriseid int,@teamid int)
as
--declare @enterpriseid int
--declare @current_year int
--declare @user nvarchar(50)
--set @enterpriseid = 111
--set @current_year = 2011
--set @user = 'lclmtl\duc-duyn'
select max(forecastdetailid) as forecastdetailid,
       EnterpriseName,
       Productcategory,
       sum(case when g.year = @current_year - 2 then actual else 0 end) as Two_Year_Ago_Actual,
       sum(case when g.year = @current_year - 1 then actual else 0 end) as Last_Year_Actual,
       max(case when i.year = @current_year - 1 then c.managerbudget else 0 end ) as Last_Year_Budget,
       max(case when i.year = @current_year then c.Budgeted else 0 end ) as Budgeted,
       max(case when i.year = @current_year then c.ManagerBudget else 0 end ) as ManagerBudget
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
left join tblCustomers j
on j.enterpriseid = d.enterpriseid
inner join tblproductcategories k
on k.productcategoryid = c.productcategoryid
left join (tblactual f
			inner join tblforecastyears g
			on f.forecastyearid = g.forecastyearid)
on d.enterpriseid = f.enterpriseid
and f.productcategoryid = c.productcategoryid
and f.teamid = a.teamid
and f.customerid = j.customerid
where c.enterpriseid = @enterpriseid
and b.teamid = @teamid
--and upper(Windows_log_on) = upper(@user)
and productcategory not in ('','TAX','VALVAXION','EMERSON MARINE','LCL SALES')
--and i.year = @current_year
group by 
	Productcategory,EnterpriseName
order by productcategory
go
exec [getPCGroupingByEnterprise_Mng] 2012,111,1