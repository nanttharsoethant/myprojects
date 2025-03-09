select *
from dbo.marketing_campaigns
select *
from dbo.sustainable_clothing
select *
from dbo.transactions

--- total revenue per each campaign

select 
mc.campaign_name,
SUM(sc.price * t.quantity) as 'total_revenue'
from dbo.sustainable_clothing sc
left join dbo.transactions t on sc.product_id = t.product_id
left join dbo.marketing_campaigns mc on mc.product_id = sc.product_id
where t.purchase_date between mc.start_date and mc.end_date
group by mc.campaign_name

--- top 5 total product sales per product

select top 5
sc.product_name, 
SUM(t.quantity) as total_quantitysold
from dbo.sustainable_clothing sc
left join dbo.transactions t on sc.product_id = t.product_id
group by sc.product_name
order by total_quantitysold desc

--- quantity sold during each campaign

select 
mc.campaign_name,
sum(t.quantity) as total_quantitysold
from dbo.sustainable_clothing sc
left join dbo.transactions t on sc.product_id = t.product_id
left join dbo.marketing_campaigns mc on mc.product_id = sc.product_id
where t.purchase_date between mc.start_date and mc.end_date
group by mc.campaign_name

--- monthly sale trends

select 
datepart(month, t.purchase_date) as month,
sum(t.quantity* sc.price) as total_revenue
from dbo.sustainable_clothing sc
left join dbo.transactions t on sc.product_id = t.product_id
group by datepart(month, t.purchase_date)


--- total transactions, total products

select count(transaction_id) as total_transactions
from dbo.transactions

select count(product_id) as total_products
from dbo.sustainable_clothing

--- total revenue by product category

select 
sc.category,
SUM(sc.price * t.quantity) as 'total_revenue'
from dbo.sustainable_clothing sc
left join dbo.transactions t on sc.product_id = t.product_id
group by sc.category
order by SUM(sc.price * t.quantity) desc

--- total revenue by product size

select 
sc.size,
SUM(sc.price * t.quantity) as 'total_revenue'
from dbo.sustainable_clothing sc
left join dbo.transactions t on sc.product_id = t.product_id
group by sc.size
order by SUM(sc.price * t.quantity) desc

--- table joins
select 
sc.product_id,
sc.product_name,
sc.category,sc.size,
sc.price,
t.transaction_id,
t.quantity,
t.purchase_date,
mc.campaign_id,
mc.campaign_name,
mc.start_date,
mc.end_date
from dbo.sustainable_clothing sc
left join dbo.transactions t on sc.product_id = t.product_id
left join dbo.marketing_campaigns mc on mc.product_id = sc.product_id