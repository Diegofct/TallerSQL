-- Creacion de la base de datos ---
CREATE DATABASE TallerJardineriaDB;
USE TallerJardineriaDB;

-- Creacion de las tablas, taller MySql --

CREATE TABLE Contacto (
  idContacto INT AUTO_INCREMENT,
  nombreContacto VARCHAR(50) NOT NULL,
  apellido1Contacto VARCHAR(50) NOT NULL,
  apellido2Contacto VARCHAR(50),
  telefonoContacto VARCHAR(20) NOT NULL,
  CONSTRAINT pk_idContacto PRIMARY KEY (idContacto)
);

CREATE TABLE Pais (
    idPais INT AUTO_INCREMENT,
    nombrePais VARCHAR(50) NOT NULL,
    CONSTRAINT pk_idPais PRIMARY KEY (idPais)
);

CREATE TABLE Region (
    idRegion INT AUTO_INCREMENT,
    nombreRegion VARCHAR(50) NOT NULL,
    fk_idPais INT,
    CONSTRAINT pk_idRegion PRIMARY KEY (idRegion),
    CONSTRAINT fk_PaisRegion FOREIGN KEY (fk_idPais) REFERENCES Pais(idPais)
);

CREATE TABLE Ciudad (
    idCiudad INT AUTO_INCREMENT,
    nombreCiudad VARCHAR(50) NOT NULL,
    fk_idRegion INT,
    CONSTRAINT pk_idCiudad PRIMARY KEY (idCiudad),
    CONSTRAINT fk_RegionCiudad FOREIGN KEY (fk_idRegion) REFERENCES Region(idRegion)
);

CREATE TABLE Direccion (
    idDireccion INT AUTO_INCREMENT,
    direccion1 VARCHAR(50) NOT NULL,
    direccion2 VARCHAR(50),
    codigoPostal VARCHAR(10),
    idCiudad INT,
    CONSTRAINT pk_idDireccion PRIMARY KEY (idDireccion)
    CONSTRAINT fk_DireccionCiudad FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad)
);

CREATE TABLE Oficina (
    idOficina VARCHAR(10) NOT NULL,
    idCiudad INT,
    idPais INT,
    telefonoOficina VARCHAR(20) NOT NULL,
    idDireccion INT,
    CONSTRAINT pk_idOficina PRIMARY KEY (idOficina),
    CONSTRAINT fk_OficinaDireccion FOREIGN KEY (idDireccion) REFERENCES Direccion(idDireccion),
    CONSTRAINT fk_OficinaCiudad FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad),
    CONSTRAINT fk_OficinaPais FOREIGN KEY (idPais) REFERENCES Pais(idPais)
);

CREATE TABLE Empleado (
    idEmpleado INT AUTO_INCREMENT,
    nombreEmpleado VARCHAR(50) NOT NULL,
    apellido1Empleado VARCHAR(50) NOT NULL,
    apellido2Empleado VARCHAR(50),
    telefonoEmpleado VARCHAR(20) NOT NULL,
    extension VARCHAR(10),
    email VARCHAR(100),
    idOficina VARCHAR(10),
    codigoJefe INT,
    puesto VARCHAR(50),
    CONSTRAINT pk_idEmpleado PRIMARY KEY (idEmpleado),
    CONSTRAINT fk_EmpleadoOficina FOREIGN KEY (idOficina) REFERENCES Oficina(idOficina),
    CONSTRAINT fk_EmpleadoJefe FOREIGN KEY (codigoJefe) REFERENCES Empleado(idEmpleado)
);

CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT,
    nombreCliente VARCHAR(50) NOT NULL,
    idContacto INT,
    telefonoCliente VARCHAR(20),
    fax VARCHAR(15),
    idDireccion INT,
    idEmpleado INT,
    idCiudad INT,
    idPais INT,
    limiteCredito DECIMAL(15,2),
    CONSTRAINT pk_idCliente PRIMARY KEY (idCliente),
    CONSTRAINT fk_ClienteDireccion FOREIGN KEY (idDireccion) REFERENCES Direccion(idDireccion),
    CONSTRAINT fk_ClienteEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
    CONSTRAINT fk_ClientePais FOREIGN KEY (idPais) REFERENCES Pais(idPais),
    CONSTRAINT fk_ClienteCiudad FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad),
    CONSTRAINT fk_ClienteContacto FOREIGN KEY (idContacto) REFERENCES Contacto(idContacto)
);

CREATE TABLE Pago (
    idPago VARCHAR(10),
    formaPago ENUM('Efectivo','Transferencia','Tarjeta'),
    fechaPago DATETIME,
    total DECIMAL(15,2),
    idCliente INT,
    CONSTRAINT pk_idPago PRIMARY KEY (idPago),
    CONSTRAINT fk_PagoCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT,
    fechaPedido DATETIME,
    fechaEsperada DATETIME,
    fechaEntrega DATETIME,
    estado VARCHAR(15),
    comentarios TEXT,
    idCliente INT,
    CONSTRAINT pk_idPedido PRIMARY KEY (idPedido),
    CONSTRAINT fk_PedidoCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE GamaProducto (
    gama VARCHAR(50) NOT NULL,
    descripcionTexto TEXT,
    descripcionHtml TEXT,
    imagen VARCHAR(256),
    CONSTRAINT pk_gama PRIMARY KEY (gama)
);

CREATE TABLE Proveedor (
    idProveedor INT AUTO_INCREMENT,
    nombreProveedor VARCHAR(100) NOT NULL,
    telefonoProveedor VARCHAR(20),
    idDireccion INT,
    CONSTRAINT pk_idProveedor PRIMARY KEY (idProveedor),
    CONSTRAINT fk_ProveedorDireccion FOREIGN KEY (idDireccion) REFERENCES Direccion(idDireccion)
);

CREATE TABLE Producto (
    idProducto VARCHAR(15) NOT NULL,
    nombreProducto VARCHAR(70) NOT NULL,
    gama VARCHAR(50),
    dimensiones VARCHAR(25),
    idProveedor INT,
    descripcion TEXT,
    cantidadEnStock SMALLINT,
    precioVenta DECIMAL(15,2),
    precioProveedor DECIMAL(15,2),
    CONSTRAINT pk_idProducto PRIMARY KEY (idProducto),
    CONSTRAINT fk_ProductoGama FOREIGN KEY (gama) REFERENCES GamaProducto(gama),
    CONSTRAINT fk_ProductoProveedor FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
);

CREATE TABLE DetallePedido (
    idDetalle INT AUTO_INCREMENT,
    idPedido INT,
    idProducto VARCHAR(15),
    cantidad INT,
    precioUnidad DECIMAL(15,2),
    numeroLinea SMALLINT,
    CONSTRAINT pk_idDetalle PRIMARY KEY (idDetalle),
    CONSTRAINT fk_DetallePedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    CONSTRAINT fk_DetalleProducto FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

-- Registros para la tabla contacto --
INSERT INTO Contacto (nombreContacto, apellido1Contacto, apellido2Contacto, telefonoContacto) VALUES
('Juan', 'Pérez', 'Gómez', '+57 312 3456789'),
('María', 'García', 'López', '+57 310 9876543'),
('Pedro', 'Rodríguez', 'Martínez', '+57 311 1234567'),
('Ana', 'Sánchez', 'González', '+57 314 8765432'),
('José', 'López', 'Ruiz', '+57 315 2345678'),
('Isabel', 'Flores', 'Ramírez', '+57 316 5432109'),
('Carlos', 'Martínez', 'Navarro', '+57 317 4321098'),
('Andrea', 'Gómez', 'Fernández', '+57 318 3210987'),
('David', 'Pérez', 'Muñoz', '+57 319 2109876'),
('Laura', 'García', 'Blanco', '+57 320 1098765');

-- Registros para la tabla Pais --
INSERT INTO Pais (nombrePais) VALUES
('Argentina'),
('Bolivia'),
('Brasil'),
('Chile'),
('Colombia'),
('Costa Rica'),
('Cuba'),
('Ecuador'),
('El Salvador'),
('Guatemala');

-- Registros tabla Region
INSERT INTO Region (nombreRegion, fk_idPais) VALUES
('Ciudad Autónoma de Buenos Aires', 1),
('Santa Cruz', 2),
('São Paulo', 3),
('Metropolitana de Santiago', 4),
('Antioquia', 5),
('San José', 6),
('La Habana', 7),
('Guayas', 8),
('San Salvador', 9),
('Petén', 10);

-- Registros tabla Ciudad
INSERT INTO Ciudad (nombreCiudad, fk_idRegion) VALUES
('Buenos Aires', 1),
('Santa Cruz de la Sierra', 2),
('São Paulo', 3),
('Santiago de Chile', 4),
('Medellín', 5),
('San José', 6),
('La Habana', 7),
('Guayaquil', 8),
('San Salvador', 9),
('Flores', 10);

-- Registros tabla Direccion
INSERT INTO Direccion (direccion1, direccion2, codigoPostal, idCiudad) VALUES
('Av. 9 de Julio 1400', '', 'C1073ABQ', 1),
('Calle 25 de Mayo 175', '', 'SCZ 4000', 2),
('Rua Augusta 1234', '', '01303-900', 3),
('Av. Providencia 1000', '', '7500000', 4),
('Calle 70 #44-84', '', '05001', 5),
('Avenida 11 Calle 3', '', '10101', 6),
('Calle 23 #1 Vedado', '', '10100', 7),
('Av. Quito y Pedro Carbo', '', 'EC8000', 8),
('Calle Rubén Darío y 7a Avenida Norte', '', 'SS00000', 9),
('Avenida 5 5-55', '', '16001', 10);

-- Registros tabla Oficina
INSERT INTO Oficina (idOficina, idCiudad, idPais, telefonoOficina, idDireccion) VALUES
('BAQ001', 1, 1, '+54 11 43210000', 1),
('SCZ123', 2, 2, '+591 3 4567890', 2),
('RIO234', 3, 3, '+55 21 22334444', 3),
('SGO789', 4, 4, '+56 2 6789012', 4),
('MED456', 5, 5, '+57 4 1234567', 5),
('SJO987', 6, 6, '+506 2 5556666', 6),
('HAV321', 7, 7, '+53 7 2345678', 7),
('GYE009', 8, 8, '+593 4 7890123', 8),
('SSV543', 9, 9, '+503 2 3456789', 9),
('PET678', 10, 10, '+502 5 6789012', 10);

--
INSERT INTO Empleado (nombreEmpleado, apellido1Empleado, apellido2Empleado, telefonoEmpleado, extension, email, idOficina, codigoJefe, puesto) VALUES
('Juan', 'Pérez', 'González', '+54 11 4567890', '1234', 'juan.perez@empresa.com', 'BAQ001', NULL, 'Programador'),
('María', 'García', 'López', '+54 11 5678901', '2345', 'maria.garcia@empresa.com', 'SCL987', NULL, 'Analista de Sistemas'),
('Pedro', 'Silva', 'Martínez', '+55 21 6789012', '3456', 'pedro.silva@empresa.com', 'RIO234', NULL, 'Desarrollador Web'),
('Ana', 'Román', 'Díaz', '+56 2 7890123', '4567', 'ana.roman@empresa.com', 'SGO789', NULL, 'Diseñadora Gráfica'),
('Carlos', 'Flores', 'Ramírez', '+57 4 2345678', '5678', 'carlos.flores@empresa.com', 'MED456', NULL, 'Contador'),
('Isabel', 'López', 'Fernández', '+506 2 3456789', '6789', 'isabel.lopez@empresa.com', 'SJO987', NULL, 'Asistente de Marketing'),
('José', 'Martínez', 'Gómez', '+53 7 4567890', '7890', 'jose.martinez@empresa.com', 'HAV321', NULL, 'Administrador de Base de Datos'),
('Patricia', 'Gómez', 'Rodríguez', '+593 4 5678901', '8901', 'patricia.gomez@empresa.com', 'GYE009', NULL, 'Soporte Técnico'),
('Luis', 'Rodríguez', 'Álvarez', '+503 2 6789012', '9012', 'luis.rodriguez@empresa.com', 'SSV543', NULL, 'Vendedor'),
('Andrea', 'Sánchez', 'Navarro', '+502 5 7890123', '0123', 'andrea.sanchez@empresa.com', 'PET678', NULL, 'Recursos Humanos');

-- Registros tabla Cliente
INSERT INTO Cliente (nombreCliente, idContacto, telefonoCliente, fax, idDireccion, idEmpleado, idCiudad, idPais, limiteCredito) VALUES
('Distribuidora Rodriguez & Cia', 5, '+54 11 67890123', '+54 11 67890124', 6, 18, 1, 1, 350000.00),
('Supermercados del Sur S.A.', NULL, '+591 3 8901234', '', 9, NULL, 2, 2, 200000.00),
('Electrónica Silva S.A.', 6, '+55 21 34567890', '+55 21 34567891', 1, 12, 3, 3, 175000.00),
('Textiles del Pacífico Ltda.', NULL, '+56 2 98765432', '', 5, 5, 4, 4, 100000.00),
('Cafeterias Aroma & Sabor', 7, '+57 4 3210987', '+57 4 3210988', 10, 10, 5, 5, 60000.00),
('Carnes y Embutidos La Fortuna', NULL, '+506 2 5678901', '', 2, 15, 6, 6, 90000.00),
('Pescadería Mariscos del Caribe', 8, '+503 2 7654321', '+503 2 7654322', 7, 12, 9, 9, 50000.00),
('Panificadora El Horno Dorado', NULL, '+502 5 8765432', '', 4, 18, 10, 10, 40000.00);

-- Registros tabla Pago
INSERT INTO Pago (idPago, formaPago, fechaPago, total, idCliente) VALUES 
('P001', 'Efectivo', '2023-01-01 12:00:00', 1000.00, 1),
('P002', 'Transferencia', '2023-02-01 13:00:00', 2000.00, 2),
('P003', 'Tarjeta', '2023-03-01 14:00:00', 3000.00, 3),
('P004', 'Efectivo', '2023-04-01 15:00:00', 4000.00, 4),
('P005', 'Transferencia', '2023-05-01 16:00:00', 5000.00, 5),
('P006', 'Tarjeta', '2023-06-01 17:00:00', 6000.00, 6),
('P007', 'Efectivo', '2023-07-01 18:00:00', 7000.00, 7),
('P008', 'Transferencia', '2023-08-01 19:00:00', 8000.00, 8),
('P009', 'Tarjeta', '2023-09-01 20:00:00', 9000.00, 9),
('P010', 'Efectivo', '2023-10-01 21:00:00', 10000.00, 10);

-- Registros tabla Pedido
INSERT INTO Pedido (fechaPedido, fechaEsperada, fechaEntrega, estado, comentarios, idCliente) VALUES 
('2023-01-01 10:00:00', '2023-01-10 10:00:00', '2023-01-09 10:00:00', 'Entregado', 'Pedido entregado a tiempo', 1),
('2023-02-01 11:00:00', '2023-02-10 11:00:00', '2023-02-09 11:00:00', 'Entregado', 'Pedido entregado a tiempo', 2),
('2023-03-01 12:00:00', '2023-03-10 12:00:00', '2023-03-09 12:00:00', 'Entregado', 'Pedido entregado a tiempo', 3),
('2023-04-01 13:00:00', '2023-04-10 13:00:00', '2023-04-09 13:00:00', 'Entregado', 'Pedido entregado a tiempo', 4),
('2023-05-01 14:00:00', '2023-05-10 14:00:00', '2023-05-09 14:00:00', 'Entregado', 'Pedido entregado a tiempo', 5),
('2023-06-01 15:00:00', '2023-06-10 15:00:00', '2023-06-09 15:00:00', 'Entregado', 'Pedido entregado a tiempo', 6),
('2023-07-01 16:00:00', '2023-07-10 16:00:00', '2023-07-09 16:00:00', 'Entregado', 'Pedido entregado a tiempo', 7),
('2023-08-01 17:00:00', '2023-08-10 17:00:00', '2023-08-09 17:00:00', 'Entregado', 'Pedido entregado a tiempo', 8),
('2023-09-01 18:00:00', '2023-09-10 18:00:00', '2023-09-09 18:00:00', 'Entregado', 'Pedido entregado a tiempo', 9),
('2023-10-01 19:00:00', '2023-10-10 19:00:00', '2023-10-09 19:00:00', 'Entregado', 'Pedido entregado a tiempo', 10);

-- Registros tabla GamaProducto
INSERT INTO GamaProducto (gama, descripcionTexto, descripcionHtml, imagen) VALUES 
('Economico', 'Productos de gama economica', '<p>Productos de gama economica</p>', 'imagen1.jpg'),
('Medio', 'Productos de gama media', '<p>Productos de gama media</p>', 'imagen2.jpg'),
('Alto', 'Productos de gama alta', '<p>Productos de gama alta</p>', 'imagen3.jpg'),
('Premium', 'Productos de gama premium', '<p>Productos de gama premium</p>', 'imagen4.jpg');

-- Registros tabla Proveedor
INSERT INTO Proveedor (nombreProveedor, telefonoProveedor, idDireccion) VALUES 
('Proveedor1', '555-6001', 1),
('Proveedor2', '555-6002', 2),
('Proveedor3', '555-6003', 3),
('Proveedor4', '555-6004', 4),
('Proveedor5', '555-6005', 5),
('Proveedor6', '555-6006', 6),
('Proveedor7', '555-6007', 7),
('Proveedor8', '555-6008', 8),
('Proveedor9', '555-6009', 9),
('Proveedor10', '555-6010', 10);

--
INSERT INTO Proveedor (nombreProveedor, telefonoProveedor, idDireccion) VALUES 
('Proveedor1', '555-6001', 1),
('Proveedor2', '555-6002', 2),
('Proveedor3', '555-6003', 3),
('Proveedor4', '555-6004', 4),
('Proveedor5', '555-6005', 5),
('Proveedor6', '555-6006', 6),
('Proveedor7', '555-6007', 7),
('Proveedor8', '555-6008', 8),
('Proveedor9', '555-6009', 9),
('Proveedor10', '555-6010', 10),

--
INSERT INTO DetallePedido (idPedido, idProducto, cantidad, precioUnidad, numeroLinea) VALUES 
(1, 'P001', 10, 50.00, 1),
(2, 'P002', 20, 75.00, 1),
(3, 'P003', 30, 100.00, 1),
(4, 'P004', 40, 125.00, 1),
(5, 'P005', 50, 50.00, 1),
(6, 'P006', 60, 75.00, 1),
(7, 'P007', 70, 100.00, 1),
(8, 'P008', 80, 125.00, 1),
(9, 'P009', 90, 50.00, 1),
(10, 'P010', 100, 75.00, 1);