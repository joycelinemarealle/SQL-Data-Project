SELECT *
from authors;

SELECT *
from titles;

SELECT au_lname, au_fname
from authors;

select au_lname, au_fname, contract-1
from authors

select qty/2
from sales;

select price * 1.5 as "NewPrice"
from titles;

select 
	au_lname as "LastName",
	au_fname
from authors
order by au_lname desc;

select au_fname,au_lname,city
from authors 
order by city, au_lname;

select au_fname,au_lname,city
from authors 
order by 
1 acs
2 desc;


-- convert numeric /int to money or money to nueric price:: numeric
select 
	title, 
	type,
	price, 
	case 
		when price < 10::money then 'Cheap'
		when price between 10:: money and 15:: money then 'Moderate'
		else 'Expensive'
		end as "Price Category"
from titles ;

--length of title
select title, length(title), --left(tittle, 10), right(title,10)
from titles ;

--length of title
select title
from titles ;

select '12.45':: numeric :: money
select cast( cast('12.45'as numeric) as money);

select au_lname ||'' || au_lname  as "Name"
from authors;

-- calc averag price, max, min,  count
select 
	avg (price :: numeric ) :: money,
	min (price :: numeric),
	max ( price :: numeric ) , 
	count(price),
	count (*),
	count ( distinct price)
from titles 


--
--
select state , city
from authors;

--unique states
select distinct state
from authors 
group by state;

-- states
select state 
from authors 
group by state;

-- group by state
select state , count (state)
from authors
group by state

-- group by type and return avg price
select type, avg(price::numeric), pub_id 
from titles
group by type, pub_id;

-- group by type and price
select type, price 
from titles
group by type, price
order by type

--fixed 2
select type , avg(price :: numeric)
from titles  
group by type;