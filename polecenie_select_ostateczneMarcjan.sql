
use Northwind
--polecenie, które oblicza wartość każdej pozycji zamówienia (uwzględnij rabat)
--select UnitPrice*(1-discount)*quantity from [order details]
--polecenie które wypisuje zamówienie złożone w środę lub czwartek
SELECT orderid, customerid, DATENAME(dw,orderdate) from orders where DATENAME(dw,orderdate)  = 'Wednesday' or DATENAME(dw,orderdate)  = 'Thuesday'
set language Polish;
SELECT orderid, customerid, DATENAME(dw,orderdate) from orders where DATENAME(dw,orderdate) in ('środa', 'czwartek')
-- polecenie które wypisze nr tel i fax w postaci:  tel:###, fax:###
--select 'tel:' + isnull(phone,'#####') + ',fax:' + coalesce(fax,'#####', phone) from suppliers
--polecenie które dla każdego zamówienia wypisuje  nr zamóiwienia i liczbe dni jakie upłynęły miedzy data zamowienia a data wysyłki
select orderid, DATEDIFF(DAY, orderdate, shippeddate) from orders
Go
--"" nazwy
--'' napisy i daty

