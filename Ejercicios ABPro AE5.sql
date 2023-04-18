/*
Ejercicios ABPro AE5
Alexis Campusano
Fernanda Fajre
Christopher Figueroa
*/

-- Creacion base de datos y usuario.
CREATE DATABASE telovendo2;
USE telovendo2;
CREATE USER 'admin_tlv'@'localhost' IDENTIFIED BY '1235';
GRANT ALL PRIVILEGES ON TLVCoins.* TO 'admin_tlv'@'localhost';

-- Nos aseguramos que el UTC usado sea UTC-3
SET time_zone = '-03:00';

-- Creacion tablas
CREATE TABLE usuarios (
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(255) NOT NULL,
apellido VARCHAR(255) NOT NULL,
contraseña VARCHAR(20) NOT NULL,
zona_horaria TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
genero VARCHAR(100) NOT NULL,
telefono_contacto VARCHAR(50) NOT NULL);

CREATE TABLE ingresos (
id_ingreso INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_usuario INT NOT NULL,
fecha_hora_ingresos DATETIME,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);


-- Modifique el UTC por defecto.Desde UTC-3 a UTC-2.
SET time_zone = '-02:00';
-- Esto modifica la columna zona_horaria y los registro dentro de esta, cambiando la hora de CURRENT_TIMESTAMP.

-- Para cada tabla crea 8 registros.
INSERT INTO usuarios (nombre, apellido, contraseña, zona_horaria, genero, telefono_contacto) VALUES
('Juan', 'Pérez', '123456', CURRENT_TIMESTAMP, 'Masculino', '12345678'),
('María', 'González', 'abcdef', CURRENT_TIMESTAMP, 'Femenino', '87654321'),
('Pedro', 'Rodríguez', 'qwerty', CURRENT_TIMESTAMP, 'Masculino', '55555555'),
('Ana', 'Sánchez', 'zxcvbn', CURRENT_TIMESTAMP, 'Femenino', '99999999'),
('Carlos', 'García', 'asdfgh', CURRENT_TIMESTAMP, 'Masculino', '11111111'),
('Lucía', 'Hernández', 'poiuyt', CURRENT_TIMESTAMP, 'Femenino', '22222222'),
('Jorge', 'Martínez', 'lkjhgf', CURRENT_TIMESTAMP, 'Masculino', '44444444'),
('Laura', 'Díaz', 'mnbvcx', CURRENT_TIMESTAMP, 'Femenino', '33333333');

INSERT INTO ingresos (id_usuario, fecha_hora_ingresos)
VALUES
  (1, '2023-04-17 08:00:00'),
  (2, '2023-04-01 12:30:00'),
  (3, '2023-03-28 09:15:00'),
  (4, '2023-04-10 11:45:00'),
  (5, '2023-04-03 22:00:00'),
  (6, '2023-02-02 13:00:00'),
  (7, '2023-02-26 08:30:00'),
  (8, '2023-03-05 16:00:00');

SELECT * FROM usuarios;
SELECT * FROM ingresos;

-- Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
/*

-- Tabla usuarios
id_usuario: INT PRIMARY KEY AUTO_INCREMENT
Este campo es utilizado para identificar a cada usuario de manera única. Permite almacenar números enteros hasta 2,147,483,647. 
Además, la opción AUTO_INCREMENT es utilizada para que el valor se genere automáticamente al insertar un nuevo registro, asegurando que cada id sea único.

nombre: VARCHAR(255) NOT NULL
El campo nombre es utilizado para almacenar el nombre del usuario. VARCHAR permite almacenar cadenas de caracteres de longitud variable
hasta un máximo de 255 caracteres. NOT NULL se utiliza para garantizar que siempre se proporcione un valor para este campo.
 
apellido: VARCHAR(255) NOT NULL
Este campo almacena el apellido del usuario. Al igual que el campo nombre, se utiliza el tipo de dato VARCHAR(255)
para permitir la longitud variable y NOT NULL para asegurar que siempre se proporcione un valor.

contraseña: VARCHAR(20) NOT NULL
Este campo almacena la contraseña del usuario. VARCHAR(20) es el tipo de dato adecuado para este campo, 
ya que la mayoría de las contraseñas son cadenas de caracteres alfanuméricos que suelen tener una longitud relativamente corta. 
NOT NULL se utiliza para garantizar que siempre se proporcione una contraseña.

zona_horaria: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
Este campo almacena la zona horaria del usuario en la que se encuentra. TIMESTAMP almacena la fecha y la hora exacta en la que se inserta un registro.
DEFAULT CURRENT_TIMESTAMP se utiliza para que este campo se actualice automáticamente cada vez que se inserta un nuevo registro.
 
genero: VARCHAR(100) NOT NULL
Este campo almacena el género del usuario. VARCHAR(100) permite almacenar cadenas de caracteres de longitud variable hasta un máximo de 100 caracteres. 
NOT NULL se utiliza para garantizar que siempre se proporcione un valor para este campo.
 
telefono_contacto: VARCHAR(50) NOT NULL
Este campo almacena el número de teléfono del usuario. VARCHAR(50) con los números de teléfono pueden variar en longitud dependiendo del país. 
NOT NULL se utiliza para garantizar que siempre se proporcione un número de teléfono.

-- Tabla ingresos
id_ingreso: INT PRIMARY KEY AUTO_INCREMENT NOT NULL
Este campo es utilizado como clave primaria de la tabla y se utiliza la opción AUTO_INCREMENT para que se genere automáticamente 
el valor del id_ingreso al insertar un nuevo registro. El tipo de dato INT permite almacenar números enteros hasta 2,147,483,647. 

id_usuario: INT NOT NULL
Este campo se utiliza para relacionar cada ingreso con el usuario correspondiente mediante una clave foránea. El tipo de dato INT  permite almacenar 
números enteros hasta 2,147,483,647. NOT NULL se utiliza para garantizar que siempre se proporcione un valor para este campo.

fecha_hora_ingresos: DATETIME
Este campo almacena la fecha y hora en la que se registró cada ingreso. DATETIME es el tipo de dato adecuado para este campo ya que permite almacenar
 valores de fecha y hora con una precisión de segundos.

/* Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono,
correo electronico).
*/
 CREATE TABLE contactos (
 id_contacto INT PRIMARY KEY AUTO_INCREMENT,
 id_usuario INT NOT NULL,
 numero_telefono VARCHAR(50) NOT NULL,
 correo_electronico VARCHAR(100) NOT NULL,
 FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
 );
 

 /* Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la
tabla Contactos. */

ALTER TABLE usuarios
DROP COLUMN telefono_contacto;

ALTER TABLE contactos
DROP CONSTRAINT contactos_ibfk_1;

ALTER TABLE contactos
DROP COLUMN id_usuario;

ALTER TABLE contactos
ADD CONSTRAINT fk_contactos_usuarios
FOREIGN KEY (id_contacto) REFERENCES usuarios(id_usuario);

/* Eliminamos de la tabla usuarios la columna telefono_contacto ya que esta informacion ahora esta en la tabla contactos
y cambiamos la forma de referenciarse una tabla con la otra, al vincular directamente la columna id_contacto de la tabla contactos
con la columna id_usuario de la tabla usuarios.
*/

-- El ejercicio debe ser subido a github
