insert into tblopportunitydetails (OpportunityID, FunnelProductID, Total, Percentage,bookingdate)
select OpportunityID, FunnelProductID, 0,0,null
--case when funnelproductid = 16 then total else 0 end as total,
--case when funnelproductid = 16 then 100 else 0 end as percentage, 
--case when funnelproductid = 16 then closingdate else null end as closingdate
from tblopportunities
cross join dbo.tblFunnelCategories
where opportunityid >=290
order by opportunityid,funnelproductid

--delete from tblopportunitydetails
--where opportunityid<> 0