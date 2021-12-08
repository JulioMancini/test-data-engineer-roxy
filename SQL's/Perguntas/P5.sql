SELECT 
salesorderid,
orderdate,
totaldue 
FROM roxy.sales_order_harder soh 
where 
totaldue >= '1000'
and 
extract(year from orderdate::timestamp) = 2011
and
extract(month from orderdate::timestamp) = 11
order by totaldue desc 
