Ejercicio 6: Alumnos y Cursos (N:M)

-- Crear base de datos instituto con collation utf8mb4_unicode_ci
CREATE DATABASE instituto CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

ALTER DATABASE instituto CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE instituto;

-- Crear tabla profesores
CREATE TABLE profesores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla cursos
CREATE TABLE cursos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT
);

-- Crear tabla intermedia profesores_cursos
CREATE TABLE profesores_cursos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profesor_id INT UNSIGNED,
    curso_id INT UNSIGNED,
    fecha_asignacion DATE NOT NULL,
    FOREIGN KEY (profesor_id) REFERENCES profesores(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

ALTER TABLE profesores_cursos ADD COLUMN horas_clase INT;

ALTER TABLE cursos MODIFY nombre VARCHAR(200);

ALTER TABLE profesores_cursos DROP COLUMN horas_clase;

CREATE INDEX idx_nombre ON cursos(nombre);

INSERT INTO profesores (nombre) VALUES ('Juan Pérez');

-- Añadir curso "Matemáticas"
INSERT INTO cursos (nombre, descripcion) VALUES ('Matemáticas', 'Curso de álgebra y geometría');

-- Asignar profesor al curso (obteniendo los IDs)
INSERT INTO profesores_cursos (profesor_id, curso_id, fecha_asignacion)
VALUES (
    (SELECT id FROM profesores WHERE nombre = 'Juan Pérez'),
    (SELECT id FROM cursos WHERE nombre = 'Matemáticas'),
    CURDATE()
);

INSERT INTO profesores (nombre) VALUES ('Ana Rodríguez'), ('Luis Gómez');

-- Añadir tres cursos adicionales
INSERT INTO cursos (nombre, descripcion) VALUES 
('Física', 'Curso de física básica'),
('Historia', 'Historia universal'),
('Química', 'Fundamentos de química');

-- Asignar profesores a distintos cursos (ejemplos)
INSERT INTO profesores_cursos (profesor_id, curso_id, fecha_asignacion) VALUES
(2, 2, CURDATE()), -- Ana Rodríguez enseña Física
(2, 4, CURDATE()), -- Ana Rodríguez enseña Química
(3, 3, CURDATE()); -- Luis Gómez enseña Historia

-- Consultar todos los cursos en los que imparte "Juan Pérez"
SELECT c.nombre, c.descripcion 
FROM cursos c
JOIN profesores_cursos pc ON c.id = pc.curso_id
JOIN profesores p ON p.id = pc.profesor_id
WHERE p.nombre = 'Juan Pérez';

SELECT p.nombre
FROM profesores p
JOIN profesores_cursos pc ON p.id = pc.profesor_id
JOIN cursos c ON c.id = pc.curso_id
WHERE c.nombre = 'Matemáticas';

DELETE FROM profesores_cursos 
WHERE profesor_id = (SELECT id FROM profesores WHERE nombre = 'Ana Rodríguez')
AND curso_id = (SELECT id FROM cursos WHERE nombre = 'Química');

DELETE FROM profesores_cursos WHERE profesor_id = 3;
DELETE FROM profesores WHERE id = 3;

DROP DATABASE instituto;