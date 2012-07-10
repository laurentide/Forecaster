select i0oncd,l2rdcd,l2rrtx,sum(d2dgva) from Nomis.S1018252.BOOKING.BPTPHY01
inner join 
Nomis.S1018252.NOMDBF95.CSMPHY01
on d2zxnb = i0zxnb
and i0rhcd = d2rhcd
inner join 
Nomis.S1018252.NOMDBF95.SLSPHY01	
on d2rdcd = l2rdcd
where i0oncd in ('C3','CE','CX','E3','ES','EV','W0','WS','WV','W1','WR')
and d2iyma = 2010
group by i0oncd,l2rdcd,d2rdcd,l2rrtx
order by i0oncd 

select * from Nomis.S1018252.BOOKING.BPTPHY01
select * from Nomis.S1018252.NOMDBF95.CSMPHY01
select * from Nomis.S1018252.NOMDBF95.SLSPHY01	