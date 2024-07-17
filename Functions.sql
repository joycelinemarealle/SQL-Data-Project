
--Display the current date.
select current_date ;

--Display the current time.
select cast(current_timestamp as time) ;

--Find the title, publication year and publication day of all titles. Sort in descending order by year then ascending order by day.
select
	title,
	cast (extract (year from pubdate) as char(4) )as pub year,
	extract(day from pubdate) as pub day 
from titles
order by 
	year desc, 
	day asc;

--Convert '2022-09-29' to a date and then to a timestamp.
select cast( date ('2022-09-29') as timestamp);

--Get the current timestamp.
select current_timestamp;

--From the titles table select the- title -number of days since a title was published as an integer -order by the number of days since a title was published.
select title, cast((current_date - pubdate) as numeric) as daydiff
from titles 
order by daydiff;

--Show the number of days to Christmas,
select cast((cast ('2024-12-25' as date) - current_date ) as numeric)

--Show the number of days to Christmas,new year, thanksgiving
select 
date('2024-12-25') - current_date as "Days to Christmas"
date('2024-11-28')- current_date as "Days to Thanksgiving"
date('2025-01-01') - current_date as "Days to New Year";


--For all titles calculate the revenue so far this year rounded down to the nearest integer.
select title, ytd_sales *price as revenue, floor(ytd_sales*price :: numeric) as roundedrevenue
from titles;

--Find all authors first and last names, convert the last names to uppercase and the first names to lowercase.
select lower(au_fname) , upper(au_lname )
from authors;

--For all author's first names shift every letter along by 1. eg a -> b, b -> c ... z -> 
select 
	translate (au_fname, 'abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ', 'bcdefghijklmnopqrstuvwxyzaBCDEFGHIJKLMNOPQRSTUVWXYZA'  )
from authors;

--Show the first word of each title.
select title, (string_to_array(title, ' '))[1] as "First Word in Title"
from titles ;

select title, left(title, position (' ' in title)- 1) as "First Word"
from titles;

select title, substring(title, 1,position(' '  in title) -1 )as "First word"
from titles ;

--Study the reference documents for Postgres and then display each book title with its publication date converted to the correct format for each of the following regions:
	--USA
select title, to_char(pubdate, 'MM-DD-YYYY') as "USA Time"
from titles ;

	--UK
select title, to_char(pubdate, 'DD-MM-YYYY') as "UK Time"
from titles ;

	--Japan
select title, to_char(pubdate, 'YYYY-MM-DD') as "Japan Time"
from titles ;

--Print the number of characters which could be added to each of the values in the title field before the data is truncated. You can find the title column's length using the system commands for your DBMS.
select title, 80 - length(title) as "Number of characters that can be added "
from titles;



-- info schema
select *
from information_schema.tables;

-- columns of schema
select character_maximum_length 
from information_schema.columns
where table_catalog = 'postgres'
and table_schema = 'pubs2'
and table_name = 'titles'
and column_name = 'title';

--Replace the first space in the address field in the authors table with the word -hello-
select address,
left(address, position (' ' in address)-1)

from authors;

--Provide a randomly generated price for all titles lacking a price in the titles table. (math functions)

--Print all phone numbers from the authors table without the three digit area code.

--Capitalise the second character in all last names from the authors table.