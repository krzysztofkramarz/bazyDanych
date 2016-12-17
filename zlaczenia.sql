use joindb

select sales.buyer_id, buyer_name, produce.prod_name, qty from sales, buyers, produce where sales.buyer_id= buyers.buyer_id and produce.prod_id=sales.prod_id order by 1

select buyer_name, s.buyer_id, qty from sales as s  inner join buyers as b on s.buyer_id = b.buyer_id order by 1


SELECT buyer_name, s.buyer_id, qty FROM buyers AS b INNER JOIN sales AS s  ON b.buyer_id = s.buyer_id order by 1

SELECT buyer_name, s.*, qty FROM buyers AS b , sales AS s  where buyer_name= 'Adam Barr'order by 1
GO

use Northwind
--5 Napisz polecenie zwracające nazwy produktów i firmy je dostarczające (baza northwind) 
-- tak aby produkty bez „dostarczycieli” i „dostarczyciele” bez produktów nie pojawiali się w wyniku.
select companyname, productname from suppliers as s inner join products as p on s.supplierid = p.supplierid 
--6  Napisz polecenie zwracające jako wynik nazwy klientów, którzy złożyli zamówienia po 01 marca 1998 (baza northwind)
select companyname, orderdate from orders inner join customers on orders.customerid = customers.customerid 
where  orderdate > '3/1/98'
go