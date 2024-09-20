-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS Omega;
USE Omega;

-- Tabla de Usuarios para autenticación
CREATE TABLE Usuarios (
    id_Usuario INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol ENUM('Administrador', 'Proveedor', 'Domiciliario', 'Cliente') NOT NULL,
    id_Rol INT NOT NULL
);

-- Tabla de Administrador
CREATE TABLE Administrador (
    id_Admin INT PRIMARY KEY AUTO_INCREMENT,
    nombre_Admin VARCHAR(20) NOT NULL,
    apellido_Admin VARCHAR(20) NOT NULL,
    doc_Admin VARCHAR(20) NOT NULL,
    cel_Admin VARCHAR(20) NOT NULL,
    direccion_Admin VARCHAR(50) NOT NULL,
    correo_Admin VARCHAR(50) NOT NULL,
    id_Usuario INT UNIQUE,
    CONSTRAINT FK_Administrador_Usuario FOREIGN KEY (id_Usuario) REFERENCES Usuarios(id_Usuario)
);

-- Tabla de Proveedor
CREATE TABLE Proveedor (
    id_Proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre_Proveedor VARCHAR(20) NOT NULL,
    nit_Proveedor VARCHAR(20) NOT NULL,
    cel_Proveedor VARCHAR(20) NOT NULL,
    direccion_Proveedor VARCHAR(50) NOT NULL,
    Administrador_id INT,
    id_Usuario INT UNIQUE,
    CONSTRAINT FK_Proveedor_Administrador FOREIGN KEY (Administrador_id) REFERENCES Administrador(id_Admin),
    CONSTRAINT FK_Proveedor_Usuario FOREIGN KEY (id_Usuario) REFERENCES Usuarios(id_Usuario)
);

-- Tabla de Productos
CREATE TABLE Productos (
    id_Producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_Producto VARCHAR(25) NOT NULL,
    marca_Producto VARCHAR(20) NOT NULL,
    precio_Producto DECIMAL(10, 2) NOT NULL,
    id_Proveedor INT,
    CONSTRAINT FK_Productos_Proveedor FOREIGN KEY (id_Proveedor) REFERENCES Proveedor(id_Proveedor)
);

-- Tabla de Domiciliario
CREATE TABLE Domiciliario (
    id_Domiciliario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_Domiciliario VARCHAR(30) NOT NULL,
    apellido_Domiciliario VARCHAR(30) NOT NULL,
    doc_Domiciliario VARCHAR(20) NOT NULL,
    cel_Domiciliario VARCHAR(20) NOT NULL,
    direccion_Domiciliario VARCHAR(50) NOT NULL,
    correo_Domiciliario VARCHAR(50) NOT NULL,
    placa_Domiciliario VARCHAR(10) NOT NULL,
    licencia_Domiciliario VARCHAR(50) NOT NULL,
    id_Producto INT,
    id_Usuario INT UNIQUE,
    CONSTRAINT FK_Domiciliario_Productos FOREIGN KEY (id_Producto) REFERENCES Productos(id_Producto) ON DELETE SET NULL,
    CONSTRAINT FK_Domiciliario_Usuario FOREIGN KEY (id_Usuario) REFERENCES Usuarios(id_Usuario)
);

-- Tabla de Cliente
CREATE TABLE Cliente (
    id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_Cliente VARCHAR(20) NOT NULL,
    apellido_Cliente VARCHAR(20) NOT NULL,
    cel_Cliente VARCHAR(20) NOT NULL,
    correo_Cliente VARCHAR(50) NOT NULL,
    doc_Cliente VARCHAR(20) NOT NULL,
    id_Domiciliario INT,
    id_Usuario INT UNIQUE,
    CONSTRAINT FK_Cliente_Domiciliario FOREIGN KEY (id_Domiciliario) REFERENCES Domiciliario(id_Domiciliario) ON DELETE SET NULL,
    CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (id_Usuario) REFERENCES Usuarios(id_Usuario)
);

-- Tabla de Factura
CREATE TABLE Factura (
    id_Factura INT PRIMARY KEY AUTO_INCREMENT,
    fecha_Factura DATE NOT NULL,
    total_Factura DECIMAL(10, 2) NOT NULL,
    id_Producto INT NOT NULL,
    id_Cliente INT NOT NULL,
    id_Domiciliario INT NOT NULL,
    cantidad_Productos INT NOT NULL,
    CONSTRAINT FK_Factura_Productos FOREIGN KEY (id_Producto) REFERENCES Productos(id_Producto) ON DELETE CASCADE,
    CONSTRAINT FK_Factura_Cliente FOREIGN KEY (id_Cliente) REFERENCES Cliente(id_Cliente) ON DELETE CASCADE,
    CONSTRAINT FK_Factura_Domiciliario FOREIGN KEY (id_Domiciliario) REFERENCES Domiciliario(id_Domiciliario) ON DELETE CASCADE
);

-- Inserción de datos de ejemplo para Administrador
INSERT INTO Usuarios (username, password, rol, id_Rol) VALUES
('admin1@example.com', '$2b$10$YOUR_HASHED_PASSWORD', 'Administrador', 1),
('admin2@example.com', '$2b$10$YOUR_HASHED_PASSWORD', 'Administrador', 2);

INSERT INTO Administrador (nombre_Admin, apellido_Admin, doc_Admin, cel_Admin, direccion_Admin, correo_Admin, id_Usuario) VALUES
('pablo', 'escobar', '123456789', '3236998', 'calle 128', 'pablo15@.com', 1),
('popeye', 'marino', '1234561', '3239428', 'av 100', 'popetem15@.com', 2);

-- Inserción de datos de ejemplo para Proveedor
INSERT INTO Usuarios (username, password, rol, id_Rol) VALUES
('proveedor1@example.com', '$2b$10$YOUR_HASHED_PASSWORD', 'Proveedor', 1),
('proveedor2@example.com', '$2b$10$YOUR_HASHED_PASSWORD', 'Proveedor', 2);

INSERT INTO Proveedor (nombre_Proveedor, nit_Proveedor, cel_Proveedor, direccion_Proveedor, Administrador_id, id_Usuario) VALUES
('Julian', '2324', '32214563', 'cll 128', 1, 3),
('Andres', '3433', '32134265', 'tv 12', 2, 4);

-- Inserción de datos de ejemplo para Productos
INSERT INTO Productos (nombre_Producto, marca_Producto, precio_Producto, id_Proveedor) VALUES
('Boligrafos', 'Bic', 3000, 1),
('Borrador', 'Pelikan', 10000, 2);

-- Inserción de datos de ejemplo para Domiciliario
INSERT INTO Usuarios (username, password, rol, id_Rol) VALUES
('domiciliario1@example.com', '$2b$10$YOUR_HASHED_PASSWORD', 'Domiciliario', 1),
('domiciliario2@example.com', '$2b$10$YOUR_HASHED_PASSWORD', 'Domiciliario', 2);

INSERT INTO Domiciliario (nombre_Domiciliario, apellido_Domiciliario, doc_Domiciliario, cel_Domiciliario, direccion_Domiciliario, correo_Domiciliario, placa_Domiciliario, licencia_Domiciliario, id_Producto, id_Usuario) VALUES
('mariana', 'salcedo', '135157', '462541', 'suba tv 91', 'mar@gmail.com', 'RTO85V', '452PUIK', 1, 5),
('cesar', 'pinzon', '895642', '58234', 'lagos', 'cesa@gmail.com', 'LVK32E', '535IKER', 2, 6);

-- Inserción de datos de ejemplo para Cliente
INSERT INTO Usuarios (username, password, rol, id_Rol) VALUES
('cliente1@example.com', '$2b$10$YOUR_HASHED_PASSWORD', 'Cliente', 1),
('cliente2@example.com', '$2b$10$YOUR_HASHED_PASSWORD', 'Cliente', 2);

INSERT INTO Cliente (nombre_Cliente, apellido_Cliente, cel_Cliente, correo_Cliente, doc_Cliente, id_Domiciliario, id_Usuario) VALUES
('Jaime', 'Garzon', '3211234', 'pablo15@.com', '12345678', 1, 7),
('julian', 'marino', '3131234', 'julian10@.com', '123567365', 2, 8);

-- Inserción de datos de ejemplo para Factura
INSERT INTO Factura (fecha_Factura, total_Factura, id_Producto, id_Cliente, id_Domiciliario, cantidad_Productos) VALUES
('2023-09-19', 30000, 1, 1, 1, 10),
('2023-09-20', 50000, 2, 2, 2, 5);