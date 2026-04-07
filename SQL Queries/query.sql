SELECT * FROM learning_projects.project2;

select gender, sum(purchase_amount) as revenue_per_gender
from project2
group by gender;
-- since males revenue is more so the company should bring more products for men to expand more

select customer_id, purchase_amount
from project2
where purchase_amount > (
	select avg(purchase_amount) from project2
)
and discount_applied = "YES";


select item_purchased, round(avg(review_rating),2) as avg_review
from project2
group by item_purchased
order by avg(review_rating) desc
limit 5
-- these are the items which are having good rating in market and we should focus on selling more of these products to other places

select shipping_type, avg(purchase_amount)
from project2
group by shipping_type
having shipping_type = 'Express' or shipping_type = 'Standard'
-- since the avg purchase amount is higher in express shipping so the company should aim to improve express shipping

select subscription_status, count(*) as total_users,  avg(purchase_amount) as avg_purchase, sum(purchase_amount) as revenue
from project2
group by subscription_status
-- base don this we found no subscribed users are generatig more revenue and we should try to convert them into subscribed users and also 
-- give more facilities to subscribed users to inc their interest in more purchases


select Groupp, count(*)
from 
(
select customer_id as id, 
CASE
 WHEN sum(previous_purchases) =1 then "New"
 WHEN sum(previous_purchases) >1 and sum(previous_purchases)<=10 then "Returning"
 else  "Loyal"
END as Groupp
from project2 group by customer_id ) t
group by Groupp
-- this tells we have many loyal customers


select category, item_purchased, rn as ranks, counts
from (
	select category, item_purchased, count(item_purchased) as counts, row_number() over(partition by category order by count(item_purchased) desc) as rn
	from project2
	group by category, item_purchased
 ) t
where rn<=3


select age_group, sum(purchase_amount) as total 
from project2
group by age_group

select age_group, total, total*100/sum(total) over() as percent
from (select age_group, sum(purchase_amount) as total 
from project2
group by age_group) t
