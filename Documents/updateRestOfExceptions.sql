update tblcustomers
set enterpriseid = g.enterpriseid
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
	inner join tblenterprises g
	on e.territorycodeid = g.territorycodeid
	and g.enterprisename like 'Rest%'
		where (c.territorycode <> caducd)
		and b.enterprisename like 'Rest%'
		
update tblcustomers
set territorycodeid = e.territorycodeid
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
	inner join tblenterprises g
	on e.territorycodeid = g.territorycodeid
	and g.enterprisename like 'Rest%'
		where (c.territorycode <> caducd)
		and b.enterprisename like 'Rest%'

select b.enterpriseid,
	   b.enterprisename,
	   nomiscustomernum, 
	   c.territorycode as custtc,
	   caducd, 
	   cacstx, 
	   a.territorycodeid customertcid, 
	   b.territorycodeid as enterprisetcid,
	   e.territorycodeid as newterritorycodeid, 
	   sls, 
	   cardcd,
	   g.enterpriseid as newentid,
	   g.enterprisename as newentname
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
inner join tblenterprises g
on e.territorycodeid = g.territorycodeid
and g.enterprisename like 'Rest%'
where (c.territorycode <> caducd)
and b.enterprisename like 'Rest%'