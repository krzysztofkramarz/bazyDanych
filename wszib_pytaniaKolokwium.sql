-- zad 1
use library
select firstname, lastname, juvenile.birth_date
from member
inner join juvenile on juvenile.member_no = member.member_no

-- zad 2
use library
select distinct title, author 
from title
inner join loan on loan.title_no = title.title_no

-- zad 4
use library
select distinct item.isbn 
from item
inner join reservation on reservation.isbn = item.isbn



/*select isbn from item 
select * from reservation

select * from member

select * from juvenile order by member_no

select * from loan where title_no = 1
select * from title where title_no = 1 */