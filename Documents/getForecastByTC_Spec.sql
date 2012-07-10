Use forecaster
go
drop procedure getforecastbyTCs_Spec
go
create PROCEDURE [dbo].getforecastbyTCs_Spec
	(@Current_year int)
as
--declare @user nvarchar(50)
--declare @current_year int
--set @user = 'LCLMTL\Duc-DuyN'
--set @current_year = 2011
select TeamName,
	   max(case when i.year = 2011 then Approved else 0 end) as Approved,
	--   TerritoryCode,
	   productcategory,
	   d.Enterpriseid,
       EnterpriseName,
       sum(case when i.year = @current_year - 2 then actual else 0 end) as FY09_Actual,
       sum(case when i.year = @current_year - 1 then actual else 0 end) as FY10_Actual,
       0 as Budgeted,
       sum(case when i.year = @current_year then actual else 0 end) as FY11_Actual,
       max(case when i.year = 2011 then a.forecastid else 0 end) as forecastid,
       max(case when i.year = 2011 then c.forecastdetailid else 0 end) as forecastdetailid,
       sum(case when i.year = 2011 then c.managerbudget else 0 end ) as managerBudget
	from tblforecasts a
	inner join tblforecastyears i
	on a.forecastyearid = i.forecastyearid
	inner join tblteams b 
	on a.teamid = b.teamid
	inner join tblforecastdetails c
	on a.forecastid = c.forecastid
	inner join tblproductcategories k
	on c.productcategoryid = k.productcategoryid
	inner join tblenterprises d
	on c.enterpriseid = d.enterpriseid
	inner join dbo.tblTerritoryCodes h
	on d.territorycodeid = h.territorycodeid
	left join tblCustomers j
    on j.enterpriseid = d.enterpriseid
	left join tblactual f
	on d.enterpriseid = f.enterpriseid
	and f.productcategoryid = c.productcategoryid
	and f.teamid = a.teamid
	and f.customerid = j.customerid
	--where upper(Windows_log_on) = upper(@User)
group by teamname,k.productcategory,d.enterpriseid,enterprisename
union
select TeamName,
	   max(case when i.year = 2011 then Approved else 0 end) as Approved,
	--   TerritoryCode,
	   productcategory,
	   null,
	   null,
       FY09_Actual,
       FY10_Actual,
       sum(case when i.year = 2011 then budgeted  else 0 end) as Budgeted,
       FY11_Actual,
       max(case when i.year = 2011 then a.forecastid else 0 end) as forecastid,
       max(case when i.year = 2011 then c.forecastdetailid else 0 end) as forecastdetailid,
       sum(case when i.year = 2011 then c.managerbudget else 0 end ) as managerBudget
	from tblforecasts a
	inner join tblforecastyears i
	on a.forecastyearid = i.forecastyearid
	inner join tblteams b 
	on a.teamid = b.teamid
	inner join tblforecastdetails c
	on a.forecastid = c.forecastid
	inner join tblproductcategories k
	on c.productcategoryid = k.productcategoryid
	inner join tblenterprises d
	on c.enterpriseid = d.enterpriseid
	inner join dbo.tblTerritoryCodes h
	on d.territorycodeid = h.territorycodeid
	left join  (select enterpriseid,
					   teamid,
					   productcategoryid,
	              sum(case when g.year = 2011 - 2 then actual else 0 end) as FY09_Actual,
                  sum(case when g.year = 2011 - 1 then actual else 0 end) as FY10_Actual,
                  sum(case when g.year = 2011 then actual else 0 end) as FY11_Actual 
                  from 
	            tblactual f
				inner join tblforecastyears g
				on f.forecastyearid = g.forecastyearid
				group by enterpriseid,teamid,productcategoryid) as f
	on d.enterpriseid = f.enterpriseid
	and b.teamid= f.teamid
	and k.productcategoryid = f.productcategoryid
	--where upper(Windows_log_on) = upper(@User)
group by teamname,productcategory,FY09_Actual,FY10_Actual,FY11_Actual
order by teamname,productcategory
go 
exec getforecastbyTCs_Spec  @current_year='2011'

