/* Create empty forecast for FY2011, type 2 */ 
use forecaster
go
delete from tblforecasts
where forecasttypeid = 2
go
insert into tblforecasts (TeamID, ForecastYearID, Approved)
select teamid,ForecastYearID,0 from tblteams cross join tblforecastyears
where forecastyearid =4
go
delete from tblforecastdetails
where productcategoryid is null
go
--Customers
insert into tblforecastdetails (ForecastID, ProductCategoryID, Budgeted, Margin, SegmentID, EnterpriseID, CustomerID)
select forecastid,null,0,0,c.segmentid,d.enterpriseid,customerid
from (tblforecasts a
cross join tblsegments b)
inner join tblenterprises c
on b.segmentid = c.segmentid
inner join tblcustomers d
on c.enterpriseid = d.enterpriseid
and a.teamid = d.teamid

go
--Segments (Count = #salesmen * 6)
insert into tblforecastdetails (ForecastID, Budgeted, SegmentID)
select forecastid,0,segmentid
from (tblforecasts a
cross join tblsegments b)
where forecasttypeid = 2
go
--Enterprise
insert into tblforecastdetails (ForecastID,Budgeted, SegmentID, EnterpriseID)
select forecastid,0,c.segmentid,c.enterpriseid
from (tblforecasts a
cross join tblsegments b)
inner join tblenterprises c
on b.segmentid = c.segmentid
inner join tblcustomers d
on c.enterpriseid = d.enterpriseid
and a.teamid = d.teamid
where forecasttypeid = 2
go
select * from tblforecasts
select * from tblforecastdetails
go
delete from tblforecastdetails
where productcategoryid is null
and segmentid is not null
and enterpriseid is not null
and customerid is null
go
delete from tblforecastdetails
where productcategoryid is null
and segmentid is not null
and enterpriseid is  null
and customerid is null

