use forecaster
go
truncate table tblenterprises
truncate table tblcustomers
go
/*Real enterprises */
insert into tblenterprises (SegmentID, territorycodeid,EnterpriseNo, EnterpriseName)
select distinct tblsegments.segmentid, tblterritorycodes.territorycodeid,epnbnd,EPO3tY
from Nomis.S1018252.NOMDBF95.ETMPHY01 inner join 
Nomis.S1018252.NOMDBF95.CUSPHY01 on 
EPNBND = CANBND 
inner join tblterritorycodes
on caducd = territorycode
inner join tblsegments
on left(caducd,1) = segmentletter
where epfesu = 'A'
order by EPNBND
go
/*Customers over 50k not already appearing in real enterprises */
insert into tblenterprises (SegmentID, territorycodeid,EnterpriseNo, EnterpriseName)
select segmentid, territorycodeid, cazxnb,cacstx
from Nomis.S1018252.BOOKING.BPTPHY01
inner join Nomis.S1018252.NOMDBF95.CUSPHY01
on d2zxnb = cazxnb
inner join tblterritorycodes
on caducd = territorycode
where d2iyma = 2011
and CANBND = 0 
and cazxnb not in (select enterpriseno from tblenterprises)
group by segmentid, territorycodeid, cazxnb,cacstx 
having sum(d2dgva) >= 50000
go
/* insert Rest of TC customer grouping */
insert into tblenterprises (SegmentID, territorycodeid, EnterpriseName)
select SegmentID, territorycodeid, 'Rest of ' + territorycode
from dbo.tblTerritoryCodes
go
select * from tblenterprises