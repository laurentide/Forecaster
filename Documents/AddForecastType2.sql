--insert into tblforecasts (TeamID, ForecastTypeID, ForecastYearID, Approved)
--select teamid,2,forecastyearid,0 from tblteams cross join tblforecastyears
go
insert into dbo.tblActual 
(ForecastID, Actual, SegmentID,EnterpriseID,CustomerID)
select forecastid, 
       sum(d2dgva) as actual,
       case when d.segmentid is null then 6 else d.segmentid end as Segmentid,
       case when f.enterpriseid is null then 
       case when left(I0ONCD,1) = 'S' then 36
           when left(I0ONCD,1) = 'C' then 37
           when left(I0ONCD,1) = 'T' then 38
           when left(I0ONCD,1) = 'W' then 39
           when left(I0ONCD,1) = 'E' then 40
           when left(I0ONCD,1) not in ('S','C','T','W','E') then 41
       end
	   else f.enterpriseid
       end as enterpriseid, 
       g.customerid
from tblforecasts a 
inner join tblteams t 
on a.teamid = t.teamid
inner join tblforecastyears b on
a.forecastyearid = b.forecastyearid
inner join Nomis.S1018252.BOOKING.BPTPHY01 c
on d2iyma = b.year
and t.sls = d2rdcd
left join Nomis.S1018252.NOMDBF95.CSMPHY01
on d2rhcd = i0rhcd
and d2zxnb = i0zxnb
left join tblsegments d
on left(I0ONCD,1) = SegmentLetter
left join Nomis.S1018252.NOMDBF95.CUSPHY01 e
on d2zxnb = cazxnb
left join tblenterprises f
on CANBND = EnterpriseNo
left join tblcustomers g
on cazxnb = NomisCustomerNum
where forecasttypeid = 2
group by forecastid, case when d.segmentid is null then 6 else d.segmentid end,
case when f.enterpriseid is null then 
       case when left(I0ONCD,1) = 'S' then 36
           when left(I0ONCD,1) = 'C' then 37
           when left(I0ONCD,1) = 'T' then 38
           when left(I0ONCD,1) = 'W' then 39
           when left(I0ONCD,1) = 'E' then 40
           when left(I0ONCD,1) not in ('S','C','T','W','E') then 41
       end
	  else f.enterpriseid
      end, 
      g.customerid
go
/* segment totals */
insert into tblactual (ForecastID, Actual, SegmentID)
select forecastid, sum(d2dgva) as actual, case when d.segmentid is null then 6 else d.segmentid end as Segmentid
from tblforecasts a 
inner join tblteams t 
on a.teamid = t.teamid
inner join tblforecastyears b on
a.forecastyearid = b.forecastyearid
inner join Nomis.S1018252.BOOKING.BPTPHY01 c
on d2iyma = b.year
and t.sls = d2rdcd
left join Nomis.S1018252.NOMDBF95.CSMPHY01
on d2rhcd = i0rhcd
and d2zxnb = i0zxnb
left join tblsegments d
on left(I0ONCD,1) = SegmentLetter
left join Nomis.S1018252.NOMDBF95.CUSPHY01 e
on d2zxnb = cazxnb
where forecasttypeid = 2
group by forecastid, case when d.segmentid is null then 6 else d.segmentid end
go
/*Enterprise totals */
insert into dbo.tblActual 
(ForecastID, Actual, SegmentID,EnterpriseID)
select forecastid, 
       sum(d2dgva) as actual,
       case when d.segmentid is null then 6 else d.segmentid end as Segmentid,
       case when f.enterpriseid is null then 
       case when left(I0ONCD,1) = 'S' then 36
           when left(I0ONCD,1) = 'C' then 37
           when left(I0ONCD,1) = 'T' then 38
           when left(I0ONCD,1) = 'W' then 39
           when left(I0ONCD,1) = 'E' then 40
           when left(I0ONCD,1) not in ('S','C','T','W','E') then 41
       end
	   else f.enterpriseid
       end as enterpriseid
from tblforecasts a 
inner join tblteams t 
on a.teamid = t.teamid
inner join tblforecastyears b on
a.forecastyearid = b.forecastyearid
inner join Nomis.S1018252.BOOKING.BPTPHY01 c
on d2iyma = b.year
and t.sls = d2rdcd
left join Nomis.S1018252.NOMDBF95.CSMPHY01
on d2rhcd = i0rhcd
and d2zxnb = i0zxnb
left join tblsegments d
on left(I0ONCD,1) = SegmentLetter
left join Nomis.S1018252.NOMDBF95.CUSPHY01 e
on d2zxnb = cazxnb
left join tblenterprises f
on CANBND = EnterpriseNo
where forecasttypeid = 2
group by forecastid, d.segmentid,
case when f.enterpriseid is null then 
       case when left(I0ONCD,1) = 'S' then 36
           when left(I0ONCD,1) = 'C' then 37
           when left(I0ONCD,1) = 'T' then 38
           when left(I0ONCD,1) = 'W' then 39
           when left(I0ONCD,1) = 'E' then 40
           when left(I0ONCD,1) not in ('S','C','T','W','E') then 41
       end
	  else f.enterpriseid
      end
go
select * from tblactual
--delete from tblactual where productcategoryid is null