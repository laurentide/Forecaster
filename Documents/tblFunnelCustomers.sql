drop table tblFunnelCustomers
go
select cazxnb as NomisCustomerNum, cacstx as customerName, cacttx as CustomerCity, cat4st as CustomerProvince
into tblFunnelCustomers
 from Nomis.S1018252.NOMDBF95.CUSPHY01
where cafesu = 'A'
and caaqnb = '1'
order by cacstx
go
alter table tblFunnelCustomers add CustomerID int identity(1,1) Primary KEY