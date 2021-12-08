select
p.productid,
p.name_product,
soh.orderdate,
sum (sod.orderqty)
from roxy.sales_order_harder soh
join roxy.sales_order_detail sod on sod.salesorderid = soh.salesorderid
join roxy.product p on sod.productid = p.productid
group by 1,2,3
order by 4 desc
