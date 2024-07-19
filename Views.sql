
--Create a new view called ExpensiveBooks which just shows books whose price is above the average for all books. Remember to include your initials as part of the view name to avoid collisoins with other users' views.
create view pubs2.ExpensiveBooks_byJM
as
select title
from titles
where price > (select avg (price :: numeric):: money from titles);

drop view ExpensiveBooks_byJM

--Create a view that allows the creation of titles (but using the minimum number of columns).
--right click ddl and see columnn not null, not default
create view pubs2.SimplifiedTitle_byJM 
as 
select t.title_id , t.title 
from titles as t 
;
drop view pubs2.simplifiedtitle_byjm 


--Create a view called  WhoWroteWhat which lists authors and their work.
create view pubs2.WhoWroteWhat_byJM
as
select a.au_fname  , a.au_lname , t2.title 
from authors as a left join titleauthor as t 
on a.au_id  = t.au_id 
left join titles as t2 
on t.title_id = t2.title_id ;



--Create a new view which lists just publisher and title details based on the ExpensiveBooks  view you defined earlier.
-- test view--
select *
from  pubs2.ExpensiveBooks_byJM as eb ;


--rename title
alter view pubs2.ExpensiveBooks_byJM 
rename column title to book_name;

select p.pub_name, t.title 
from publishers as p inner join titles as t 
on p.pub_id = t.pub_id
where t.title in (select title from pubs2.ExpensiveBooks_byJM as eb  );

--Which columns in your new view can be updated?
-- the pub_name can only update in a view if involves only one table

--Create a new view which shows the average prices of titles for each type along with a count of the books of that type.
create view pubs2.avgprice_andcountofbook_pertype_byJM
as
select type, avg(price :: numeric)::money as avgpricepertype, count ( title) as countofbookspertype
from titles as t 
where price is not null
group by type
order by avgpricepertype desc;

-- test view ---
select *
from avgprice_andcountofbook_pertype_byjm;

--Use the view to query for the most expensive type of book 
select type
from avgprice_andcountofbook_pertype_byjm 
where avgpricepertype in ( select max ( avgpricepertype) from avgprice_andcountofbook_pertype_byjm );

--Use the view to query  for the most common type of book.
select type
from avgprice_andcountofbook_pertype_byjm 
where countofbookspertype in ( select max ( countofbookspertype) from avgprice_andcountofbook_pertype_byjm );



