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
-- Author:		Duc Duy Nguyen
-- Create date: 7/2/2010
-- Description:	Get forecast by user, by year
-- =============================================
use forecaster
go
DROP PROCEDURE getForecastByTeam
go
CREATE PROCEDURE getForecastByTeam
	(@Team nvarchar(50))
AS
SELECT 
--       a.ForecastID, 
--       b.forecastdetailid, 
       max(case when forecastyearid = 3 then Approved else 0 end) as Approved,
       ProductCategory, 
       sum(case when forecastyearid = 1 then budgeted else 0 end) as FY09_Budget,
       sum(case when forecastyearid = 1 then actual else 0 end) as FY09_Actual,
       sum(case when forecastyearid = 2 then budgeted else 0 end) as FY10_Budget,
       sum(case when forecastyearid = 2 then actual else 0 end) as FY10_Actual,
       sum(case when forecastyearid = 3 then budgeted else 0 end) as Budgeted,
       sum(case when forecastyearid = 3 then actual else 0 end) as FY11_Actual,
       max(case when forecastyearid = 3 then b.forecastid else 0 end) as forecastid,
       max(case when forecastyearid = 3 then b.forecastdetailid else 0 end) as forecastdetailid,
       max(case when forecastyearid = 3 then b.managerbudget else 0 end ) as managerbudget
       --budgeted, 
       --actual
from dbo.tblForecasts a 
inner join dbo.tblForecastDetails b
	ON a.forecastid = b.forecastid
inner join tblteams c
	ON a.teamid = c.teamid
inner join tblUsers d
	ON c.teamid = d.teamid
inner join tblProductCategories e
	ON b.productcategoryid = e.productcategoryid
left join tblactual g
on a.forecastid = g.forecastid
and g.productcategoryid = b.productcategoryid
WHERE c.teamid like case when @Team = 0 then '%' else @Team end
and forecasttypeid = 1
group by ProductCategory
order by ProductCategory
GO
exec getForecastByTeam @Team=1
go
