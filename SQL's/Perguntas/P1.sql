with recursive cte1 as(
SELECT 
sod.salesorderid,
count(salesorderid) as QTD
FROM roxy.sales_order_detail sod 
group by 1
)
select *
from 
cte1
where qtd >=3
