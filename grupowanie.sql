use Northwind





-- 9 Napisz polecenie, które zwraca informacje o zamówieniach z tablicy order
--details. Zapytanie ma grupować i wyświetlać identyfikator każdego
--produktu a następnie obliczać ogólną zamówioną ilość. Ogólna ilość jest
--sumowana funkcją agregującą SUM i wyświetlana jako jedna wartość dla każdego produktu.
select productid , sum(quantity) from [order details] group by productid order by 1



-- 10 . Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia

select max(unitprice)as 'cena' , orderid from [order details] group by orderid 

select max(unitprice)as 'cena' , orderid from [order details] group by orderid order by 2
select OrderId, max(UnitPrice)
from [Order Details]
group by OrderID


select *
from [Order Details]
where OrderID = 10254


-- 11 Posortuj zamówienia wg maksymalnej ceny produktu
select max(unitprice)as 'cena' , orderid from [order details] group by  orderid order by max(unitprice) desc


select OrderId, MAX(UnitPrice)
from "Order Details"
group by OrderID
order by MAX(UnitPrice) DESC


--12 Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
select orderid, max(unitprice) 

select OrderId, MAX(UnitPrice) as 'max price', MIN(UnitPrice) as 'min price'
from [Order Details]
group by OrderID


--13 Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźnik 
select shipvia, count(*) as 'nuumer spedytora' from orders group by shipvia 
--14 Który z spedytorów był najaktywniejszy w 1997 roku
select shipvia, count(*) as ile_przesylek from orders where datepart(year, shippeddate) = 1997 group by shipvia
order by ile_przesylek DESC


select shipvia, count(*) as ile_przesylek
from orders
where DATEPART(year, ShippedDate) = 1997 group by Shipvia
order by ile_przesylek desc

-- 15 Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
select orderid, count(*)  from [order details] group by orderid having count(*) > 5

select orderid, count (*) as 'ilosc'
from [Order Details]
group by orderid
having count (*) > 5

--  16 Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień 
-- (wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
select customerid, sum(freight) as laczna_kwota from orders where year(shippeddate) = 1998 group by customerid having count(*) > 8 order by laczna_kwota desc

select customerid, sum(Freight) as laczna_kwota_za_przesylke
from orders
where year (ShippedDate) = 1998
group by customerid
having count (*) > 8
order by laczna_kwota_za_przesylke desc
--lub-- order by sum(freight) desc


Go