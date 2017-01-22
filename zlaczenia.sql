use joindb

select sales.buyer_id, buyer_name, produce.prod_name, qty from sales, buyers, produce where sales.buyer_id= buyers.buyer_id and produce.prod_id=sales.prod_id order by 1

select buyer_name, s.buyer_id, qty from sales as s  inner join buyers as b on s.buyer_id = b.buyer_id order by 1


SELECT buyer_name, s.buyer_id, qty FROM buyers AS b INNER JOIN sales AS s  ON b.buyer_id = s.buyer_id order by 1

SELECT buyer_name, s.*, qty FROM buyers AS b , sales AS s  where buyer_name= 'Adam Barr'order by 1
GO


use Northwind

-- 1. Napisz polecenie zwracające nazwy produktów i firmy je dostarczające (baza northwind)
-- tak aby produkty bez „dostarczycieli” i „dostarczyciele” bez produktów nie pojawiali się w wyniku.
SELECT ProductName, CompanyName FROM Suppliers as s INNER JOIN Products as p ON s.SupplierId = p.SupplierId

-- 2. Napisz polecenie zwracające jako wynik nazwy klientów, którzy złożyli zamówienia po 01 marca 1998 (baza northwind)
SELECT CompanyName, OrderDate FROM Customers AS c INNER JOIN Orders AS o ON o.CustomerId = c.CustomerId 
WHERE OrderDate > '3/1/98'
-- lub ( (YEAR(Orders.OrderDate) = 1998 AND MONTH(Orders.OrderDate) > 2) OR YEAR(Orders.OrderDate) > 1998 )

-- 3. Napisz polecenie zwracające wszystkich klientów z datami zamówień 
SELECT CompanyName, OrderDate, c.CustomerId,  o.CustomerId  FROM Customers AS c INNER JOIN Orders AS o ON o.CustomerId = c.CustomerId 

-- 4. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). 
-- Interesuje nas imię, nazwisko i data urodzenia dziecka. oraz moje: obecny wiek
Use Library
SELECT FirstName, Birth_Date , DATEDIFF(YY, Birth_Date, CURRENT_TIMESTAMP) FROM Member as m JOIN Juvenile as j  ON m.Member_no = j.Member_no

-- 5. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki. Interesuje nas imię, nazwisko,
-- data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.
select mj.firstname as FirstName, mj.lastname as LastName, birth_date, city, street, state,
ma.firstname as AdultFirstName, ma.lastname as AdultLastName 
from juvenile
join member as mj on juvenile.member_no = mj.member_no
join adult on adult.member_no = juvenile.adult_member_no
join member as ma on ma.member_no = adult.member_no


-- 6. Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek
SELECT DISTINCT t.title FROM Title AS t 
JOIN Loan AS l ON t.title_no = l.title_no




Go
