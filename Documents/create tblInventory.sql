use forecaster
go
drop table tblinventory
go
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
       ,CILIVC     as [Avg Cost]
       ,[Long Description]5
into tblInventory
From Nomis.S1018252.NOMDBF95.INVPHY01 INV
inner join Nomis.S1018252.NOMDBF95.WIMPHY01 WIM
on cieqcf = ebeqcf
inner join Nomis.S1018252.NOMDBF95.WHMPHY01 WHM
on ebd6cf = chd6cf
inner join Nomis.S1018252.NOMDBF95.PCDPHY01 PCD
on cic5aa = aqc5a
inner join Nomis.S1018252.NOMDBF95.FRA1REL4 FRA
on aqc5aa = a1c5aa
left join Nomis.dbo.tblInventoryLongDescriptions
on inv.cieqcf = inventory_number
where aqaqnb  = '1'
and chaqnb = '1'
and ebaqnb = '1'
and ciaqnb = '1'
and EBJPNB+EBJQNB-EBA0NB-EBK7NB > 0
--and (upper(CIEQCF) like '%' + upper(@Search) +'%' or upper(CIODTY) like '%' + upper(@Search) +'%' or upper(CIOETY) like '%' + upper(@Search) +'%' or upper([Long Description]) like '%' + upper(@Search) +'%')
--and (A1FXTU = @PCFamily or @PCFamily = '_ALL')
--and (A1C5AA = @PC or @PC = '_ALL')
order by [Product Code Category],[Product Code Sub Category],[product code]