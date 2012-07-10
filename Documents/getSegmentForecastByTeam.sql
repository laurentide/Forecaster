USE [Forecaster]
GO
/****** Object:  StoredProcedure [dbo].[getSegmentForecastByUser]    Script Date: 08/11/2010 10:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
go
drop procedure getsegmentforecastbyteam
go

Create PROCEDURE [dbo].[getSegmentForecastByTeam]
	-- Add the parameters for the stored procedure here
	(@Team nvarchar(50))
AS
select max(case when forecastyearid = 3 then Approved else 0 end) as Approved,
	   segmentName,
	   EnterpriseName,
	   CustomerName,
       sum(case when forecastyearid = 1 then actual else 0 end) as FY09_Actual,
       sum(case when forecastyearid = 2 then actual else 0 end) as FY10_Actual,
       sum(case when forecastyearid = 3 then budgeted else 0 end) as Budgeted,
       sum(case when forecastyearid = 3 then actual else 0 end) as FY11_Actual,
       max(case when forecastyearid = 3 then b.forecastid else 0 end) as forecastid,
       max(case when forecastyearid = 3 then b.forecastdetailid else 0 end) as forecastdetailid,
       sum(case when forecastyearid = 3 then managerBudget else 0 end) as managerBudget,
       sum(case when forecastyearid = 3 then specialistBudget else 0 end) as specialistBudget
from tblforecasts a
inner join tblforecastdetails b
on a.forecastid = b.forecastid
inner join tblteams c
on a.teamid = c.teamid
inner join tblusers d
on d.teamid = c.teamid
inner join tblsegments f
on b.segmentid = f.segmentid
left join tblenterprises e
on b.enterpriseid = e.enterpriseid
left join tblcustomers g
on b.customerid = g.customerid
and g.enterpriseid = b.EnterpriseID
and a.teamid = g.teamid
left join tblactual h
on a.forecastid = h.forecastid
and (b.segmentid = h.segmentid or (b.segmentid is null and h.segmentid is null))
and (b.enterpriseid = h.enterpriseid or (b.enterpriseid is null and h.enterpriseid is null))
and (b.customerid = h.customerid or (b.customerid is null and h.customerid is null))
WHERE c.teamid like case when @Team = 0 then '%' else @Team end
and forecasttypeid = 2
group by f.segmentid,segmentName,e.enterpriseid,EnterpriseName,CustomerName
order by f.segmentid asc,e.enterpriseid asc,sum(case when forecastyearid = 2 then actual else 0 end) desc
go
exec getsegmentforecastbyteam @Team = 0