truncate table tblterritorycodes
go
insert into tblterritorycodes ([TerritoryCode],[SegmentID])
select distinct caducd,case when segmentid is null then 6 else segmentid end as segmentid 
from Nomis.S1018252.NOMDBF95.CUSPHY01 inner join dbo.tblSegments
on left(caducd,1) = segmentletter
order by caducd
  