--query de cração das tabelas--
CREATE TABLE roxy.customer
(
    customerid bigint,
    territoryid bigint,
    modifieddate timestamp without time zone,
    personid text COLLATE pg_catalog."default",
    storeid text COLLATE pg_catalog."default",
    accountnumber text COLLATE pg_catalog."default",
    rowguid text COLLATE pg_catalog."default"
)

CREATE TABLE roxy.person
(
    businessentityid bigint,
    namestyle bigint,
    emailpromotion bigint,
    modifieddate timestamp without time zone,
    persontype text COLLATE pg_catalog."default",
    title text COLLATE pg_catalog."default",
    firstname text COLLATE pg_catalog."default",
    middlename text COLLATE pg_catalog."default",
    lastname text COLLATE pg_catalog."default",
    suffix text COLLATE pg_catalog."default",
    additionalcontactinfo text COLLATE pg_catalog."default",
    demographics text COLLATE pg_catalog."default",
    rowguid text COLLATE pg_catalog."default"
)

CREATE TABLE roxy.product
(
    productid bigint,
    name_product character varying(500) COLLATE pg_catalog."default",
    productnumber character varying(500) COLLATE pg_catalog."default",
    makeflag bigint,
    finishedgoodsflag bigint,
    color character varying(500) COLLATE pg_catalog."default",
    safetystocklevel bigint,
    reorderpoint bigint,
    standardcost bigint,
    listprice bigint,
    "Size" character varying(500) COLLATE pg_catalog."default",
    sizeunitmeasurecode character varying(500) COLLATE pg_catalog."default",
    weightunitmeasurecode character varying(500) COLLATE pg_catalog."default",
    weight character varying(500) COLLATE pg_catalog."default",
    daystomanufacture bigint,
    productline character varying(500) COLLATE pg_catalog."default",
    "Class" character varying(500) COLLATE pg_catalog."default",
    "Style" character varying(500) COLLATE pg_catalog."default",
    productsubcategoryid character varying(500) COLLATE pg_catalog."default",
    productmodelid character varying(500) COLLATE pg_catalog."default",
    sellstartdate timestamp without time zone,
    sellenddate character varying(500) COLLATE pg_catalog."default",
    discontinueddate character varying(500) COLLATE pg_catalog."default",
    rowguid character varying(500) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone
)

CREATE TABLE roxy.sales_order_detail
(
    salesorderid bigint,
    salesorderdetailid bigint,
    carriertrackingnumber text COLLATE pg_catalog."default",
    orderqty bigint,
    productid bigint,
    specialofferid bigint,
    unitprice bigint,
    unitpricediscount bigint,
    linetotal bigint,
    rowguid text COLLATE pg_catalog."default",
    modifieddate timestamp without time zone
)

CREATE TABLE roxy.sales_order_harder
(
    salesorderid bigint,
    revisionnumber bigint,
    orderdate timestamp without time zone,
    duedate timestamp without time zone,
    shipdate timestamp without time zone,
    status bigint,
    onlineorderflag bigint,
    salesordernumber text COLLATE pg_catalog."default",
    purchaseordernumber text COLLATE pg_catalog."default",
    accountnumber text COLLATE pg_catalog."default",
    customerid bigint,
    salespersonid text COLLATE pg_catalog."default",
    territoryid bigint,
    billtoaddressid bigint,
    shiptoaddressid bigint,
    shipmethodid bigint,
    creditcardid text COLLATE pg_catalog."default",
    creditcardapprovalcode text COLLATE pg_catalog."default",
    currencyrateid text COLLATE pg_catalog."default",
    subtotal bigint,
    taxamt bigint,
    freight bigint,
    totaldue bigint,
    "Comment" text COLLATE pg_catalog."default",
    rowguid text COLLATE pg_catalog."default",
    modifieddate timestamp without time zone
)

CREATE TABLE roxy.special_offer_product
(
    specialofferid bigint,
    productid bigint,
    rowguid character varying(500) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone
)