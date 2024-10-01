-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT * FROM sys.databases 
				WHERE name = 'EjemploNormalizacion')
BEGIN
    CREATE DATABASE EjemploNormalizacion;
END
GO

USE EjemploNormalizacion;
GO

-- ### Primera Forma Normal (1FN) ###
-- Tabla no normalizada:
CREATE TABLE ClientesNoNormalizado (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    ProductosComprados VARCHAR(255) -- Este campo contiene múltiples valores
);

-- Insertar datos no normalizados
INSERT INTO ClientesNoNormalizado (ClienteID, Nombre, ProductosComprados)
VALUES (1, 'Juan Pérez', 'Televisor, Laptop'),
       (2, 'Ana Gómez', 'Lavadora, Refrigerador'),
       (3, 'Luis Torres', 'Camiseta');

-- Tabla normalizada a 1FN:
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100)
);
CREATE TABLE ProductosComprados (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT,
    Producto VARCHAR(100),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);
-- Insertar datos normalizados (1FN)
INSERT INTO Clientes (ClienteID, Nombre)
VALUES (1, 'Juan Pérez'),
       (2, 'Ana Gómez'),
       (3, 'Luis Torres');

INSERT INTO ProductosComprados (ClienteID, Producto)
VALUES (1, 'Televisor'),
       (1, 'Laptop'),
       (2, 'Lavadora'),
       (2, 'Refrigerador'),
       (3, 'Camiseta');




-- ### Segunda Forma Normal (2FN) ###
CREATE TABLE ProductosCompradosNoNormalizado (
    ClienteID INT,
    Producto VARCHAR(100),
    Precio DECIMAL(10, 2)
);

-- Insertar datos no normalizados (2FN)
INSERT INTO ProductosCompradosNoNormalizado (ClienteID, Producto, Precio)
VALUES (1, 'Televisor', 500.00),
       (1, 'Laptop', 800.00),
       (2, 'Lavadora', 300.00),
       (2, 'Refrigerador', 600.00),
       (3, 'Camiseta', 20.00);
-- Datos normalizados (2FN)
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    Producto VARCHAR(100),
    Precio DECIMAL(10, 2)
);

CREATE TABLE Compras (
    CompraID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT,
    ProductoID INT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Insertar datos normalizados (2FN)
INSERT INTO Productos (Producto, Precio)
VALUES ('Televisor', 500.00),
       ('Laptop', 800.00),
       ('Lavadora', 300.00),
       ('Refrigerador', 600.00),
       ('Camiseta', 20.00);

INSERT INTO Compras (ClienteID, ProductoID)
VALUES (1, 1),  -- Juan compró Televisor
       (1, 2),  -- Juan compró Laptop
       (2, 3),  -- Ana compró Lavadora
       (2, 4),  -- Ana compró Refrigerador
       (3, 5);  -- Luis compró Camiseta




-- ### Segunda Forma Normal (3FN) ###

CREATE TABLE ProductosNoNormalizado (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    Producto VARCHAR(100),
    Precio DECIMAL(10, 2),
    CategoriaProducto VARCHAR(50)
);

-- Insertar datos no normalizados (3FN)
INSERT INTO ProductosNoNormalizado (Producto, Precio, CategoriaProducto)
VALUES ('Televisor', 500.00, 'Electrónica'),
       ('Laptop', 800.00, 'Electrónica'),
       ('Lavadora', 300.00, 'Hogar'),
       ('Refrigerador', 600.00, 'Hogar'),
       ('Camiseta', 20.00, 'Ropa');

CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY(1,1),
    CategoriaProducto VARCHAR(50)
);

CREATE TABLE Productos3FN (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    Producto VARCHAR(100),
    Precio DECIMAL(10, 2),
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

-- Insertar datos en Categorías
INSERT INTO Categorias (CategoriaProducto)
VALUES ('Electrónica'),
       ('Hogar'),
       ('Ropa');

-- Insertar datos en Productos normalizados (3FN)
INSERT INTO Productos3FN (Producto, Precio, CategoriaID)
VALUES ('Televisor', 500.00, 1),    -- Electrónica
       ('Laptop', 800.00, 1),       -- Electrónica
       ('Lavadora', 300.00, 2),     -- Hogar
       ('Refrigerador', 600.00, 2), -- Hogar
       ('Camiseta', 20.00, 3);      -- Ropa
