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