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
SELECT ProductName, UnitPrice, CompanyName, Address+' '+City+' '+PostalCode+' '+Country AS Adres FROM Products AS p 
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

GO

