use Northwind
--1. Wyświetlanie tylko pierwszych n wierszy zbioru wynikowego.
-- fraza WITH TIES powoduje, że zwracane są dodatkowo wszystkie elementy o wartościach takich jak element ostatni
SELECT TOP  5 WITH TIES orderid, productid, quantity FROM [order details] order by 3 

--2. zlicz wszystkie wiersze w tabeli employees, razem z NULL w jakimkolwiek wierszu
SELECT COUNT (*)FROM employees

--3. zlicz wszystkie wiersze , gdzie nie ma NULL w kolumnie Region
SELECT COUNT(region) FROM employees

--4. Policz średnią cenę jednostkową dla wszystkich produktów w tabeli products:
select  AVG(UnitPrice) FROM Products

--5. Zsumuj wszystkie wartości w kolumnie quantity w tabeli order details:
SELECT SUM(Quantity) FROM "Order Details" -- (lub [Order Details])

-- 6. Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$
SELECT COUNT(ProductName) AS 'Produkty' FROM Products --WHERE UnitPrice > 20 OR UnitPrice < 10

-- 7. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$
SELECT MAX(UnitPrice) FROM Products WHERE UnitPrice < 20


--8. Podaj maksymalną i minimalną i średnią cenę produktu dla produktów 
--o produktach sprzedawanych w butelkach (‘bottle’)
SELECT AVG(UnitPrice) AS 'Średnia', MAX(UnitPrice), MIN(UnitPrice) FROM Products WHERE "QuantityPerUnit" LIKE '%bottle%'

---!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- 9. Wypisz informację o wszystkich produktach o cenie powyżej średniej
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products) ORDER BY 2 ASC

-- 10. Podaj sumę/wartość zamówienia o numerze 10250
SELECT SUM(UnitPrice * Quantity) FROM [Order Details] WHERE OrderID = 10250 
zzz
GO