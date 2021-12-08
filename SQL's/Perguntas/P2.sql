select
p.name_product,
sum (orderqty),
p.daystomanufacture
from roxy.sales_order_detail sod
join roxy.product p on p.productid = sod.productid
join roxy.special_offer_product sop on sod.productid = sop.productid
group by 3,1
order by 2 desc
limit 3