with recursive cte1 as(
select
customerid,
count (salesorderid) as qtd
from roxy.sales_order_harder
group by 1
order by 2 desc
) 
,
cte2 as(
select
p.firstname ||' '|| p.middlename ||' '|| p.lastname as nome,
c.customerid 
from roxy.person p
join roxy.customer c on c.customerid = p.businessentityid
)
select 
nome,
qtd
from cte1
join cte2 on cte1.customerid = cte2.customerid
order by 2 desc

--ou--
select
p.firstname ||' '|| p.middlename ||' '|| p.lastname as nome,
count(salesorderid)
from roxy.person p 
join roxy.customer cus on cus.customerid = p.businessentityid
join roxy.sales_order_harder soh on p.businessentityid = soh.customerid
group by 1
order by 2 desc
