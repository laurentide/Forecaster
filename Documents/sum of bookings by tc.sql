selecT distinct i0oncd,i0rdcd from Nomis.S1018252.NOMDBF95.CSMPHY01
where left(i0oncd,1) in ('S','C','T','E','W')
order by i0oncd

select distinct i0oncd,d2rdcd,l2rrtx ,sum(d2dgva) 
from Nomis.S1018252.BOOKING.BPTPHY01
inner join Nomis.S1018252.NOMDBF95.CSMPHY01
on i0rHcd = d2rHcd
and d2zxnb = i0zxnb
inner join Nomis.S1018252.NOMDBF95.SLSPHY01
on d2rdcd = l2rdcd
where left(i0oncd,1) in ('S','C','T','E','W')
and d2iyma = 2010
group by i0oncd,d2rdcd,l2rrtx
order by i0oncd,sum(d2dgva) desc

select * from Nomis.S1018252.BOOKING.BPTPHY01
