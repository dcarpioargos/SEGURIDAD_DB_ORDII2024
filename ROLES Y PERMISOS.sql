CREATE LOGIN dcarpio WITH PASSWORD = 'masterkey';

USE EjemploNormalizacion;

CREATE USER dcarpiodb FOR LOGIN dcarpio;
ALTER ROLE db_datareader ADD MEMBER dcarpiodb;
ALTER ROLE db_datawriter ADD MEMBER dcarpiodb;

SELECT * FROM Categorias

UPDATE Categorias
SET CategoriaProducto = 'ROPA'
WHERE CategoriaID = 3
