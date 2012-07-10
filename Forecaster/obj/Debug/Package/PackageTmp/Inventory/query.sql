select  CIEQCF     as [Inventory Number]
       ,CHD6CF     as [Warehouse Number]
	   ,CHMVTY     as [Warehouse Name]
       ,CIODTY     as [Description 1]
       ,CIOETY     as [Description 2]
       ,A1FXTU     as [Product Code Category]
       ,A1FYTU     as [Product Code Sub Category]
       ,CIC5AA     as [Product Code]
       ,AQC6AA     as [Product Code Description]
       ,EBJPNB     as [Quantity on Hand]
       ,EBJQNB     as [Quantity on Order]
       ,EBA0NB     as [Quantity Back Ordered]
       ,EBK7NB     as [Quantity on Reserve]
       ,CILIVC     as [Avg_Cost_On_Hand]
       --,[Long Description]
From Nomis.S1018252.NOMDBF95.INVPHY01 INV
inner join Nomis.S1018252.NOMDBF95.WIMPHY01 WIM
on cieqcf = ebeqcf
inner join Nomis.S1018252.NOMDBF95.WHMPHY01 WHM
on ebd6cf = chd6cf
inner join Nomis.S1018252.NOMDBF95.PCDPHY01 PCD
on cic5aa = aqc5aa
inner join Nomis.S1018252.NOMDBF95.FRA1REL4 FRA
on aqc5aa = a1c5aa
--left join (SELECT cieqcf as Inventory_number
--     , left((SELECT CAST(rtrim(EGJBTX) + ', ' AS VARCHAR(MAX)) 
--         FROM Nomis.S1018252.NOMDBF95.INDPHY01   
--         WHERE (egeqcf = b.cieqcf) 
--         order by egapnb
--         FOR XML PATH ('')
--       )
--       ,len((SELECT CAST(rtrim(EGJBTX) + ', ' AS VARCHAR(MAX)) 
--         FROM Nomis.S1018252.NOMDBF95.INDPHY01   
--         WHERE (egeqcf = b.cieqcf) 
--         FOR XML PATH ('')
--       ))-1) AS [Long Description]
--FROM Nomis.S1018252.NOMDBF95.INVPHY01  b) as INDPHY01
--on inv.cieqcf = inventory_number
where aqaqnb  = '1'
and chaqnb = '1'
and ebaqnb = '1'
and ciaqnb = '1'
and EBJPNB+EBJQNB-EBA0NB-EBK7NB > 0
and CIEQCF like '%DOMTAR%'
order by [Product Code Category],[Product Code Sub Category],[product code]
 

select * from Nomis.S1018252.NOMDBF95.INDPHY01 WIM
FIELD COMMUNICATOR,

select egeqcf
from Nomis.S1018252.NOMDBF95.INDPHY01  
for xml path('')

SELECT cieqcf as inventory_number
     , left((SELECT CAST(rtrim(EGJBTX) + ', ' AS VARCHAR(MAX)) 
         FROM Nomis.S1018252.NOMDBF95.INDPHY01   
         WHERE (egeqcf = b.cieqcf) 
         order by egapnb
         FOR XML PATH ('')
       )
       ,len((SELECT CAST(rtrim(EGJBTX) + ', ' AS VARCHAR(MAX)) 
         FROM Nomis.S1018252.NOMDBF95.INDPHY01   
         WHERE (egeqcf = b.cieqcf) 
         FOR XML PATH ('')
       ))) AS Description
FROM Nomis.S1018252.NOMDBF95.INVPHY01  b

select * from Nomis.S1018252.NOMDBF95.INDPHY01  
where egeqcf = '1E801204022'

SELECT cieqcf as inventory_number,
(SELECT CAST(rtrim(EGJBTX) + ', ' AS VARCHAR(MAX)) 
         FROM Nomis.S1018252.NOMDBF95.INDPHY01   
         WHERE (egeqcf = b.cieqcf) 
         order by egapnb
         FOR XML PATH ('')
       )
FROM Nomis.S1018252.NOMDBF95.INVPHY01  b
where cieqcf = 'RSMT88'

select * from  Nomis.S1018252.NOMDBF95.FRA1REL4