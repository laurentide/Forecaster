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
DROP PROCEDURE getSummary
go
CREATE PROCEDURE getSummary
	(@User nvarchar(50))
AS
SELECT *
from dbo.tblForecasts a 
inner join dbo.tblForecastDetails b
	ON a.forecastid = b.forecastid
inner join tblteams c
	ON a.teamid = c.teamid
inner join tblUsers d
	ON c.teamid = d.teamid
inner join tblProductCategories e
	ON b.productcategoryid = e.productcategoryid
inner join dbo.tblForecastYears f
	ON a.forecastyearid = f.forecastyearid
left join tblactual g
on a.forecastid = g.forecastid
and g.productcategoryid = b.productcategoryid
WHERE windows_log_on = @User
and f.forecastyearid = @year
order by teamname
GO
exec getforecastbyuser @user='lclmtl\duc-duyn', @year=1