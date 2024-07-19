--Add a new publisher and author to the relevant tables in your database. Consider how you can determine the domain and other integrity requirements for the tables in question so that your insertions work on the first attempt.

INSERT INTO pubs2.publishers
(pub_id, pub_name, city, state, country)
VALUES('8120', 'Jojo Books', 'Dar-es-salaam', '  ', 'Tanzania'::character varying);
;

select *
from publishers as p 

INSERT INTO pubs2.authors
(au_id, au_lname, au_fname, phone, address, city, state, zip, contract)
('509-56-7008', 'Smith', 'Ewan', 'UNKNOWN', 'Scouse Road', 'Warrington', 'EN', '22399', 2);


select *
from authors as a ;


--Increase the price of all books written by Californian authors by 10%.

--drop view pubs2.californianauthorsandbooks
;


create view pubs2.californianauthorsandbooks
as
select t.title_id, t.title , a.au_id , a.au_fname , a.au_lname 
from titles as t inner join titleauthor as t2
on t.title_id = t2.title_id 
inner join authors as a 
on t2.au_id = a.au_id 
where a.state = 'CA'
;

--- cannnot update the view when has multiple joins but can use to search through
update titles  
set price = price + 0.1*price
where title_id in (select title_id from pubs2.californianauthorsandbooks);
;

--Explore the use of the merge statement. Use it to update/insert 
--author information based on a query that returns new and
-- existing authors (consider a union) between a select on the
-- authors table and the valuesclause.
--so this is source code

SELECT au_id, au_lname, au_fname, phone, address, city, state, zip, contract + 1 as contract
FROM pubs2.authors
union all
VALUES('000-07-0007', 'Bond', 'James', 'UNKNOWN', 'Whitehall', 'London', 'EN', '99999', 2)
union all
VALUES('222-07-0007', 'Smith', 'Ewan', 'UNKNOWN', 'Scouse Road', 'Warrington', 'EN', '22399', 2)
;


--then merge
MERGE INTO pubs2.authors AS tgt
USING (SELECT au_id, au_lname, au_fname, phone, address, city, state, zip, contract + 1 as contract
		FROM pubs2.authors
		union all
		VALUES('000-07-0007', 'Bond', 'James', 'UNKNOWN', 'Whitehall', 'London', 'EN', '99999', 2)
		union all
		VALUES('222-07-0007', 'Smith', 'Ewan', 'UNKNOWN', 'Scouse Road', 'Warrington', 'EN', '22399', 2)
) AS src
ON (tgt.au_id=src.au_id)
WHEN MATCHED
THEN UPDATE set
	au_lname=src.au_lname,
	au_fname=src.au_fname, 
	phone=src.phone, 
	address=src.address,
	city=src.city, 
	state=src.state, 
	zip=src.zip, 
	contract=src.contract
WHEN NOT MATCHED
THEN INSERT (au_id, au_lname, au_fname, phone, address, city, state, zip, contract)
VALUES (src.au_id, src.au_lname, src.au_fname, src.phone, src.address, src.city, src.state, src.zip, src.contract);


-- check if merged worked
select *
from authors as a 