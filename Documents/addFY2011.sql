/* Create empty forecast for FY2011 */ 
insert into tblForecasts (TeamID, ForecastTypeID, ForecastYearID, Approved)
select teamid, 1, 3, 0 from tblteams
go
insert into tblForecastDetails (ForecastID, ProductCategoryID, CustomerID, SegmentID, Budgeted, Margin)
select forecastid, productcategoryid,null,null,0,0
from tblforecasts cross join (select ProductCategoryID from tblProductCategories where productCategoryid <> 1) a
where forecastyearid = 3
go
/* Create empty forecast for FY2011 */ 
insert into tblForecasts (TeamID, ForecastTypeID, ForecastYearID, Approved)
select teamid, 1, 4, 0 from tblteams
go
insert into tblForecastDetails (ForecastID, ProductCategoryID, CustomerID, SegmentID, Budgeted, Margin)
select forecastid, productcategoryid,null,null,0,0
from tblforecasts cross join (select ProductCategoryID from tblProductCategories where productCategoryid <> 1) a
where forecastyearid = 4
go

--delete from tblforecastdetails
--where forecastDetailid in (select forecastdetailid from tblforecastdetails a inner join tblforecasts b on
--a.forecastid = b.forecastid where forecastyearid = 3)