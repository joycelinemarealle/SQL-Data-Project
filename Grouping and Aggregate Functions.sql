--Count the number of unique states in the publishers table.
select  count (distinct state)
from publishers;

-- Count the number of distinct countries in the publishers table.
select count (distinct country)
from publishers 
; 

-- Get average prices from the titles table for each type of book, and convert type to char(30).
select type,  cast (avg ( cast (price as numeric)) as char(30)) as "Average Price"
from titles 
group by type
order by "Average Price" desc;

-- Get the earliest and latest publication date in titles.
select min(pubdate) as oldest,  max(pubdate) as latest 
from titles ;

-- Print the difference between (to a resolution of days) the earliest and latest publication date in titles.
select ( max(pubdate) - min (pubdate) ) as daysdiff
from titles t 

-- Using the titles table, get how many books were sold so far this year?
select sum(ytd_sales) as totalbooks
from titles ;

-- Get the total value of the titles sold this year.
select sum (ytd_sales * price) as revenue
from titles ;

-- Get the average advance for titles, if the advance is undefined assume it was 1000.00.
select  avg(coalesce(advance::numeric , 1000.00))::money as avgprice	
from titles; 

-- Get the average advance for titles, if the advance is undefined assume it was 1000.00.
select  avg(case when advance:: numeric is not null then advance :: numeric else 1000.00 end)::money as avgprice	
from titles; 

-- Print the average, min and max book prices within the titles table organised into groups based on type and publisher id.
select
	type,
	pub_id,
	min(price) as minprice, 
	max(price)  as maxprice, 
	avg(price::numeric) :: money as avgprice
from titles 
where type != 'UNDECIDED'
group by type, pub_id;

-- Refine this query to show only those groups whose average price is > $20 and output the results sorted on the average price.
select
	type,
	pub_id,
	min(price) as minprice, 
	max(price) as maxprice, 
	avg(price::numeric) :: money as avgprice
from titles 
group by type, pub_id
having avg(price::numeric) > 20
order by avgprice desc;


-- List the books in order of the length of their title
select title, length(title) as length
from titles 
order by length desc ;

-- Print the type, value (sales multiplied by price), number of rows that contribute to the value grouped by type. You should filter out the "UNDECIDED" type and order by value.
select type, ytd_sales * price as value, count (*)
from titles
where type != 'UNDECIDED'
group by type,ytd_sales * price
order by value desc;

-- What is the average age in months of each type of title?
select 
	type, 
	avg(
		(extract (year from age(current_date, pubdate))*12
		+ extract (month from age(current_date, pubdate)))) as avg_months
from titles
group by type;

-- What is the average age in months of each type of title?
select type, avg ((current_date - pubdate)/30.0)
from titles  group by type

-- How many authors live in each city?
select city, count (au_id)
from authors 
group by city

-- What is the longest title?
select max(length(title))
from titles ;

-- How many books have been sold by each store and how many books have been sold in total?
select stor_id, sum(qty)
from sales
group by stor_id;

select sum(qty)
from sales


select stor_id, sum(qty)
from sales
group by stor_id
union all
select 'total',sum(qty)
from sales;


select coalesce (stor_id, 'Total') as "Store", sum (qty)
from sales s gr oup by rollup(stor_id)
order by "Store";
