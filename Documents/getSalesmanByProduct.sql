-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Use Forecaster
go
drop procedure getSalesmanByProduct
go
CREATE PROCEDURE getSalesmanByProduct
	(@User nvarchar(50))
	AS
SELECT 
--       a.ForecastID, 
--       b.forecastdetailid, 
	   ProductCategory,
       max(case when forecastyearid = 3 then Approved else 0 end) as Approved, 
       TeamName, 
       sum(case when forecastyearid = 1 then budgeted else 0 end) as FY09_Budget,
       sum(case when forecastyearid = 1 then actual else 0 end) as FY09_Actual,
       sum(case when forecastyearid = 2 then budgeted else 0 end) as FY10_Budget,
       sum(case when forecastyearid = 2 then actual else 0 end) as FY10_Actual,
       sum(case when forecastyearid = 3 then budgeted else 0 end) as Budgeted,
       sum(case when forecastyearid = 3 then actual else 0 end) as FY11_Actual,
       max(case when forecastyearid = 3 then b.forecastid else 0 end) as forecastid,
       max(case when forecastyearid = 3 then b.forecastdetailid else 0 end) as forecastdetailid,
       max(case when forecastyearid = 3 then b.specialistbudget else 0 end ) as specialistbudget
       --budgeted, 
       --actual
from dbo.tblForecasts a 
inner join dbo.tblForecastDetails b
	ON a.forecastid = b.forecastid
inner join tblteams c
	ON a.teamid = c.teamid
left join tblactual g
on a.forecastid = g.forecastid
and g.productcategoryid = b.productcategoryid
inner join tblproductcategories d
on d.productcategoryid = b.productcategoryid
inner join tblusers e
on e.productcategoryid = d.productcategoryid
WHERE windows_log_on = @User
 and forecasttypeid = 1
group by ProductCategory,TeamName
order by TeamName
GO
exec getSalesmanByProduct @User='lclmtl\duc-duyn'
GO
