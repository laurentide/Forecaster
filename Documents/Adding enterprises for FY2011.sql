--Append Enterprise customers that did more than 50k in 2011
insert into tblenterprises (SegmentID, territorycodeid,EnterpriseNo, EnterpriseName)
select tblterritorycodes.segmentid, tblterritorycodes.territorycodeid, cazxnb,cacstx
from Nomis.S1018252.BOOKING.BPTPHY01
inner join Nomis.S1018252.NOMDBF95.CUSPHY01
on d2zxnb = cazxnb
inner join tblterritorycodes
on caducd = territorycode
left join tblenterprises
on cazxnb = enterpriseno
where d2iyma = 2011
and CANBND = 0 
and enterpriseno is null
and caaqnb = '1'
group by tblterritorycodes.segmentid, tblterritorycodes.territorycodeid, cazxnb,cacstx
having sum(d2dgva) >= 50000
go

--Insert new Rest of Tc's

--Find missing territory codes
SELECT *
  FROM [Forecaster].[dbo].[tblTerritoryCodes]
 right join (select distinct caducd from Nomis.S1018252.NOMDBF95.CUSPHY01) as b
 on territorycode = caducd
 where territorycode is null
 and substring(caducd,1,1) in ('S','T','W','C','E')
 
insert into tblenterprises (SegmentID, territorycodeid, EnterpriseName)
select SegmentID, territorycodeid, 'Rest of ' + territorycode
from dbo.tblTerritoryCodes
where territorycodeid not in (select distinct territorycodeid from tblenterprises)
go

----rectify enterprise tc's
--update tblenterprises
--set territorycodeid = d.territorycodeid
--go
--select a.*,b.*,c.caducd from tblenterprises a inner join tblterritorycodes b
--on a.territorycodeid = b.territorycodeid
--and enterprisename not like 'Rest of%'
--inner join Nomis.S1018252.NOMDBF95.CUSPHY01 c on enterpriseno = cazxnb
--left join tblterritorycodes d on caducd = d.territorycode
--where caducd <> b.territorycode
--and enterpriseno >19 

