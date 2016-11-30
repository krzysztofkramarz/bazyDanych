USE northwind
--KOLUMNY*************************
--1. Wybierz nazwy i adresy wszystkich klientów
-- isnull odpowiednik nvl w oracle,  top x jest jak rownum<=x w oracle
select  distinct TOP 8 'KLIENT:', companyname as "NAZWA KLIENTA", 
address as adres, city, isnull(region,'BRAK') as MIASTO from customers order by 2 desc


--2. Wybierz nazwiska i numery telefonów pracowników,
select lastname as "Nazwisko", homephone from employees order by 1,2 desc


--3. Wybierz nazwy i ceny produktów
select productname as 'Produkty', unitprice as 'za ile'  from products
--4. Pokaż wszystkie kategorie produktów (nazwy i opisy)
select categoryname, description from categories  
--5. Pokaż nazwy i adresy stron www dostawców
select companyname, isnull(homepage, 'Brak Strony') from suppliers


--WIERSZE****************************************
--***********************************************
--***********************************************
--6. Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie
select companyname, address, city from customers where city like 'london'
--7. Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub w Hiszpanii


select companyname, address, country as 'KRAJ!' from customers where country like 'france'  or country = 'spain'
--8. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
select productname, unitprice from products where unitprice between 20.00 and 30.00 order by 2
--9. Wybierz nazwy i ceny produktów z kategorii ‘meat’
select productname, unitprice, categoryID from products where categoryID = (select categoryID from categories where categoryname like '%meat%')
--inny sposób - deklaracja zmiennej, pod którą bdzie podzapytanie
--declare @nr int
--set @nr  select categoryid from categories where categoryname like '%Meat%'
--select productname from products where categoryid= @nr
--10. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
select  productname, unitsinstock from products where supplierID = (select supplierID from suppliers where companyname = 'Tokyo Traders')order by unitsinstock desc

--11. Wybierz nazwy produktów których nie ma w magazynie
select productname, UnitsOnOrder from products where UnitsOnOrder < 1

--PORÓWNYWANIE STRINGÓW****************************************
--***********************************************
--***********************************************

-- 12.Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
select productname, quantityperunit from products where quantityperunit like '%bottle%'
-- 13. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę z zakresu od B do L
select firstname, lastname as "nazwisko" from employees where lastname like '[b-l]%' order by 2 desc
-- 14. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę B lub L
select firstname, lastname from employees where lastname like 'b%' or lastname like 'l%'
-- 15. Znajdź nazwy kategorii, które w opisie zawierają przecinek
select categoryname, description from categories where description like '%,%'
-- 16. Znajdź klientów, którzy w swojej nazwie mają w którymś miejscu słowo ‘Store’
select companyname as 'nazwa', LOWER(city) as miasto, customerID from customers where companyname like '%Store%'

--OPERATORY LOGICZNE*****************************
--***********************************************
--***********************************************
--17 - porównaj to zapytanie i nastepne
SELECT productid, productname, supplierid, unitprice FROM products WHERE (productname LIKE 'T%' OR productid = 46)
 AND (unitprice > 16.00) 
 --18
 SELECT productid, productname, supplierid, unitprice FROM products WHERE (productname LIKE 'T%' OR productid = 46 AND unitprice > 16.00) 
 --19  Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20
 select productname, unitprice from products where unitprice < 10 or unitprice > 20 order by 2 desc
 --20 Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
 select productname, unitprice from products where unitprice > 20 and unitprice < 30 order by 2 desc
--***********************************************
--***********************************************
--***********************************************
--Sortowanie danych
--21. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy)
select companyname, city from customers  where country IN ( 'Japan', 'Italy')
--22. Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer klienta 
-- dla wszystkich niezrealizowanych jeszcze zleceń, dla których krajem odbiorcy jest Argentyna
select orderid, shippeddate, customerid from orders where (ShippedDate is null or requireddate  > GETDATE()) and ShipCountry ='Argentyna' 
--23 
SELECT productid, productname, categoryid, unitprice FROM products ORDER BY categoryid desc, unitprice DESC
-- 24. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju, w ramach danego kraju nazwy firm posortuj
-- alfabetycznie
select companyname, country from customers order by 2, 1 
-- 25. Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malejąco wg ceny
select  categoryid, productname, unitprice from products order by 1,3 desc
-- 26. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy), 
-- wyniki posortuj tak jak w pkt 1
select companyname, country from customers where country in ('Japan','Italy') order by 2, 1
-- 27 Eliminowanie duplikatów
SELECT DISTINCT country FROM suppliers ORDER BY country
-- 28 Zmian nazw kolumn
SELECT firstname AS First, lastname AS Last ,employeeid AS 'Employee ID:' FROM employees
-- 29 Użycie literałów
SELECT firstname, lastname ,'Identification number:', employeeid FROM employees
-- 30 Kolumny wyliczane - operacje na liczbach
select unitprice * 1.23 as BRUTTO, unitprice as NETTO from products
-- 31 Kolumny wyliczane - operacje na napisach
SELECT firstname + '  '  + lastname as imie_nazwisko from [employees]

--32.select count(*) from suppliers having  (select count(*), region from suppliers group  by region)
select count(*), region from suppliers group  by region order by 1 desc
select count(*) from suppliers

--334SELECT firstname, lastname
SELECT firstname, lastname ,'Identification number:', employeeid FROM employees

SELECT * FROM orders where orderdate between '07/05/96' and '1996-07-08' or customerid like '_o%'
SELECT * FROM orders where orderdate like ('%-07%')
GO