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

