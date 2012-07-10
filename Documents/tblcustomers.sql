use forecaster
go
TRUNCATE TABLE TBLCUSTOMERS
GO
/*insert enterprise customers*/
insert into tblcustomers (EnterpriseID, NomisCustomerNum, CustomerName,teamid,territorycodeid)
select enterpriseid,cazxnb,cacstx,t.teamid,a.territorycodeid
from Nomis.S1018252.NOMDBF95.CUSPHY01
inner join tblterritorycodes a
on caducd = territorycode
inner join tblenterprises b
on canbnd = enterpriseno
and b.territorycodeid = a.territorycodeid
left join tblteams t
on convert(int,CARDCD) = convert(int,SLS)
where caaqnb = 1
and cafesu = 'A'
and left(caducd,1) in ('S','C','T','W','E')
and cazxnb not in (select cazxnb from tblcustomers)
go
/* insert customer over 50k */
insert into tblcustomers (EnterpriseID, NomisCustomerNum, CustomerName,teamid,territorycodeid)
select tblenterprises.enterpriseid, cazxnb,cacstx, tblteams.teamid,tblterritorycodes.territorycodeid
from Nomis.S1018252.BOOKING.BPTPHY01
inner join Nomis.S1018252.NOMDBF95.CUSPHY01
on d2zxnb = cazxnb
inner join tblterritorycodes
on caducd = territorycode
inner join tblenterprises
on enterpriseno = cazxnb
left join tblteams
on convert(int,CARDCD) = convert(int,SLS)
left join tblcustomers 
on cazxnb = NomisCustomerNum
where d2iyma = 2011
and CANBND = 0 
--and left(caducd,1) in ('S','C','T','W','E')
and NomisCustomerNum is null
group by  tblenterprises.enterpriseid, cazxnb,cacstx, tblteams.teamid,tblterritorycodes.territorycodeid
having sum(d2dgva) >= 50000
go
/*insert rest of clients in respective tc*/
insert into tblcustomers (EnterpriseID, NomisCustomerNum, CustomerName,teamid,territorycodeid)
select enterpriseid,cazxnb,cacstx,tblteams.teamid,tblterritorycodes.territorycodeid
from Nomis.S1018252.BOOKING.BPTPHY01
inner join Nomis.S1018252.NOMDBF95.CUSPHY01
on d2zxnb = cazxnb
inner join tblterritorycodes
on caducd = territorycode
inner join tblenterprises
on tblterritorycodes.territorycodeid = tblenterprises.territorycodeid
left join tblteams
on convert(int,CARDCD) = convert(int,SLS)
where d2iyma = 2011
and cazxnb not in (select NomisCustomerNum from tblcustomers)
and left(caducd,1) in ('S','C','T','W','E')
and enterpriseno is null
and cazxnb not in (select cazxnb from tblcustomers)
group by enterpriseid,cazxnb,cacstx,tblteams.teamid,tblterritorycodes.territorycodeid
having sum(d2dgva) > 0
go
select * from tblcustomers
where teamid = 5