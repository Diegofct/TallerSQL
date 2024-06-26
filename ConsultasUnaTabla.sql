-- CONSULTAS SOBRE UNA TABLA

-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT o.idOficina AS CodigoOficina, c.nombreCiudad AS Ciudad
FROM Oficina o
JOIN Ciudad c ON o.idCiudad = c.idCiudad;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT Ciudad.nombreCiudad, Oficina.telefonoOficina
FROM Oficina
INNER JOIN Ciudad ON Oficina.idCiudad = Ciudad.idCiudad
INNER JOIN Pais ON Ciudad.fk_idRegion = Pais.idPais
WHERE Pais.nombrePais = 'España';

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT e.nombreEmpleado, e.apellido1Empleado, e.email
FROM Empleado e
WHERE codigoJefe = 7;

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT e.puesto, e.nombreEmpleado, e.apellido1Empleado, e.apellido2Empleado, e.email
FROM Empleado e
WHERE codigoJefe is NULL

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT e.nombreEmpleado, e.apellido1Empleado, e.apellido2Empleado, e.puesto
FROM Empleado e
WHERE e.puesto != 'Representante de Ventas';

-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT c.nombreCliente
FROM Cliente c
JOIN Pais P ON c.idPais = P.idPais
WHERE P.nombrePais = 'España';

-- 7.Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado
FROM Pedido;

/*
8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
*/

-- Utilizando la función YEAR de MySQL.
SELECT DISTINCT idCliente
FROM Pago
WHERE YEAR(fechaPago) = 2008;

-- Utilizando la función DATE_FORMAT de MySQL.
SELECT DISTINCT idCliente
FROM Pago
WHERE DATE_FORMAT(fechaPago, '%Y') = '2008';

-- Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT idCliente
FROM Pago
WHERE fechaPago >= '2008-01-01' AND fechaPago < '2009-01-01';

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT idPedido, idCliente, fechaEsperada, fechaEntrega
FROM Pedido
WHERE fechaEntrega > fechaEsperada;


/* 10. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
menos dos días antes de la fecha esperada.
*/

-- Usando la funcion ADDDATE de MySQL.
SELECT idPedido, idCliente, fechaEsperada, fechaEntrega
FROM Pedido
WHERE fechaEntrega <= ADDDATE(fechaEsperada, INTERVAL -2 DAY);

-- Utilizando la funcion DATEDIFF de MySQL.
SELECT idPedido, idCliente, fechaEsperada, fechaEntrega
FROM Pedido
WHERE DATEDIFF(fechaEsperada, fechaEntrega) >= 2;

 -- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT idPedido, idCliente, fechaPedido, estado
FROM Pedido
WHERE estado = 'Rechazado' AND YEAR(fechaPedido) = 2009;

-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT idPedido, idCliente, fechaEntrega
FROM Pedido
WHERE MONTH(fechaEntrega) = 1;

-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
SELECT p.idPago, p.formaPago, p.fechaPago, p.total, p.idCliente
FROM Pago p
WHERE YEAR(fechaPago) = 2008 and formaPago = 'Transferencia'
ORDER BY total DESC;

-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT p.formaPago 
FROM Pago p;


