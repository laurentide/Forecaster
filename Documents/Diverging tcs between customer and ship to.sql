select CAZXNB,i0rhcd,caducd, i0oncd,cacstx,i0lgtx,sum(d2dgva)
from Nomis.S1018252.NOMDBF95.CUSPHY01 
inner join Nomis.S1018252.NOMDBF95.CSMPHY01
on cazxnb = i0zxnb
INNER JOIN Nomis.S1018252.BOOKING.BPTPHY01
on d2zxnb = cazxnb 
and d2rhcd = i0rhcd
where i0oncd <> caducd
and d2iyma = 2010
and left(i0oncd,1) in  ('S','C','T','W','E')
group by CAZXNB,i0rhcd,caducd, i0oncd,cacstx,i0lgtx
having sum(d2dgva) > 1000
order by cazxnb 