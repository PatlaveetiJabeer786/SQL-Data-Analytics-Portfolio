 Pizza_Sales_Analysis_Queries.sql.
select * from Pizza

--- 1. Total Revenue:

select sum(total_price) total_revenue from pizza

--- 2. Average Order Value

select sum(total_price)/count(distinct order_id)  avg_order_value from pizza

---Total Pizzas Sold

select sum(quantity) toatal_pizza_sold from pizza

---Total Orders

select count( distinct order_id) total_orders from pizza


--- Average Pizzas Per Order
select * from Pizza


select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) avg_pizza_per_order
from pizza

--- Daily Trend for Total Orders

select datename(dw,order_date) as order_day, count(distinct order_id) total_orders from pizza
group by datename(dw,order_date)


--- Monthly Trend for Orders

select datename(MONTH,order_date) as mth_name, count(distinct order_id) total_orders from pizza
group by datename(MONTH,order_date)


--- % of Sales by Pizza Category

select * from pizza

select pizza_category, sum(total_price) sales,sum(total_price) *100  / (select sum(total_price) from pizza where MONTH(order_date)=1) as
total_sales from pizza where MONTH(order_date)=1
group by pizza_category


--- % of Sales by Pizza Size

select pizza_size, cast(sum(total_price) as decimal(10,2)) as sales, 
cast(sum(total_price) *100  / (select sum(total_price) from pizza where datepart(quarter,order_date)=1) as decimal(10,2)) as
total_sales from pizza where datepart(quarter, order_date)=1
group by pizza_size


--- Top 5 Pizzas by Revenue

select * from pizza

select top 5 pizza_name, sum(total_price) pizza_by_rev from pizza group by pizza_name order by pizza_by_rev desc


--- Bottom 5 Pizzas by Revenue

select top 5 pizza_name, sum(total_price) pizza_by_rev from pizza group by pizza_name order by pizza_by_rev


--- Top 5 Pizzas by Quantity

select top 5 pizza_name, sum(quantity) pizza_by_quantity from pizza group by pizza_name order by pizza_by_quantity desc

--- Bottom 5 Pizzas by Quantity

select top 5 pizza_name, sum(quantity) pizza_by_quantity from pizza group by pizza_name order by pizza_by_quantity

 
--- Top 5 Pizzas by Total Orders

select top 5  pizza_name, count(distinct order_id) pizza_per_order from pizza group by pizza_name order by pizza_per_order desc

--- Borrom 5 Pizzas by Total Orders

select top 5  pizza_name, count(distinct order_id) pizza_per_order from pizza group by pizza_name order by pizza_per_order
