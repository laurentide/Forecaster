/* update tblenterprises tc's */
update tblenterprises
set territorycodeid =  e.territorycodeid
 from tblcustomers a 
inner join tblenterprises b
on a.enterpriseid = b.enterpriseid
inner join tblterritorycodes c
on c.territorycodeid = a.territorycodeid 
inner join Nomis.S1018252.NOMDBF95.CUSPHY01 f
on nomiscustomernum = cazxnb
inner join tblterritorycodes e
on e.territorycode = f.caducd 
inner join tblteams  d
on a.teamid = d.teamid
inner join tblteams  g
on f.cardcd = g.sls
and caaqnb = 1
where (c.territorycode <> caducd)

/* update tblcustomers salesmen */
update tblcustomers
set teamid =   g.teamid
 from tblcustomers a 
inner join tblenterprises b
on a.enterpriseid = b.enterpriseid
inner join tblterritorycodes c
on c.territorycodeid = a.territorycodeid 
inner join Nomis.S1018252.NOMDBF95.CUSPHY01 f
on nomiscustomernum = cazxnb
inner join tblterritorycodes e
on e.territorycode = f.caducd 
inner join tblteams  d
on a.teamid = d.teamid
inner join tblteams  g
on f.cardcd = g.sls
and caaqnb = 1
where (d.sls <> f.cardcd)

/* change current customer and enterprise binding in forecastdetails and forecast tables */
update tblforecastdetails
set forecastid = e.teamid
from  tblforecasts a
inner join tblforecastdetails b
on a.forecastid = b.forecastid
inner join tblteams d
on a.teamid = d.teamid
inner join tblenterprises f
on f.enterpriseid = b.enterpriseid
inner join tblcustomers c
on f.enterpriseid = c.enterpriseid
inner join tblteams e
on c.teamid = e.teamid
where d.teamid <> e.teamid
and enterprisename not like '%Rest of%'
and b.enterpriseid in (14,29,24,6)
--group by a.forecastid,f.enterpriseid,f.enterprisename, c.customername,d.teamid, d.teamname,e.teamid, e.teamname
--order by enterpriseid

select a.forecastid,f.enterpriseid,f.enterprisename, c.customername,d.teamid as forecastdetail_teamid, d.teamname as forecastdetail_teamname,d.sls as forecastdetail_sls,e.teamid as customer_teamid, e.teamname as customer_teamname, e.sls as cust_sls,CARDCD,cacttx
from  tblforecasts a
inner join tblforecastdetails b
on a.forecastid = b.forecastid
inner join tblteams d
on a.teamid = d.teamid
inner join tblenterprises f
on f.enterpriseid = b.enterpriseid
inner join tblcustomers c
on f.enterpriseid = c.enterpriseid
inner join Nomis.S1018252.NOMDBF95.CUSPHY01
on nomiscustomernum = cazxnb
inner join tblteams e
on c.teamid = e.teamid
where d.teamid <> e.teamid
and enterprisename not like '%Rest of%'
and caaqnb = 1
group by a.forecastid,f.enterpriseid,f.enterprisename, c.customername,d.teamid , d.teamname ,d.sls ,e.teamid , e.teamname , e.sls ,CARDCD,cacttx
order by enterpriseid



(select b.enterpriseid,nomiscustomernum, c.territorycode as custtc,caducd, cacstx, a.territorycodeid customertcid, b.territorycodeid as enterprisetcid,e.territorycodeid as newterritorycodeid, sls, cardcd
 from tblcustomers a 
inner join tblenterprises b
on a.enterpriseid = b.enterpriseid
inner join tblterritorycodes c
on c.territorycodeid = a.territorycodeid 
inner join Nomis.S1018252.NOMDBF95.CUSPHY01 f
on nomiscustomernum = cazxnb
inner join tblterritorycodes e
on e.territorycode = f.caducd 
inner join tblteams  d
on a.teamid = d.teamid
and caaqnb = 1
where (c.territorycode <> caducd))

select * from tblcustomers
from tblcustomers a
inner join tblterritorycodes b
on a.territorycodeid = b.territorycodeid
inner join Nomis.S1018252.NOMDBF95.CUSPHY01 c
on nomiscustomernum = cazxnb
and caaqnb = 1
inner join tblterritorycodes d
on caducd = d.territorycode
where (b.territorycode <> caducd)

select b.enterpriseid,nomiscustomernum, c.territorycode as custtc,caducd, cacstx, a.territorycodeid customertcid, b.territorycodeid as enterprisetcid,e.territorycodeid as newterritorycodeid, d.sls, cardcd
 from tblcustomers a 
inner join tblenterprises b
on a.enterpriseid = b.enterpriseid
inner join tblterritorycodes c
on c.territorycodeid = a.territorycodeid 
inner join Nomis.S1018252.NOMDBF95.CUSPHY01 f
on nomiscustomernum = cazxnb
inner join tblterritorycodes e
on e.territorycode = f.caducd 
inner join tblteams  d
on a.teamid = d.teamid
inner join tblteams  g
on f.cardcd = g.sls
and caaqnb = 1
where (d.sls <> f.cardcd)
order by nomiscustomernum
--

select * from Nomis.S1018252.NOMDBF95.SLSPHY01
where l2rdcd = '709'

select * from Nomis.S1018252.NOMDBF95.CUSPHY01
where cacstx like '%CASCADES%'

update tblforecastdetails
set managerbudget = budgeted
where budgeted <> 0 and managerbudget = 0

select * from tblforecastdetails a
inner join tblenterprises b
on a.enterpriseid = b.enterpriseid
and enterprisename = 'SABLE'