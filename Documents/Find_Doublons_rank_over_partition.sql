use forecaster
go
delete from tblforecastdetails
where forecastdetailid in (select forecastdetailid from (
select forecastdetailid, rank() over (partition by productcategoryid order by forecastdetailid) as rank_
from tblforecastdetails
where enterpriseid = 14) as a
where rank_ = 2)

order by productcategoryid

select * from tblenterprises
where enterprisename = 'SABLE'