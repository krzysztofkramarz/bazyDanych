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


-- 7. Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’. Interesuje nas data oddania książki, ile dni
-- była przetrzymywana i jaką zapłacono karę 

select fine_paid, title, firstname, lh.member_no, l.member_no, m.member_no, lh.due_date, lh.in_date, datediff(dd, lh.due_date, lh.in_date) as przetrzymywana_dni from loanhist AS lh --in_date może pomyliłem na odwrót
JOIN title AS t ON lh.title_no = t.title_no 
JOIN loan AS l ON t.title_no = l.title_no
JOIN member AS m ON l.member_no = m.member_no
WHERE title = 'Tao Teh King' order by 7 desc

select title, due_date, in_date, fine_assessed, fine_paid, datediff(d,in_date,due_date) as przetrzymywana_dni
from loanhist join title on loanhist.title_no = title.title_no
where title like 'Tao Teh King' and in_date < due_date
order by fine_paid desc

-- 8. Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff
SELECT r.isbn,  i.title_no, title, '   --->',  lastname, log_date FROM reservation AS r 
JOIN Member AS m ON r.member_no = m.member_no
JOIN Item AS i ON r.isbn = i.isbn
JOIN Title AS t ON i.title_no = t.title_no
WHERE m.firstname like 'Stephen' and m.middleinitial like 'A' AND LastName =  'Graff' 


Go



-- 9. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj
-- dane adresowe dostawcy
use Northwind 
SELECT LEN(ProductName), UnitPrice, SUBSTRING(CompanyName,1,3), Address+' '+UPPER(City)+' '+PostalCode+' '+LOWER(Country) AS Adres FROM Products AS p 
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE UnitPrice BETWEEN 20.00 AND 30.00
-- a tutaj udąło mi się w końcu zliczyć ilość wyników . Nie może być ORDER BY w takim podzapytaniu
SELECT COUNT(*) FROM (SELECT ProductName, UnitPrice, CompanyName, Address+' '+City+' '+PostalCode+' '+Country AS Adres FROM Products AS p 
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE UnitPrice BETWEEN 20.00 AND 30.00 ) AS baza 

-- 10. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
SELECT ProductName, UnitsInStock, CompanyName FROM PRoducts AS p 
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE CompanyName = 'Tokyo Traders'

-- 11. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
SELECT CompanyName, Address+ '  ' + City+Region AS Adresik, OrderDate FROM Customers AS c 
JOIN Orders AS o ON o.customerID = c.CustomerID
WHERE YEAR(OrderDate) != 1997

-- 12. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie ma w magazynie
SELECT CompanyName, Phone, UnitsInStock FROM Products AS p 
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE UnitsInStock = 0

-- 13. złączenia kartezjańskie - dwie składnie
SELECT CompanyName, ProductName FROM Products AS p, Suppliers AS s WHERE UnitsInStock = 0
SELECT CompanyName, ProductName FROM Products AS p CROSS JOIN  Suppliers AS s WHERE UnitsInStock = 0

-- 14. Napisz polecenie, wyświetlające CROSS JOIN między shippers i suppliers. użyteczne dla listowania wszystkich możliwych
--sposobów w jaki dostawcy mogą dostarczać swoje produkty
SELECT suppliers.companyname, shippers.companyname
FROM suppliers
CROSS JOIN shippers

-- 15. Napisz polecenie zwracające listę produktów zamawianych w dniu 1996-07-08.
SELECT ProductName, OrderDate FROM Products AS p 
JOIN [Order Details] AS od ON od.productid = p.productid
JOIN Orders AS o ON o.OrderId = od.OrderId
WHERE OrderDate = '07/08/1996'

-- 16. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj
-- dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
SELECT ProductName,  CategoryName, UnitPrice, CompanyName , Address FROM Products AS p 
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
JOIN Categories AS c ON p.CategoryId = c.CategoryId
WHERE (UnitPrice BETWEEN 20.00 AND 30.00) AND CategoryName = 'Meat/Poultry'

-- 17. Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
SELECT ProductName , CategoryName,  p.UnitPrice, od.UnitPrice, CompanyName FROM Products AS p
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
JOIN [Order Details] AS od ON od.productid = p.productid
JOIN Categories AS c ON p.CategoryId = c.CategoryId
WHERE CategoryName = 'Confections'


-- 18. Wybierz nazwy i numery telefonów klientów , którzy w 1997 roku kupowali towary firmy 'Ma Maison'
SELECT DISTINCT c.CompanyName AS klient, c.Phone AS telefon, DATEPART(yy, o.OrderDate), s.CompanyName AS dostawca  FROM Customers AS c 
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN "Order Details" AS od ON od.OrderID = o.OrderID
JOIN Products AS p ON p.ProductID = od.ProductID
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE DATEPART(yyyy, o.OrderDate) = 1997 AND s.CompanyName = 'Ma Maison' Order BY c.CompanyName DESC

--- A JAK POLICZYĆ?????????????????????
-- ????????????????????????????
SELECT COUNT(*) FROM (SELECT DISTINCT c.CompanyName AS klient, c.Phone AS telefon, DATEPART(yy, o.OrderDate), s.CompanyName AS dostawca  FROM Customers AS c 
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN "Order Details" AS od ON od.OrderID = o.OrderID
JOIN Products AS p ON p.ProductID = od.ProductID
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE DATEPART(yyyy, o.OrderDate) = 1997 AND s.CompanyName = 'Ma Maison')  t 

SELECT COUNT(*) FROM Suppliers WHERE ContactTitle = 'Marketing Manager'

SELECT COUNT(ContactTitle), ContactTitle FROM Suppliers s GROUP BY ContactTitle


-- 18. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma ‘United Package’
SELECT DISTINCT Customers.CompanyName, Customers.Phone
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN Shippers ON Shippers.ShipperID = Orders.ShipVia
WHERE YEAR(Orders.OrderDate) = 1997 AND Shippers.CompanyName LIKE 'United Package'


-- 19. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii ‘Confections’
SELECT DISTINCT c.CompanyName AS klient, c.Phone AS telefon,cat.CategoryName  FROM Customers AS c 
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN "Order Details" AS od ON od.OrderID = o.OrderID
JOIN Products AS p ON p.ProductID = od.ProductID
JOIN Categories AS cat ON cat.CategoryID = p.CategoryID 
WHERE cat.CategoryName  = 'Confections' 

-- 20. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library).
-- Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka. 
use library


SELECT lastname, firstname, a.street, j.member_no FROM member AS m 
JOIN adult AS a ON a.member_no = m.member_no 
JOIN Juvenile AS j ON m.member_no = j.adult_member_no WHERE m.lastname = 'Anderson' ORDER BY 2

-- jak wyzżej z nazwiskami rodziców
SELECT m.lastname AS nazwisko_dziecka , m.firstname AS imie_dziecka, a.street, j.birth_date, j.member_no, r.lastname AS naz_rodz , r.firstname AS im_rodz, r.member_no FROM member  AS m 
JOIN Juvenile AS j ON m.member_no = j.member_no
JOIN adult AS a ON a.member_no = j.adult_member_no
JOIN Member AS r ON a.member_no = r.member_no
WHERE m.lastname = 'Anderson' ORDER BY 2

Go
-- 21. Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek oraz nazwę klienta.
use Northwind
SELECT count(*), od.OrderID, SUM(od.Quantity), c.CompanyName FROM [Order details] AS od
JOIN Orders AS o ON od.OrderID = o.OrderID 
JOIN Customers AS c ON c.CustomerID = o.CustomerID
GROUP BY od.OrderId , c.CompanyName

-- 22. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, 
--dla których łączna liczbę zamówionych jednostek jest większa niż 250
SELECT count(*), od.OrderID, SUM(od.Quantity) AS suma, c.CompanyName FROM [Order details] AS od
JOIN Orders AS o ON od.OrderID = o.OrderID 
JOIN Customers AS c ON c.CustomerID = o.CustomerID
GROUP BY od.OrderId , c.CompanyName HAVING SUM(od.Quantity) > 250 ORDER BY 3 desc

-- 23. Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę klienta.
SELECT od.OrderId as zamowienie, ROUND(SUM(Quantity*UnitPrice*(1-Discount)),3) as suma_zamowienia, c.CompanyName FROM [Order details] AS od
JOIN Orders AS o ON od.OrderID = o.OrderID 
JOIN Customers AS c ON c.CustomerID = o.CustomerID
GROUP BY od.OrderId , c.CompanyName

-- 24. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia,
-- dla których łączna liczba jednostek jest większa niż 250.
SELECT od.OrderId as zamowienie, ROUND(SUM(Quantity*UnitPrice*(1-Discount)),3) as suma_zamowienia, c.CompanyName FROM [Order details] AS od
JOIN Orders AS o ON od.OrderID = o.OrderID 
JOIN Customers AS c ON c.CustomerID = o.CustomerID
GROUP BY od.OrderId , c.CompanyName HAVING ROUND(SUM(Quantity*UnitPrice*(1-Discount)),3)  > 250

-- 25. Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i nazwisko pracownika obsługującego zamówienie
SELECT od.OrderId as zamowienie, ROUND(SUM(Quantity*UnitPrice*(1-Discount)),3) as suma_zamowienia, 
c.CompanyName, e.LastName +' ' + e. firstName as Pracownik FROM [Order details] AS od
JOIN Orders AS o ON od.OrderID = o.OrderID 
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Employees AS e ON e.EmployeeID = o.EmployeeID
GROUP BY od.OrderId , c.CompanyName,  e.LastName +' ' + e. firstName
HAVING ROUND(SUM(Quantity*UnitPrice*(1-Discount)),3)  > 250
 
-- 26. Dla każdej kategorii produktu (nazwa), podaj łączną liczbę
-- zamówionych przez klientów jednostek towarów.
use Northwind 
SELECT c.CategoryName,  SUM(od.Quantity)  FROM Categories AS c 
JOIN Products AS p ON c.CategoryID = p.CategoryID
JOIN "Order Details" AS od ON od.ProductID = p.ProductID
GROUP BY c.CategoryID, c.categoryName

-- 27  Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówień
SELECT c.CategoryName, ROUND(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)),3)  FROM Categories AS c 
JOIN Products AS p ON c.CategoryID = p.CategoryID
JOIN "Order Details" AS od ON od.ProductID = p.ProductID
GROUP BY c.CategoryID, c.categoryName

-- 28   Posortuj wyniki w zapytaniu z punktu 2.2 wg:
--a) łącznej wartości zamówień
--b) łącznej liczby zamówionych przez klientów jednostek towarów


SELECT * FROM Orders

GO
