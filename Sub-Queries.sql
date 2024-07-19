 	--Which publishers have published at least one book?
select p.pub_id , pub_name , count(t.title) as countofbooks
from publishers as p inner join titles as t 
on p.pub_id = t.pub_id 
group by p.pub_id 
having count(t.title) >=1 ;


--Which authors have been published by more than one publisher?
select  a.au_id , a.au_fname , a.au_lname , count (a.au_id)
from authors as a inner join titleauthor as t 
on a.au_id = t.au_id 
inner join titles as t2 
on t.title_id  = t2.title_id 
inner join publishers as p 
on t2.pub_id = p.pub_id 
group by  a.au_id , a.au_fname , a.au_lname
having count (a.au_id) > 1;

--Which authors live in a city where a publisher exists?
select a.au_id , a.au_fname , a.au_lname 
from authors as a
where city in (select city 
				from publishers as p);
			
select a.au_fname  || ' ' || a.au_lname as name
from authors a 
where city in (select city
from publishers);

select a.au_fname  || ' ' || a.au_lname as name
from authors a 
where exists (select 1 city from publishers as p where a.city = p.city);

select a.au_fname  || ' ' || a.au_lname as name
from authors a inner join publishers as p
on a.city = p.city ;

--How many authors are there with the same first initial?
select left(a.au_fname, 1),
	(select count(*) -1
	from authors as other
	where left(other.au_fname, 1) = left(a.au_fname, 1)
	) as qty
from authors as a
group by left(au_fname, 1), qty;
			

--What is the most expensive book?
select title, price
from titles as t 
where price in (select max (price)
from titles as t );

--Which is the oldest published book? Which is the youngest?
select title
from titles as t 
where pubdate in (select min(pubdate) as oldest
from titles );

--Which is the youngest?
select title
from titles as t 
where pubdate in (select max(pubdate) as youngest
from titles );

--Which books are more expensive than all books of any other type? book where type not the same book
select title
from titles as t 
where price > all (
		select price
		from titles as t2 
		where t."type" <> t2.type 
		and price is not null
		);

select title
from titles as t 
where price > (
		select max(price)
		from titles as t2 
		where t."type" <> t2.type 
		);

	select title
	from titles as t 
	where price >
	(select max (price)from titles as t2
	where t."type" <> t2.type);

--Which books have an above average price for their type?
select t.title , t.price 
from titles as t 
where price > (
	select avg(price :: numeric):: money
	from titles as t2
	where t."type" = t2."type"
);


--How much above or below the "average price of all books" is the price for each book?
select title, price, price -(select avg ( price :: numeric):: money as pricediff
from titles as t )
from titles as t ;

