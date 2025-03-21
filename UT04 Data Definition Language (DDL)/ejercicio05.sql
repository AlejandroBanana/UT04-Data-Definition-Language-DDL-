Ejercicio 5 Actores y Películas (Relación N:M)

-- 1. Crear la base de datos cine con collation utf8mb4_unicode_ci
CREATE DATABASE cine CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

ALTER DATABASE cine CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE cine;

-- 2. Crear la tabla actores
CREATE TABLE actores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- 3. Crear la tabla peliculas
CREATE TABLE peliculas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    anio_estreno YEAR NOT NULL
);

-- 4. Crear la tabla intermedia actores_peliculas
CREATE TABLE actores_peliculas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    actor_id INT UNSIGNED,
    pelicula_id INT UNSIGNED,
    personaje VARCHAR(100) NOT NULL,
    FOREIGN KEY (actor_id) REFERENCES actores(id),
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(id)
);

ALTER TABLE actores_peliculas ADD COLUMN salario DECIMAL(10,2);

ALTER TABLE actores MODIFY nombre VARCHAR(150);

ALTER TABLE actores_peliculas DROP COLUMN salario;

CREATE INDEX idx_titulo ON peliculas(titulo);

INSERT INTO actores (nombre) VALUES ('Leonardo DiCaprio');

INSERT INTO peliculas (titulo, anio_estreno) VALUES ('Titanic', 1997);

-- 5. Registrar la participación de "Leonardo DiCaprio" en "Titanic" como el personaje "Jack Dawson"
INSERT INTO actores_peliculas (actor_id, pelicula_id, personaje) 
VALUES (
    (SELECT id FROM actores WHERE nombre = 'Leonardo DiCaprio'),
    (SELECT id FROM peliculas WHERE titulo = 'Titanic'),
    'Jack Dawson'
);

INSERT INTO actores (nombre) VALUES ('Kate Winslet'), ('Tom Hanks');

INSERT INTO peliculas (titulo, anio_estreno) VALUES 
('Forrest Gump', 1994),
('Avatar', 2009),
('Inception', 2010);

-- 6. Registrar la participación de actores en distintas películas
INSERT INTO actores_peliculas (actor_id, pelicula_id, personaje) 
VALUES 
(
    (SELECT id FROM actores WHERE nombre = 'Kate Winslet'),
    (SELECT id FROM peliculas WHERE titulo = 'Titanic'),
    'Rose DeWitt Bukater'
),
(
    (SELECT id FROM actores WHERE nombre = 'Tom Hanks'),
    (SELECT id FROM peliculas WHERE titulo = 'Forrest Gump'),
    'Forrest Gump'
);

-- 7. Consultar todas las películas en las que ha trabajado "Leonardo DiCaprio"
SELECT p.titulo 
FROM peliculas p
JOIN actores_peliculas ap ON p.id = ap.pelicula_id
JOIN actores a ON ap.actor_id = a.id
WHERE a.nombre = 'Leonardo DiCaprio';

-- 8. Consultar todos los actores que han participado en la película "Titanic"
SELECT a.nombre 
FROM actores a
JOIN actores_peliculas ap ON a.id = ap.actor_id
JOIN peliculas p ON ap.pelicula_id = p.id
WHERE p.titulo = 'Titanic';

-- 8. Eliminar la participación de un actor en una película específica
DELETE FROM actores_peliculas 
WHERE actor_id = (SELECT id FROM actores WHERE nombre = 'Leonardo DiCaprio')
AND pelicula_id = (SELECT id FROM peliculas WHERE titulo = 'Titanic');

-- 9. Eliminar un actor y sus registros de películas
DELETE FROM actores_peliculas WHERE actor_id = (SELECT id FROM actores WHERE nombre = 'Tom Hanks');
DELETE FROM actores WHERE nombre = 'Tom Hanks';

DROP DATABASE cine;