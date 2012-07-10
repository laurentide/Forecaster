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
use forecaster
go
drop procedure updateManagerForecast
go
CREATE PROCEDURE updateManagerForecast
(@original_forecastdetailid int, 
 @managerbudget decimal(18,2))
as
update tblforecastDetails
set managerBudget = @managerbudget
where forecastdetailid = @original_forecastdetailid
GO
exec updateManagerForecast @managerbudget = 0, @original_forecastdetailid = 1