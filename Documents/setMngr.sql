-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the mngrify Values for Template Parameters 
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
use Forecaster
go
drop procedure setmngr
go
CREATE PROCEDURE setmngr
	(@forecastdetailid int)	
AS
update tblforecastdetails
set budgeted = ManagerBudget
where forecastdetailid = @forecastdetailid
GO
exec setmngr @forecastdetailid = 1
go
select * from tblforecastdetails where forecastdetailid = 1