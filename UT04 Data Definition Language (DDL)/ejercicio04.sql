Ejercicio 4: Departamento con empleados (1:N)

-- Crear la base de datos universidad con collation utf8mb4_unicode_ci
CREATE DATABASE universidad CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Cambiar el collation de la base de datos a utf8mb4_general_ci
ALTER DATABASE universidad CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Usar la base de datos universidad
USE universidad;

-- Crear la tabla alumnos
CREATE TABLE alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear la tabla asignaturas
CREATE TABLE asignaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear la tabla intermedia matriculas
CREATE TABLE matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT UNSIGNED NOT NULL,
    asignatura_id INT UNSIGNED NOT NULL,
    fecha_matricula DATE NOT NULL,
    FOREIGN KEY (alumno_id) REFERENCES alumnos(id),
    FOREIGN KEY (asignatura_id) REFERENCES asignaturas(id)
);

-- Modificar la tabla matriculas para agregar una columna nota
ALTER TABLE matriculas ADD COLUMN nota DECIMAL(4,2);

-- Cambiar el tamaño del campo nombre en la tabla asignaturas a 150 caracteres
ALTER TABLE asignaturas MODIFY nombre VARCHAR(150);

-- Eliminar la columna nota de la tabla matriculas
ALTER TABLE matriculas DROP COLUMN nota;

-- Añadir un índice a la columna nombre en la tabla asignaturas
CREATE INDEX idx_nombre ON asignaturas(nombre);

-- Insertar un alumno llamado "Luis Gómez"
INSERT INTO alumnos (nombre) VALUES ('Luis Gómez');

-- Añadir una asignatura llamada "Matemáticas"
INSERT INTO asignaturas (nombre) VALUES ('Matemáticas');

-- Matricular al alumno en Matemáticas con fecha de matrícula de hoy
INSERT INTO matriculas (alumno_id, asignatura_id, fecha_matricula)
VALUES (1, 1, CURDATE());

-- Insertar dos alumnos adicionales
INSERT INTO alumnos (nombre) VALUES ('María Fernández'), ('Carlos Ruiz');

-- Añadir tres asignaturas adicionales
INSERT INTO asignaturas (nombre) VALUES ('Física'), ('Historia'), ('Química');

-- Matricular a los alumnos en distintas asignaturas
INSERT INTO matriculas (alumno_id, asignatura_id, fecha_matricula)
VALUES (2, 2, CURDATE()), (3, 3, CURDATE());

-- Consultar todas las asignaturas en las que está inscrito el alumno "Luis Gómez"
SELECT asignaturas.nombre
FROM asignaturas
JOIN matriculas ON asignaturas.id = matriculas.asignatura_id
JOIN alumnos ON matriculas.alumno_id = alumnos.id
WHERE alumnos.nombre = 'Luis Gómez';

-- Consultar todos los alumnos que están inscritos en la asignatura "Matemáticas"
SELECT alumnos.nombre
FROM alumnos
JOIN matriculas ON alumnos.id = matriculas.alumno_id
JOIN asignaturas ON matriculas.asignatura_id = asignaturas.id
WHERE asignaturas.nombre = 'Matemáticas';

-- Eliminar la inscripción de un alumno en una asignatura específica
DELETE FROM matriculas WHERE alumno_id = 1 AND asignatura_id = 1;

-- Eliminar un alumno y sus matrículas asociadas
DELETE FROM alumnos WHERE id = 1;

-- Eliminar la base de datos universidad
DROP DATABASE universidad;