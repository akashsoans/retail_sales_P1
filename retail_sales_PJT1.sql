drop table if exists retail_sales;
create table retail_sales(
	transactions_id	int primary key,
	sale_date	date,
	sale_time	timestamp,
	customer_id	int,
	gender varchar(15),
    age	int,
	category varchar(15),
	quantiy	int,
	price_per_unit	float,
	cogs	float,
	total_sale float
);

select * from retail_sales;

-- Data Cleaning --
alter table retail_sales
alter column sale_time type time;

select count(*) from retail_sales

select * from retail_sales
where 
	transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null

delete from retail_sales
where 
	transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null

-- Data Exploration --

-- How many sales we have? --
select count(*) as total_sales
from retail_sales

-- How many unique customers we have? --
select count(distinct customer_id) as customers
from retail_sales

	
-- How many unique category we have? --
select count(distinct category) as customers
from retail_sales

select distinct category
from retail_sales


-- Data Analysis and Business Key problems --

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select * from retail_sales
where category = 'Clothing' and quantiy > 3 and to_char(sale_date,'YYYY-MM') = '2022-11'
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as total_sales
from retail_sales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as avg_age
	from retail_sales
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(distinct transactions_id)
from retail_sales
group by category, gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from 
	(
select extract(year from sale_date) as year_sale, extract(month from sale_date) as month_sale,avg(total_sale) as avg_sale,
	rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by year_sale, month_sale
) as t1
	where rank = 1
	
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) as total
from retail_sales
	group by customer_id
order by total desc limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct customer_id) , category
from retail_sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select count(sale_time) , 
case
when extract(hour from sale_time) < 12  then 'morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'evening'
end as sale_shift
from retail_sales
group by sale_shift

-- end of project -- 