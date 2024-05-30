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
SELECT * FROM Empleado;