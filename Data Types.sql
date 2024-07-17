
--Find titles with an undefined price.
select title 
from titles 
where price is null ;

--Find the title and price of titles where the price is below 10.50
select title, price
from titles 
where cast ( price as numeric) < 10.50;

--Find the price of all titles, where the price is undefined provide a price of 99.99.
select title, coalesce(price, 99.99:: money)
from titles;
 
--Find the price of all titles, where the price is undefined provide a price of 99.99.
select title, 
case
	when price is null then money(99.99)
	else price
	end as newprice
from titles;


--Find all of the sales where the store id was greater than 7500
select *
from sales 
where stor_id > '7500';

--Find all the sales between the 1st Jan 1990 and the  3rd Feb 1993
select *
from sales 
where ord_date between '1990-01-01'  and ' 1993-02-03';

--Find the first 25 characters of the notes for each title.
select title, cast (notes as varchar(25))
from titles;

--Find the first 25 characters of the notes for each title. both inclusive
select title, substr (notes, 1, 25), char_length( substr (notes, 1, 25)) 
from titles;

--Find the first 25 characters of the notes for each title.
select title, left(notes, 25)
from titles;

