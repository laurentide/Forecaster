USE [Forecaster]
GO
/****** Object:  StoredProcedure [dbo].[getOpportunities]    Script Date: 12/24/201'O' 10:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
drop procedure [dbo].[getOpportunities]
go
create PROCEDURE [dbo].[getOpportunities]
(@funnelproductid int, @teamid int, @funnelpositionid int)
AS
select a.OpportunityID, 
	   CustomerName as [Customer], 
	   EPCConsultant as [EPC Consultant], 
	   TeamName as [Salesman], 
	   Name, 
	   LastModifiedDate as [Last Modified Date], 
	   ClosingDate as [Closing Date], 
	   FunnelPosition as [Funnel Pos'n], 
	   a.Percentage/100 as [Prob happening], 
	   PATTID, 
	   a.Total 
	   --FactoredTotal, 
	   --Description	,
	    ,max(case when productcategory = 'AMS'                       and b.total > 0  then 'X' else 'O' end ) as [AMS]
		,max(case when productcategory = 'CSI'                       and b.total > 0  then 'X' else 'O' end ) as [CSI]
		,max(case when productcategory = 'Det-Tronics'               and b.total > 0  then 'X' else 'O' end ) as [Det-Tronics]
		,max(case when productcategory = 'Farris'                    and b.total > 0  then 'X' else 'O' end ) as [Farris]
		,max(case when productcategory = 'Fisher Regs'               and b.total > 0  then 'X' else 'O' end ) as [FisherRegs]
		,max(case when productcategory = 'Fisher Valves'             and b.total > 0  then 'X' else 'O' end ) as [FisherValves]
		,max(case when productcategory = 'IVS'                       and b.total > 0  then 'X' else 'O' end ) as [IVS]
		,max(case when productcategory = 'MMI'                       and b.total > 0  then 'X' else 'O' end ) as [MMI]
		,max(case when productcategory = 'PSS'                       and b.total > 0  then 'X' else 'O' end ) as [PSS]
		,max(case when productcategory = 'RSMT Flow'                 and b.total > 0  then 'X' else 'O' end ) as [RSMT Flow]
		,max(case when productcategory = 'RSMT PTL'                  and b.total > 0  then 'X' else 'O' end ) as [RSMT PTL]
		,max(case when productcategory = 'RSMT Analytical - Gas'     and b.total > 0  then 'X' else 'O' end ) as [RSMT Analytical-Gas]
		,max(case when productcategory = 'RSMT Analytical - Liquid'  and b.total > 0  then 'X' else 'O' end ) as [RSMT Analytical-Liquid]
		,max(case when productcategory = 'Services'                  and b.total > 0  then 'X' else 'O' end ) as [Services]
		,max(case when productcategory = 'VAD'                       and b.total > 0  then 'X' else 'O' end ) as [VAD]
		,max(case when productcategory = 'Wireless'                  and b.total > 0  then 'X' else 'O' end ) as [Wireless]          
from tblOpportunities a
 inner join tblopportunitydetails b
on a.opportunityid = b.opportunityid 
inner join tblfunnelcategories c 
on b.funnelproductid = c.funnelproductid
left join tblFunnelcustomers d
on a.customerid = d.customerid
left join tblteams e
on a.salesmanid = e.teamid
inner join dbo.tblFunnelPositions f
on a.FunnelPositionID = f.FunnelPositionID
where a.opportunityid in (select opportunityid from tblopportunitydetails where ((funnelproductid in (@funnelproductid) and total > 0) or @funnelproductid is null) and (a.funnelpositionid in (@funnelpositionid) or @funnelpositionid is null))
and (a.salesmanid in (@teamid) or @teamid = 0)
group by a.OpportunityID, Originator, CustomerName, CustomerLocation, EPCConsultant, TeamName, Name, CreateDate, LastModifiedDate, ClosingDate, Origin, f.FunnelPosition, a.Percentage, PATTID, a.Total, Description
go
exec [getOpportunities] @teamid = 0, @funnelproductid = 3, @funnelpositionid=null