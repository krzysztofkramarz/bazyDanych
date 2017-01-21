use Northwind
--1. zlicz wszystkie wiersze w tabeli employees, razem z NULL w jakimkolwiek wierszu
SELECT COUNT (*)
FROM employees


SELECT COUNT(region)
FROM employees

select * from Employees
select country, title , lastname,  COUNT (LastName), count(title) from Employees group by country, title, lastname order by 1 desc

GO