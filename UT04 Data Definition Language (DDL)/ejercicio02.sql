-- Ejercicio 1: Usuarios y Direcciones (Relación Uno a Uno 1:1)

-- 1. Crear la base de datos `usuarios_db` con collation `utf8mb4_unicode_ci`
CREATE DATABASE usuarios_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Seleccionar la base de datos `usuarios_db`
USE usuarios_db;

-- 3. Modificar la collation de la base de datos `usuarios_db` a `utf8mb4_general_ci`
ALTER DATABASE usuarios_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 4. Crear la tabla `usuarios`
CREATE TABLE usuarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Campo 'id' como clave primaria autoincremental.
    nombre VARCHAR(100) NOT NULL -- Campo 'nombre' de tipo VARCHAR con un máximo de 100 caracteres.
);

-- 5. Crear la tabla `direcciones`
CREATE TABLE direcciones (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Campo 'id' como clave primaria autoincremental.
    usuario_id INT UNSIGNED UNIQUE, -- Campo 'usuario_id' como clave foránea y único.
    direccion VARCHAR(255) NOT NULL, -- Campo 'direccion' de tipo VARCHAR con un máximo de 255 caracteres.
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) -- Define 'usuario_id' como clave foránea que referencia a 'usuarios(id)'.
);

-- 6. Modificar la tabla `direcciones` para que `usuario_id` sea clave primaria y foránea
ALTER TABLE direcciones DROP PRIMARY KEY, ADD PRIMARY KEY (usuario_id);

-- 7. Cambiar el tamaño del campo `nombre` en la tabla `usuarios` a 150 caracteres
ALTER TABLE usuarios MODIFY nombre VARCHAR(150) NOT NULL;

-- 8. Agregar una nueva columna `telefono` de tipo `VARCHAR(15)` después del campo `nombre`
ALTER TABLE usuarios ADD COLUMN telefono VARCHAR(15) AFTER nombre;

-- 9. Cambiar el tipo de dato de `telefono` a `BIGINT`
ALTER TABLE usuarios MODIFY telefono BIGINT;

-- 10. Eliminar la columna `telefono` de la tabla `usuarios`
ALTER TABLE usuarios DROP COLUMN telefono;

-- 11. Insertar un usuario llamado "Juan Pérez"
INSERT INTO usuarios (nombre) VALUES ('Juan Pérez');

-- 12. Insertar una dirección "Calle Mayor 123" para el usuario "Juan Pérez"
INSERT INTO direcciones (usuario_id, direccion) VALUES (1, 'Calle Mayor 123');

-- 13. Insertar dos usuarios adicionales ("Ana Gómez" y "Carlos Ruiz")
INSERT INTO usuarios (nombre) VALUES ('Ana Gómez'), ('Carlos Ruiz');

-- 14. Añadir direcciones para los nuevos usuarios
INSERT INTO direcciones (usuario_id, direccion) VALUES 
(2, 'Calle Secundaria 456'), -- Dirección para Ana Gómez.
(3, 'Avenida Principal 789'); -- Dirección para Carlos Ruiz.

-- 15. Consultar todas las direcciones junto con el nombre del usuario
SELECT u.nombre, d.direccion 
FROM usuarios u 
JOIN direcciones d ON u.id = d.usuario_id;

-- 16. Mostrar todos los usuarios que no tienen dirección registrada
SELECT u.nombre 
FROM usuarios u 
LEFT JOIN direcciones d ON u.id = d.usuario_id 
WHERE d.usuario_id IS NULL;

-- 17. Actualizar la dirección de "Juan Pérez" a "Avenida Central 456"
UPDATE direcciones 
SET direccion = 'Avenida Central 456' 
WHERE usuario_id = 1;

-- 18. Eliminar la dirección de "Carlos Ruiz"
DELETE FROM direcciones WHERE usuario_id = 3;

-- 19. Consultar la estructura de la tabla `direcciones`
DESCRIBE direcciones;

-- 20. Eliminar las tablas `direcciones` y `usuarios`
DROP TABLE direcciones, usuarios;

-- 21. Eliminar la base de datos `usuarios_db`
DROP DATABASE usuarios_db;

-- Ejercicio 2: Gestión de Clientes y Pedidos (Relación Uno a Muchos - 1:N)

-- 1. Crear la base de datos `hospital` con collation `utf8mb4_unicode_ci`
CREATE DATABASE hospital CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Seleccionar la base de datos `hospital`
USE hospital;

-- 3. Modificar la collation de la base de datos `hospital` a `utf8mb4_general_ci`
ALTER DATABASE hospital CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 4. Crear la tabla `pacientes`
CREATE TABLE pacientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Campo 'id' como clave primaria autoincremental.
    nombre VARCHAR(100) NOT NULL -- Campo 'nombre' de tipo VARCHAR con un máximo de 100 caracteres.
);

-- 5. Crear la tabla `historias_clinicas`
CREATE TABLE historias_clinicas (
    paciente_id INT UNSIGNED PRIMARY KEY, -- Campo 'paciente_id' como clave primaria.
    diagnostico TEXT NOT NULL, -- Campo 'diagnostico' de tipo TEXT.
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Campo 'fecha_registro' con valor por defecto.
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) -- Define 'paciente_id' como clave foránea.
);

-- 6. Modificar la tabla `historias_clinicas` agregando una columna `tratamiento` de tipo `TEXT`
ALTER TABLE historias_clinicas ADD COLUMN tratamiento TEXT;

-- 7. Cambiar el tamaño del campo `nombre` en la tabla `pacientes` a 150 caracteres
ALTER TABLE pacientes MODIFY nombre VARCHAR(150) NOT NULL;

-- 8. Agregar una nueva columna `telefono` de tipo `VARCHAR(15)` después del campo `nombre`
ALTER TABLE pacientes ADD COLUMN telefono VARCHAR(15) AFTER nombre;

-- 9. Cambiar el tipo de dato de `telefono` a `BIGINT`
ALTER TABLE pacientes MODIFY telefono BIGINT;

-- 10. Eliminar la columna `telefono` de la tabla `pacientes`
ALTER TABLE pacientes DROP COLUMN telefono;

-- 11. Insertar un paciente llamado "Juan Pérez"
INSERT INTO pacientes (nombre) VALUES ('Juan Pérez');

-- 12. Insertar una historia clínica con diagnóstico "Hipertensión" para el paciente "Juan Pérez"
INSERT INTO historias_clinicas (paciente_id, diagnostico) VALUES (1, 'Hipertensión');

-- 13. Insertar dos pacientes adicionales ("Ana Gómez" y "Carlos Ruiz")
INSERT INTO pacientes (nombre) VALUES ('Ana Gómez'), ('Carlos Ruiz');

-- 14. Añadir historias clínicas para los nuevos pacientes
INSERT INTO historias_clinicas (paciente_id, diagnostico) VALUES 
(2, 'Diabetes'), -- Historia clínica para Ana Gómez.
(3, 'Asma'); -- Historia clínica para Carlos Ruiz.

-- 15. Consultar todas las historias clínicas junto con el nombre del paciente
SELECT p.nombre, h.diagnostico 
FROM pacientes p 
JOIN historias_clinicas h ON p.id = h.paciente_id;

-- 16. Mostrar todos los pacientes que no tienen historia clínica registrada
SELECT p.nombre 
FROM pacientes p 
LEFT JOIN historias_clinicas h ON p.id = h.paciente_id 
WHERE h.paciente_id IS NULL;

-- 17. Actualizar el diagnóstico de "Juan Pérez" a "Hipertensión crónica"
UPDATE historias_clinicas 
SET diagnostico = 'Hipertensión crónica' 
WHERE paciente_id = 1;

-- 18. Eliminar la historia clínica de "Carlos Ruiz"
DELETE FROM historias_clinicas WHERE paciente_id = 3;

-- 19. Consultar la estructura de la tabla `historias_clinicas`
DESCRIBE historias_clinicas;

-- 20. Eliminar las tablas `historias_clinicas` y `pacientes`
DROP TABLE historias_clinicas, pacientes;

-- 21. Eliminar la base de datos `hospital`
DROP DATABASE hospital;