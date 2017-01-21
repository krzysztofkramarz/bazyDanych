use Northwind
--1. Wyświetlanie tylko pierwszych n wierszy zbioru wynikowego.
-- fraza WITH TIES powoduje, że zwracane są dodatkowo wszystkie elementy o wartościach takich jak element ostatni
select top 5 with ties orderid, productid, quantity from [order details] order by 3 

--2. Policz średnią cenę jednostkową dla wszystkich produktów w tabeli products:
select avg(unitprice) from products;
--3. Zsumuj wszystkie wartości w kolumnie quantity w tabeli order details:
select sum(quantity) from [order details]
-- 4. Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$
select sum(productid) from products where unitprice < 10 or unitprice > 20
-- 5. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$
select max(unitprice) from products where unitprice < 20

--6. Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottle’)
select max(unitprice), min (unitprice), avg(unitprice) from products where  QuantityPerUnit like '%bottle%'

---!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--7. Wypisz informację o wszystkich produktach o cenie powyżej średniej
select productid, unitprice from products where unitprice > (select avg(unitprice) from products)



-- 8. Podaj sumę/wartość zamówienia o numerze 10250
select sum(unitprice*quantity) from [order details]
Go