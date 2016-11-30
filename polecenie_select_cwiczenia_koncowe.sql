use library
--1. Napisz polecenie select, za pomocą którego uzyskasz tytuł i numer książki
select title as "tytul", title_no from title
--2. Napisz polecenie, które wybiera tytuł o numerze 10
select title, title_no from title where title_no = '10'
--3. Napisz polecenie, które wybiera numer czytelnika 
--i karę dla tych czytelników, którzy mają kary między $8.00 a $9.00 (z tablicy loanhist)
select member_no, fine_assessed from loanhist where fine_assessed between 8 and 9
--4 Napisz polecenie select, za pomocą którego uzyskasz numer
--książki i autora z tablicy title dla wszystkich książek, których autorem jest Charles Dickens lub Jane Austen
select author, title_no from title where author in('Charles Dickens', 'Jane Austen')
--5 Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich
--rekordów zawierających string „adventures” gdzieś w tytule.
select title_no, title from title where title like '%adventures%'
--6 Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę
select member_no, fine_paid from loanhist order by 2 desc
--7 Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.
select distinct state, city from adult
--8 Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.
select title from title order by 1 asc
--9 Napisz polecenie, które:
--wybiera numer członka biblioteki (member_no), isbn książki (isbn) i watrość naliczonej kary (fine_assessed) 
--z tablicy loanhist dla wszystkich wypożyczeń dla których naliczono karę (wartość nie NULL w kolumnie fine_assessed)
select member_no, isbn, fine_assessed from loanhist where fine_assessed is not null
-- stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny fine_assessed
select fine_assessed*2 as ‘double fine’  from loanhist where fine_assessed is not null
--  stwórz alias ‘double fine’ dla tej kolumny 



GO