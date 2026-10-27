CREATE DATABASE prestamoLibro

USE prestamoLibro

CREATE TABLE Contacto(
idContacto VARCHAR(50) PRIMARY KEY,
correo VARCHAR(50) NOT NULL,
telefono INT NOT NULL,
direccion VARCHAR(70) NOT NULL
);

ALTER TABLE Contacto ADD CONSTRAINT UQ_Contacto_Correo UNIQUE (correo);

ALTER TABLE Contacto ADD CONSTRAINT UQ_Contacto_Telefono UNIQUE (telefono);

ALTER TABLE Contacto DROP CONSTRAINT UQ_Contacto_Telefono;

ALTER TABLE Contacto ALTER COLUMN telefono VARCHAR(20) NOT NULL;

CREATE TABLE Usuario(
idUsuario VARCHAR(50) PRIMARY KEY,
nombre VARCHAR(75) NOT NULL,
documento int NOT NULL,
rol VARCHAR(20) NOT NULL,
idContacto VARCHAR(50) REFERENCES Contacto(idContacto)
);

ALTER TABLE Usuario ADD CONSTRAINT UQ_Usuario_Documento UNIQUE (documento);

ALTER TABLE Usuario ADD tipoDocumento VARCHAR(30) NOT NULL DEFAULT 'Cedula';

CREATE TABLE Libros(
idLibro VARCHAR(50) PRIMARY KEY,
nombre VARCHAR(80) NOT NULL,
genero VARCHAR(30) NOT NULL,
seccion VARCHAR(40) DEFAULT 'Sin Asignar'
);

ALTER TABLE Libros ADD ejemplares INT NOT NULL CONSTRAINT DF_Libros_Ejemplares DEFAULT 0;

ALTER TABLE Libros ADD CONSTRAINT CK_Libros_Stock_Positivo CHECK (ejemplares>=0);

ALTER TABLE Libros ADD añoPublicacion INT NULL;

ALTER TABLE Libros ADD CONSTRAINT CK_Libros_AñoValido CHECK(añoPublicacion>=1440 AND añoPublicacion <= YEAR(GETDATE()));

ALTER TABLE Libros DROP CONSTRAINT CK_Libros_AñoValido;

ALTER TABLE Libros ADD CONSTRAINT CK_Libros_AñoValido CHECK(añoPublicacion >=1 AND añoPublicacion <= YEAR(GETDATE()));

CREATE TABLE Prestamo(
idPrestamo VARCHAR(50) PRIMARY KEY,
idUsuario VARCHAR(50) REFERENCES Usuario(idUsuario),
idLibro VARCHAR(50) REFERENCES Libros(idLibro),
fechaPrestamo DATE DEFAULT CURRENT_DATE,
fechaEntrega DATE,
cantidadLibros INT NOT NULL CHECK(cantidadLibros>=0)
);

--Poblacion de tablas

INSERT INTO Contacto (idContacto, correo, telefono, direccion) VALUES 
('C001', 'ana.perez@email.com', 3001234561, 'Calle 10 # 20-30'),
('C002', 'carlos.gomez@email.com', 3001234562, 'Carrera 45 # 12-15'),
('C003', 'sofia.ruiz@email.com', 3001234563, 'Avenida Circular # 8-90'),
('C004', 'mateo.rodriguez@email.com', 3001234564, 'Transversal 32 # 45-12'),
('C005', 'laura.torres@email.com', 3001234565, 'Calle 50 # 15-22'),
('C006', 'david.morales@email.com', 3001234566, 'Carrera 7 # 70-10'),
('C007', 'valeria.castro@email.com', 3001234567, 'Diagonal 23 # 10-05'),
('C008', 'alejandro.ortiz@email.com', 3001234568, 'Calle 100 # 14-88'),
('C009', 'camila.rojas@email.com', 3001234569, 'Carrera 80 # 33-21'),
('C010', 'daniel.jimenez@email.com', 3001234570, 'Avenida El Poblado # 4-20'),
('C011', 'lucia.fernandez@email.com', 3001234571, 'Calle 33 # 65-40'),
('C012', 'felipe.sanchez@email.com', 3001234572, 'Carrera 12 # 8-34'),
('C013', 'gabriela.giraldo@email.com', 3001234573, 'Circular 75 # 39-25'),
('C014', 'martin.vargas@email.com', 3001234574, 'Calle 2 sur # 45-60'),
('C015', 'sara.ospina@email.com', 3001234575, 'Carrera 43A # 1 sur-50'),
('C016', 'jorge.restrepo@email.com', 3001234576, 'Calle 48 # 70-12'),
('C017', 'daniela.valencia@email.com', 3001234577, 'Avenida Las Palmas # 18-9'),
('C018', 'sebastian.lopez@email.com', 3001234578, 'Calle 65 # 50-22'),
('C019', 'manuela.cardona@email.com', 3001234579, 'Carrera 65 # 48-11'),
('C020', 'esteban.ramirez@email.com', 3001234580, 'Calle 9 sur # 35-14');

INSERT INTO Usuario (idUsuario, nombre, documento, rol, idContacto, tipoDocumento) VALUES 
('U001', 'Ana Pérez', 100123451, 'Estudiante', 'C001', 'Cédula'),
('U002', 'Carlos Gómez', 100123452, 'Docente', 'C002', 'Cédula'),
('U003', 'Sofía Ruiz', 100123453, 'Investigador', 'C003', 'Pasaporte'),
('U004', 'Mateo Rodríguez', 100123454, 'Estudiante', 'C004', 'Cédula'),
('U005', 'Laura Torres', 100123455, 'Estudiante', 'C005', 'Cédula'),
('U006', 'David Morales', 100123456, 'Administrativo', 'C006', 'Cédula'),
('U007', 'Valeria Castro', 100123457, 'Estudiante', 'C007', 'Cédula'),
('U008', 'Alejandro Ortiz', 100123458, 'Docente', 'C008', 'Cédula'),
('U009', 'Camila Rojas', 100123459, 'Estudiante', 'C009', 'Tarjeta de Identidad'),
('U010', 'Daniel Jiménez', 100123460, 'Investigador', 'C010', 'Cédula'),
('U011', 'Lucía Fernández', 100123461, 'Estudiante', 'C011', 'Cédula'),
('U012', 'Felipe Sánchez', 100123462, 'Estudiante', 'C012', 'Cédula'),
('U013', 'Gabriela Giraldo', 100123463, 'Docente', 'C013', 'Cédula'),
('U014', 'Martín Vargas', 100123464, 'Estudiante', 'C014', 'Tarjeta de Identidad'),
('U015', 'Sara Ospina', 100123465, 'Estudiante', 'C015', 'Cédula'),
('U016', 'Jorge Restrepo', 100123466, 'Administrativo', 'C016', 'Cédula'),
('U017', 'Daniela Valencia', 100123467, 'Estudiante', 'C017', 'Cédula'),
('U018', 'Sebastián López', 100123468, 'Investigador', 'C018', 'Pasaporte'),
('U019', 'Manuela Cardona', 100123469, 'Estudiante', 'C019', 'Cédula'),
('U020', 'Esteban Ramírez', 100123470, 'Estudiante', 'C020', 'Cédula');

UPDATE Usuario
SET rol = 'Administrador'
WHERE idUsuario IN ('U001', 'U002', 'U003');

UPDATE Usuario
SET rol = 'Cliente'
WHERE idUsuario NOT IN ('U001', 'U002', 'U003');

--Estos dos updates se hacen debido a que al pedirle datos para poblar las tablas a la inteligencia artificial ella no tenía el contexto para lo que
--Nosotros lo queriamos utilizar la columna rol, que era definir administradores y clientes

INSERT INTO Libros (idLibro, nombre, genero, seccion, añoPublicacion) VALUES 
('L001', 'Cien Años de Soledad', 'Novela', 'Estante A-1', 1967),
('L002', 'Don Quijote de la Mancha', 'Clásico', 'Estante B-3', 1605),
('L003', 'El Principito', 'Literatura Infantil', DEFAULT, 1943),
('L004', 'Crimen y Castigo', 'Novela Psicológica', 'Estante C-2', 1866),
('L005', '1984', 'Ciencia Ficción', 'Estante D-4', 1949),
('L006', 'Orgullo y Prejuicio', 'Romance', 'Estante A-2', 1813),
('L007', 'La Odisea', 'Épico', 'Estante B-1', 800),
('L008', 'El Hobbit', 'Fantasía', 'Estante C-5', 1937),
('L009', 'Fahrenheit 451', 'Ciencia Ficción', DEFAULT, 1953),
('L010', 'Cumbres Borrascosas', 'Novela', 'Estante A-3', 1847),
('L011', 'Los Miserables', 'Novela Histórica', 'Estante B-4', 1862),
('L012', 'La Metamorfosis', 'Novela', 'Estante C-1', 1915),
('L013', 'Sombra del Viento', 'Misterio', 'Estante D-1', 2001),
('L014', 'Cuentos de Eva Luna', 'Cuentos', DEFAULT, 1989),
('L015', 'Rayuela', 'Novela', 'Estante A-4', 1963),
('L016', 'El Túnel', 'Psicológico', 'Estante B-2', 1948),
('L017', 'La Vorágine', 'Novela', 'Estante C-3', 1924),
('L018', 'Pedro Páramo', 'Realismo Mágico', DEFAULT, 1955),
('L019', 'Aura', 'Fantasía', 'Estante D-2', 1962),
('L020', 'Las Batallas en el Desierto', 'Novela Corta', 'Estante A-5', 1981);

UPDATE Libros
SET ejemplares = CASE idLibro
    WHEN 'L001' THEN 5
    WHEN 'L002' THEN 3
    WHEN 'L003' THEN 10
    WHEN 'L004' THEN 4
    WHEN 'L005' THEN 7
    WHEN 'L006' THEN 6
    WHEN 'L007' THEN 2
    WHEN 'L008' THEN 8
    WHEN 'L009' THEN 5
    WHEN 'L010' THEN 4
    WHEN 'L011' THEN 3
    WHEN 'L012' THEN 6
    WHEN 'L013' THEN 9
    WHEN 'L014' THEN 5
    WHEN 'L015' THEN 4
    WHEN 'L016' THEN 3
    WHEN 'L017' THEN 2
    WHEN 'L018' THEN 6
    WHEN 'L019' THEN 7
    WHEN 'L020' THEN 5
    ELSE ejemplares -- Mantiene el valor actual si hay más libros
END
WHERE idLibro IN ('L001','L002','L003','L004','L005','L006','L007','L008','L009','L010',
                  'L011','L012','L013','L014','L015','L016','L017','L018','L019','L020');

--Se habló sobre añadir una nueva columna en la tabla Libros: "ejemplares", actúa como un stock para saber cuántos libros hay de cada uno
--Para evitar incluir una nueva poblacion pero incluyendo los datos de ejemplares se añadió el constraint de que por defecto los ejemplares estan en 0 si
--No se les asigna ningún valor, lo que nos permitió modificarlo con el UPDATE y que quedara más limpio.

INSERT INTO Prestamo (idPrestamo, idUsuario, idLibro, fechaPrestamo, fechaEntrega, cantidadLibros) VALUES 
('P001', 'U001', 'L001', '2026-02-01', '2026-02-15', 1),
('P002', 'U002', 'L002', '2026-02-03', '2026-02-17', 1),
('P003', 'U003', 'L003', '2026-02-05', '2026-02-19', 2),
('P004', 'U004', 'L004', '2026-02-10', '2026-02-24', 1),
('P005', 'U005', 'L005', '2026-02-12', '2026-02-26', 1),
('P006', 'U006', 'L006', '2026-03-01', '2026-03-15', 1),
('P007', 'U007', 'L007', '2026-03-02', '2026-03-16', 3),
('P008', 'U008', 'L008', '2026-03-04', '2026-03-18', 1),
('P009', 'U009', 'L009', '2026-03-05', '2026-03-19', 1),
('P010', 'U010', 'L010', '2026-03-10', '2026-03-24', 2),
('P011', 'U011', 'L011', '2026-04-01', '2026-04-15', 1),
('P012', 'U012', 'L012', '2026-04-03', '2026-04-17', 1),
('P013', 'U013', 'L013', '2026-04-05', '2026-04-19', 1),
('P014', 'U014', 'L014', '2026-04-08', '2026-04-22', 2),
('P015', 'U015', 'L015', '2026-04-10', '2026-04-24', 1),
('P016', 'U016', 'L016', '2026-05-01', '2026-05-15', 1),
('P017', 'U017', 'L017', '2026-05-02', '2026-05-16', 1),
('P018', 'U018', 'L018', '2026-05-04', '2026-05-18', 2),
('P019', 'U019', 'L019', '2026-05-06', '2026-05-20', 1),
('P020', 'U020', 'L020', '2026-05-10', '2026-05-24', 1);

SELECT * FROM Contacto
SELECT * FROM Usuario
SELECT * FROM Libros
SELECT * FROM Prestamo


--Listado de préstamos realizados en un rango de fechas
--Pregunta de negocio: ¿Qué libros y usuarios participaron en los préstamos realizados durante el primer semestre del año 2026?

SELECT 
    p.idPrestamo,
    u.nombre AS NombreUsuario,
    l.nombre AS TituloLibro,
    p.fechaPrestamo,
    p.fechaEntrega
FROM Prestamo p
INNER JOIN Usuario u ON p.idUsuario = u.idUsuario
INNER JOIN Libros l ON p.idLibro = l.idLibro
WHERE p.fechaPrestamo >= '2026-01-01' AND p.fechaPrestamo <= '2026-06-30';

--Cantidad de libros por género
--Pregunta de negocio: ¿Cuántos libros hay disponibles en la biblioteca clasificados por cada género literario?

SELECT 
    genero,
    COUNT(*) AS CantidadLibros
FROM Libros
GROUP BY genero

--Total de préstamos por usuario
--Pregunta de negocio: ¿Cuántos préstamos ha solicitado cada usuario a lo largo del tiempo?

SELECT
    u.nombre AS Usuario,
    u.rol,
    COUNT(p.idPrestamo) AS TotalPrestamosRealizados
FROM Usuario u
INNER JOIN Prestamo p ON u.idUsuario = p.idUsuario
GROUP BY u.nombre, u.rol;
 
 --Generos con mayor variedad de Inventario
 --Pregunta de negocio: ¿Cuáles géneros literarios tienen registrados más de 1 libro en la biblioteca?

 SELECT 
    genero,
    COUNT(*) AS CantidadLibros
FROM Libros
GROUP BY genero
HAVING COUNT(*) > 1;

--Prestamos del año actual
--Pregunta de negocio: ¿Qué usuarios han realizado préstamos especificamente en el año actual del sistema?

SELECT
    p.idPrestamo,
    u.nombre AS Usuario,
    l.nombre AS LibroPrestado,
    p.fechaPrestamo
FROM Prestamo p
INNER JOIN Usuario u ON p.idUsuario = u.idUsuario
INNER JOIN Libros l ON p.idLibro = l.idLibro
WHERE YEAR(p.fechaPrestamo) = YEAR(GETDATE());

--Total de usuarios según su rol
--Pregunta de negocio: ¿Cuál es la distribución de usuarios registrados según su rol operativo?

SELECT 
    rol AS RolEnSistema,
    COUNT(*) AS TotalUsuarios
FROM Usuario
GROUP BY rol;

GO

CREATE PROCEDURE usp_mostrarTablas
AS
BEGIN
    SET NOCOUNT ON; 
SELECT *
FROM Prestamo
END;

GO

EXEC usp_mostrarTablas

GO

CREATE OR ALTER PROCEDURE usp_mostrarTablas
AS
BEGIN
    SET NOCOUNT ON; 
    SELECT * FROM Prestamo;
END;

GO

EXEC usp_mostrarTablas;


