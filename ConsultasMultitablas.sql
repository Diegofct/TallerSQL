-- Consultas multitabla (Composición interna) --

/*

Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

*/

-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT Cliente.nombreCliente, Empleado.nombreEmpleado, Empleado.apellido1Empleado, Empleado.apellido2Empleado
FROM Cliente
INNER JOIN Empleado ON Cliente.idEmpleado = Empleado.idEmpleado;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT Cliente.nombreCliente, Empleado.nombreEmpleado, Empleado.apellido1Empleado, Empleado.apellido2Empleado
FROM Cliente
INNER JOIN Pago ON Cliente.idCliente = Pago.idCliente
INNER JOIN Empleado ON Cliente.idEmpleado = Empleado.idEmpleado;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT Cliente.nombreCliente, Empleado.nombreEmpleado, Empleado.apellido1Empleado, Ciudad.nombreCiudad
FROM Cliente
INNER JOIN Pago ON Cliente.idCliente = Pago.idCliente
INNER JOIN Empleado ON Cliente.idEmpleado = Empleado.idEmpleado
INNER JOIN Oficina ON Empleado.idOficina = Oficina.idOficina
INNER JOIN Ciudad ON Oficina.idCiudad = Ciudad.idCiudad;

-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT Cliente.nombreCliente, Empleado.nombreEmpleado, Empleado.apellido1Empleado, Ciudad.nombreCiudad
FROM Cliente
INNER JOIN Pago ON Cliente.idCliente = Pago.idCliente
INNER JOIN Empleado ON Cliente.idEmpleado = Empleado.idEmpleado
INNER JOIN Oficina ON Empleado.idOficina = Oficina.idOficina
INNER JOIN Ciudad ON Oficina.idCiudad = Ciudad.idCiudad;

-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT Cliente.nombreCliente, Empleado.nombreEmpleado, Empleado.apellido1Empleado, Ciudad.nombreCiudad
FROM Cliente
INNER JOIN Empleado ON Cliente.idEmpleado = Empleado.idEmpleado
INNER JOIN Oficina ON Empleado.idOficina = Oficina.idOficina
INNER JOIN Ciudad ON Oficina.idCiudad = Ciudad.idCiudad
LEFT JOIN Pago ON Cliente.idCliente = Pago.idCliente
WHERE Pago.idCliente IS NULL;

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT Direccion.direccion1,Direccion.direccion2,Direccion.codigoPostal
FROM Oficina
INNER JOIN Ciudad ON Oficina.idCiudad = Ciudad.idCiudad
INNER JOIN Direccion ON Oficina.idDireccion = Direccion.idDireccion
WHERE Ciudad.nombreCiudad = 'Fuenlabrada';

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT Cliente.nombreCliente AS NombreCliente, CONCAT(Empleado.nombreEmpleado, ' ', Empleado.apellido1Empleado, ' ', Empleado.apellido2Empleado) AS NombreRepresentante,Ciudad.nombreCiudad AS CiudadOficina
FROM Cliente
JOIN Empleado ON Cliente.idEmpleado = Empleado.idEmpleado
JOIN Oficina ON Empleado.idOficina = Oficina.idOficina
JOIN Ciudad ON Oficina.idCiudad = Ciudad.idCiudad;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT Empleado.nombreEmpleado, Empleado.apellido1Empleado ,Empleado.apellido2Empleado, CONCAT(e2.nombreEmpleado, ' ', e2.apellido1Empleado, ' ', e2.apellido2Empleado) AS NombreJefe
FROM Empleado Empleado
INNER JOIN Empleado e2 ON Empleado.codigoJefe = e2.idEmpleado;

-- 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
SELECT e1.nombreEmpleado AS NombreEmpleado,e1.apellido1Empleado AS Apellido1Empleado,e1.apellido2Empleado AS Apellido2Empleado,CONCAT(e2.nombreEmpleado, ' ', e2.apellido1Empleado, ' ', e2.apellido2Empleado) AS NombreJefe,CONCAT(e3.nombreEmpleado, ' ', e3.apellido1Empleado, ' ', e3.apellido2Empleado) AS NombreJefeDeJefe
FROM Empleado e1
INNER JOIN Empleado e2 ON e1.codigoJefe = e2.idEmpleado
LEFT JOIN Empleado e3 ON e2.codigoJefe = e3.idEmpleado;

-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT DISTINCT c.nombreCliente,c.apellidoCliente
FROM Cliente c
INNER JOIN Pedido p ON c.idCliente = p.idCliente
WHERE p.fechaEntrega > p.fechaEsperada;

-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT DISTINCT c.nombreCliente,c.apellidoCliente,gp.nombreGama
FROM Cliente c
INNER JOIN Pedido p ON c.idCliente = p.idCliente
INNER JOIN DetallePedido dp ON p.idPedido = dp.idPedido
INNER JOIN Producto pr ON dp.idProducto = pr.idProducto
INNER JOIN GamaProducto gp ON pr.idGamaProducto = gp.idGamaProducto


-- 




