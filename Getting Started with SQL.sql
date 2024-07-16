---
--
--SECTION 1
--
-- select all of the columns from the authors table.
select *
from authors;

--select the publishers name, city and country from the publishers table.
select pub_name, city, state, country
from publishers;

--select the title and advance divided by 1000 of a title. Name the first column 'Title' and the second 'Advance in Thousands'.
select 
	title as "Title",
	advance/1000 as "Advance in Thousands"
from titles;

--select all of the columns from the sales table ordered by the quantity.
select *
from sales
order by qty desc 

--now reverse the sort order.
select *
from sales
order by qty; 

--order by the store id in reverse order and qantity in reverse order
select *
from sales 
order by stor_id desc, qty desc;

--select the order numbers from the sales table ordered by the quantiy in reverse order.
select *
from sales 
order by qty desc;

--select the title and advance divided by the price. Order by the advance divided by the price.
select title, advance / price as "Advance Per Price"
from titles
order by "Advance Per Price"

---
--
--SECTION 2
--
-- 

select * 
from authors
where city = 'Oakland';

--at least 1 contract.
select au_lname 
from authors 
where contract >=1;

--select (from the authors table) the last name of all the authors with
----1 contract and live in the state of California (CA).
select au_lname 
from authors 
where contract = 1 and state = 'CA';

--0 contracts and not from the state of California (CA)
select au_lname 
from authors 
where contract = 0 and state <> 'CA';

--select (from the authors table) the last name of all the authors with 1 contract from the zip code 84152 or any number of contracts from zip code 94609.
select au_lname 
from authors
where (contract = 1 and zip = '84152')
or zip = '94609';

-- select the title (from the titles table) of any title where the value of the sales (quantity sold multiplied by price) is less than the advance.
select title,ytd_sales *price as "Value of Sales", advance 
from titles 
where ytd_sales * price < advance ;

--select all columns for titles whose sales were between 3500 and 4500.
select *
from titles  
where ytd_sales between 3500 and 4500;

--select all columns for titles whose publication date is not between 1994/05/12 ane 1995/06/12.
select *
from titles
where pubdate not between '1994-05-12' and '1995-06-12';


--select the title from for titles whose type is either business or psychology
select title 
from titles 
where type in ('business', 'psychology');
--select the publisher name from the publishers where the city is not Boston, New York or Berkeley.
select pub_name 
from publishers 
where city not in ('Boston', 'New York', 'Berkeley');

---
--
--SECTION 3
--
-- 

--select the first name of all authors whose name begins with A.
select au_fname 
from authors 
where au_fname like 'A%';

--or using similar to
select au_fname 
from authors 
where au_fname similar to '[Aa]%'

--select the first and last name of all authors whose phone does not begin with 415.
select au_fname, au_lname 
from authors 
where phone similar to '[^415]%';

--select all columns for authors whose phone number does not begin with 415 and whose first name begins with M.
select *
from authors 
where phone similar to '[^415]%'
and au_fname similar to '[M]%';

--select the first name of all authors who have a 4 character first name eg Jack
select au_fname 
from authors 
where au_fname like '____';

--select all columns from the titles table where the notes contain the word search with an upper or lowercase s
select *
from titles 
where notes similar to '%[Ss]earch%'

--select the title id and title from the titles table where the title id does not start with a letter in the range A to P ordered by title id.
select title_id , title
from titles  
where title_id similar to '[^A-P]%'
order by title_id ;

--select the title, price and a column called Category that should contain 'A' for titles with a price of less 10 and 'B' for titles with a price of 10 or more
select
	title,
	price, 
	case 
		when price < 10 :: money then 'A, price < 10'
		else 'B, price > 10 '
		end as "Category"
	
from titles ;

--select a distinct list of cities from the authors table.
select distinct city 
from authors 

--select the largest 5 non null advances from the titles table

select advance
from titles  
where advance is not  NULL
order by advance desc 
--limit 5
fetch first 5 rows only;

--
-- SECTION CHALLENGE
--Select the title and a column called 'value' (that is the price of a title multiplied by sales of the title this year) for all titles where:
--the advance was between 3000 and  5000 OR the sales were greater than 15000 AND the type of title does not contain the word 'cook'Only return the 5 rows with the largest value

select title , ytd_sales *price as value 
from titles 
where ((advance:: numeric between 3000 and 5000) or ytd_sales > 15000) 
and "type"  similar to '%[^Ccook]%'
order by value desc 
limit 5;

select title , ytd_sales *price as value 
from titles 
where ((advance:: numeric between 3000 and 5000) or ytd_sales > 15000) 
and "type"  similar to '%[^Ccook]%'
order by 2 desc 
limit 5;