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

-- 11. Napisz polecenie, które zwraca informacje o zamówieniach z tablicy order details. Zapytanie ma grupować
-- i wyświetlać identyfikator każdego produktu a następnie obliczać ogólną zamówioną ilość. 
-- Ogólna ilość jest sumowana funkcją agregującą SUM i wyświetlana jako jedna wartość dla każdego produktu.
SELECT ProductId, SUM(Quantity) FROM "Order Details" GROUP BY ProductId order by 1

-- 12. Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
SELECT OrderId, MAX(UnitPrice) as 'cena'  FROM "Order Details" GROUP BY OrderId 

-- 13. Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderId, MAX(UnitPrice) as 'cena'  FROM "Order Details" GROUP BY OrderId order by 2 DESC

-- 14. Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
SELECT MAX(UnitPrice), MIN(UnitPrice), OrderId FROM "Order Details" GROUP BY OrderId

-- 15.  Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
SELECT ShipVia AS 'nuumer spedytora', COUNT(*) FROM  Orders GROUP BY ShipVia

 -- 16. . Który z spedytorów był najaktywniejszy w 1997 roku
SELECT ShipVia, COUNT(*) FROM Orders WHERE YEAR(ShippedDate) = 1997   GROUP BY ShipVia -- albo DATEPART(year, ShippedDate) = 1997 

-- NIE DZIAŁA... SELECT ShipVia, MAX(SELECT COUNT(OrderDate) FROM Orders WHERE YEAR(ShippedDate) = 1997 GROUP BY ShipVia) FROM Orders GROUP BY ShipVia 

-- 17. Wyświetl listę identyfikatorów produktów i ilość dla tych produktów, których zamówiono ponad 1200 jednostek
SELECT ProductId, SUM(Quantity) FROM "Order Details" GROUP BY ProductId HAVING SUM(Quantity) > 1200


-- 18. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
SELECT OrderId, Count(*) AS 'ilosc' FROM "Order Details" GROUP BY OrderId HAVING Count(*) > 5

-- 19. Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień 
--(wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
SELECT CustomerId, COUNT(*), SUM(Freight) as 'lacznaKwowa'  FROM Orders WHERE DATEPART(yyyy,ShippedDate ) = 1998 GROUP BY CustomerId  HAVING  COUNT(*) > 8 ORDER BY 3 DESC 
--lub ORDER BY 'lacznaKwota' lub --  ORDER BY SUM(Freight)

-- moje: pokaż ile maksymalnie dziennie było wysyłek dla poszczególnych klientów w 1008
SELECT CustomerId, COUNT(*),ShippedDate  FROM Orders WHERE DATEPART(yyyy,ShippedDate ) = 1998 GROUP BY CustomerId, ShippedDate  HAVING  COUNT(*) > 0 
 
 




SELECT ProductID, SUM(UnitPrice*Quantity*(1-Discount)) FROM "Order Details" GROUP BY ProductID
--wersja z nazwą produktu 
SELECT od.ProductID, SUM(od.UnitPrice*od.Quantity*(1-od.Discount)), ProductName FROM "Order Details" AS od JOIN Products AS p 
ON od.ProductId = p.ProductId GROUP BY od.ProductID, ProductName




GO