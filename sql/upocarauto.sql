-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-05-2025 a las 16:16:26
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `upocarauto`
--
CREATE DATABASE IF NOT EXISTS `upocarauto` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE `upocarauto`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `dni` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `fecha_registro` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`dni`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `telefono` (`telefono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`dni`, `nombre`, `apellidos`, `email`, `telefono`, `direccion`, `fecha_registro`) VALUES
('21098765S', 'David', 'Campos Muñoz', 'david.campos@mail.com', '666333333', 'C/ Triana 8, Sevilla', '2025-05-17'),
('32109876T', 'María', 'Lara Serrano', 'maria.lara@mail.com', '666222222', 'C/ Macarena 5, Sevilla', '2025-05-17'),
('43210987U', 'Raúl', 'Ortega Navas', 'raul.ortega@mail.com', '666111111', 'C/ Betis 25, Sevilla', '2025-05-17'),
('54321098V', 'Ainhoa', 'Alday Menchaca', 'ainhoa.alday@mail.com', '655555555', 'C/ Deusto 3, Bilbao', '2025-05-05'),
('65432109W', 'Lucía', 'Moya Sanchís', 'lucia.moya@mail.com', '644444444', 'C/ Colón 60, Valencia', '2025-05-04'),
('76543210X', 'Sergio', 'Nadal Puig', 'sergio.nadal@mail.com', '633333333', 'C/ Aragón 25, BCN', '2025-05-03'),
('87654321Y', 'Elena', 'Gómez Torres', 'elena.gomez@mail.com', '622222222', 'C/ Atocha 210, Madrid', '2025-05-02'),
('98765432Z', 'Carlos', 'Ruiz Romero', 'carlos.ruiz@mail.com', '611111111', 'C/ Sol 10, Sevilla', '2025-05-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `concesionario`
--

DROP TABLE IF EXISTS `concesionario`;
CREATE TABLE IF NOT EXISTS `concesionario` (
  `id_concesionario` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `correo` varchar(150) NOT NULL,
  PRIMARY KEY (`id_concesionario`),
  UNIQUE KEY `telefono` (`telefono`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `concesionario`
--

INSERT INTO `concesionario` (`id_concesionario`, `nombre`, `direccion`, `telefono`, `correo`) VALUES
(1, 'AutoSur Sevilla', 'Av. de Andalucía 15, Sevilla', '954000001', 'contacto@autosursev.es'),
(2, 'Madrid Motor', 'C/ Alcalá 450, Madrid', '913000002', 'info@madridmotor.es'),
(3, 'Barcelona Cars', 'Pg. de Gràcia 120, Barcelona', '932000003', 'ventas@barcelonacars.es'),
(4, 'Valencia Wheels', 'Av. del Puerto 250, Valencia', '963000004', 'hola@valenciawheels.es'),
(5, 'Bilbao Drive', 'Gran Vía 85, Bilbao', '944000005', 'ventas@bilbaodrive.es');

-- --------------------------------------------------------

/* ===============================================================
   TABLA EMPLEADO (añadimos columna `contrasenya`)
   =============================================================== */
DROP TABLE IF EXISTS `empleado`;

CREATE TABLE IF NOT EXISTS `empleado` (
  `dni`              VARCHAR(20)  NOT NULL,
  `nombre`           VARCHAR(100) NOT NULL,
  `apellidos`        VARCHAR(150) NOT NULL,
  `email`            VARCHAR(150) NOT NULL,
  `telefono`         VARCHAR(15)  NOT NULL,
  `direccion`        VARCHAR(250) NOT NULL,
  `puesto`           VARCHAR(100) NOT NULL,
  `contrasenya`      VARCHAR(255) NOT NULL,     -- NUEVO CAMPO
  `id_concesionario` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`dni`),
  UNIQUE KEY `email`    (`email`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `id_concesionario` (`id_concesionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/* ===============================================================
   DATOS DE PRUEBA (incluyen la nueva columna `contrasenya`)
   =============================================================== */
INSERT INTO `empleado`
  (`dni`,`nombre`,`apellidos`,`email`,`telefono`,`direccion`,`puesto`,`contrasenya`,`id_concesionario`)
VALUES
('12345678A','Luis' ,'García López'    ,'luis.garcia@autosursev.es' ,'600111111','C/ Feria 12, Sevilla'   ,'Vendedor' ,'Pwd_Luis!2025' ,1),
('23456789B','Marta','Sánchez Ruiz'    ,'marta.sanchez@madridmotor.es','600222222','C/ Goya 33, Madrid'     ,'Gerente'  ,'Pwd_Marta!2025',2),
('34567890C','Pablo','Martín Pérez'    ,'pablo.martin@barcelonacars.es','600333333','C/ Sants 5, Barcelona'  ,'Mecánico' ,'Pwd_Pablo!2025',3),
('45678901D','Ana'  ,'López Díaz'      ,'ana.lopez@valenciawheels.es','600444444','C/ Ruzafa 9, Valencia'   ,'Vendedora','Pwd_Ana!2025'  ,4),
('56789012E','Jon'  ,'Echevarría Olaiz','jon.echevarria@bilbaodrive.es','600555555','C/ Indautxu 7, Bilbao'  ,'Vendedor' ,'Pwd_Jon!2025'  ,5);


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

DROP TABLE IF EXISTS `inventario`;
CREATE TABLE IF NOT EXISTS `inventario` (
  `id_inventario` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_concesionario` int(10) UNSIGNED NOT NULL,
  `dni_empleado` varchar(20) NOT NULL,
  `total_vehiculos` int(11) NOT NULL DEFAULT 0 CHECK (`total_vehiculos` >= 0),
  `ultima_actualizacion` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`id_inventario`),
  UNIQUE KEY `id_concesionario` (`id_concesionario`),
  KEY `dni_empleado` (`dni_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `id_concesionario`, `dni_empleado`, `total_vehiculos`, `ultima_actualizacion`) VALUES
(1, 1, '12345678A', 4, '2025-05-17'),
(2, 2, '23456789B', 1, '2025-05-17'),
(3, 3, '34567890C', 1, '2025-05-17'),
(4, 4, '45678901D', 1, '2025-05-17'),
(5, 5, '56789012E', 1, '2025-05-17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

DROP TABLE IF EXISTS `pago`;
CREATE TABLE IF NOT EXISTS `pago` (
  `id_pago` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_reserva` int(10) UNSIGNED NOT NULL,
  `fecha_pago` date NOT NULL DEFAULT curdate(),
  `precio_total` decimal(12,2) NOT NULL CHECK (`precio_total` > 0),
  `metodo_pago` varchar(20) NOT NULL CHECK (`metodo_pago` in ('Tarjeta','Bizum','Transferencia')),
  `estado_pago` varchar(20) NOT NULL CHECK (`estado_pago` in ('Pendiente','Completado','Fallido','Cancelado')),
  PRIMARY KEY (`id_pago`),
  KEY `id_reserva` (`id_reserva`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`id_pago`, `id_reserva`, `fecha_pago`, `precio_total`, `metodo_pago`, `estado_pago`) VALUES
(1, 1, '2025-05-15', 10500.00, 'Tarjeta', 'Pendiente'),
(2, 2, '2025-05-15', 11500.00, 'Bizum', 'Completado'),
(3, 3, '2025-05-16', 3000.00, 'Tarjeta', 'Pendiente'),
(4, 4, '2025-05-16', 500.00, 'Transferencia', 'Fallido'),
(5, 5, '2025-05-16', 2000.00, 'Bizum', 'Pendiente'),
(6, 6, '2025-05-17', 13500.00, 'Tarjeta', 'Pendiente'),
(7, 7, '2025-05-17', 9900.00, 'Bizum', 'Pendiente'),
(8, 8, '2025-05-17', 11000.00, 'Transferencia', 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_transaccion`
--

DROP TABLE IF EXISTS `pago_transaccion`;
CREATE TABLE IF NOT EXISTS `pago_transaccion` (
  `id_pago` int(10) UNSIGNED NOT NULL,
  `id_transaccion` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pago`,`id_transaccion`),
  KEY `id_transaccion` (`id_transaccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `pago_transaccion`
--

INSERT INTO `pago_transaccion` (`id_pago`, `id_transaccion`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

DROP TABLE IF EXISTS `reserva`;
CREATE TABLE IF NOT EXISTS `reserva` (
  `id_reserva` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dni_cliente` varchar(20) NOT NULL,
  `matricula` varchar(20) NOT NULL,
  `estado` varchar(20) NOT NULL CHECK (`estado` in ('Pendiente','Confirmada','Rechazada','Cancelada','Finalizada')),
  `fecha_creacion` date NOT NULL DEFAULT curdate(),
  `fecha_recogida` date DEFAULT NULL,
  PRIMARY KEY (`id_reserva`),
  UNIQUE KEY `matricula` (`matricula`),
  KEY `dni_cliente` (`dni_cliente`)
) ;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO reserva
(dni_cliente,matricula,estado,fecha_creacion,fecha_recogida) VALUES
('98765432Z','1234ABC','Pendiente' ,'2025-05-10','2025-05-20'),
('87654321Y','2345DEF','Confirmada','2025-05-11','2025-05-22'),
('76543210X','3456GHI','Pendiente' ,'2025-05-12',NULL),
('65432109W','4567JKL','Rechazada' ,'2025-05-13',NULL),
('54321098V','5678MNO','Pendiente' ,'2025-05-14','2025-05-25'),
('43210987U','1122PQR','Pendiente' ,'2025-05-17','2025-05-28'),
('32109876T','3344STU','Pendiente' ,'2025-05-17',NULL),
('21098765S','5566VWX','Confirmada','2025-05-17','2025-05-25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion`
--

DROP TABLE IF EXISTS `transaccion`;
CREATE TABLE IF NOT EXISTS `transaccion` (
  `id_transaccion` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_transaccion` date NOT NULL DEFAULT curdate(),
  `precio` decimal(12,2) NOT NULL CHECK (`precio` > 0),
  `metodo_pago` varchar(20) NOT NULL CHECK (`metodo_pago` in ('Tarjeta','Bizum','Transferencia')),
  `estado` varchar(20) NOT NULL CHECK (`estado` in ('Completada','Pendiente','Cancelada')),
  PRIMARY KEY (`id_transaccion`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `transaccion`
--

INSERT INTO `transaccion` (`id_transaccion`, `fecha_transaccion`, `precio`, `metodo_pago`, `estado`) VALUES
(1, '2025-05-15', 10500.00, 'Tarjeta', 'Pendiente'),
(2, '2025-05-15', 11500.00, 'Bizum', 'Completada'),
(3, '2025-05-16', 3000.00, 'Tarjeta', 'Pendiente'),
(4, '2025-05-16', 500.00, 'Transferencia', 'Cancelada'),
(5, '2025-05-16', 2000.00, 'Bizum', 'Pendiente'),
(6, '2025-05-17', 13500.00, 'Tarjeta', 'Pendiente'),
(7, '2025-05-17', 9900.00, 'Bizum', 'Pendiente'),
(8, '2025-05-17', 11000.00, 'Transferencia', 'Completada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
CREATE TABLE IF NOT EXISTS `vehiculo` (
  `matricula` varchar(20) NOT NULL,
  `id_inventario` int(10) UNSIGNED DEFAULT NULL, -- MODIFICADO: Permite NULL
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `anio` int(11) NOT NULL CHECK (`anio` >= 1900),
  `precio` decimal(12,2) NOT NULL CHECK (`precio` > 0),
  `estado` varchar(20) NOT NULL CHECK (`estado` in ('Nuevo','Usado','Reservado')),
  `disponibilidad` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`matricula`),
  KEY `id_inventario` (`id_inventario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO vehiculo
(matricula,id_inventario,marca,modelo,anio,precio,estado,disponibilidad) VALUES
('1234ABC',1,'Seat'      ,'Ibiza' ,2019,10500.00,'Usado',1),
('2345DEF',2,'Renault'   ,'Clio'  ,2020,11500.00,'Usado',1),
('3456GHI',3,'Peugeot'   ,'208'   ,2021,12500.00,'Usado',1),
('4567JKL',4,'Volkswagen','Polo'  ,2018, 9500.00,'Usado',1),
('5678MNO',5,'Opel'      ,'Corsa' ,2019,10800.00,'Usado',1),
('1122PQR',1,'Ford'      ,'Focus' ,2021,13500.00,'Usado',1),
('3344STU',1,'Citroën'   ,'C3'    ,2019, 9900.00,'Usado',1),
('5566VWX',1,'Hyundai'   ,'i20'   ,2020,11000.00,'Usado',1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_concesionario`) REFERENCES `concesionario` (`id_concesionario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_concesionario`) REFERENCES `concesionario` (`id_concesionario`),
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`dni_empleado`) REFERENCES `empleado` (`dni`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reserva` (`id_reserva`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pago_transaccion`
--
ALTER TABLE `pago_transaccion`
  ADD CONSTRAINT `pago_transaccion_ibfk_1` FOREIGN KEY (`id_pago`) REFERENCES `pago` (`id_pago`) ON DELETE CASCADE,
  ADD CONSTRAINT `pago_transaccion_ibfk_2` FOREIGN KEY (`id_transaccion`) REFERENCES `transaccion` (`id_transaccion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reserva`
--

ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`dni_cliente`) REFERENCES `cliente` (`dni`) ON DELETE CASCADE,
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`matricula`) REFERENCES `vehiculo` (`matricula`) ON DELETE CASCADE;

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD CONSTRAINT `vehiculo_ibfk_1`  FOREIGN KEY (`id_inventario`) REFERENCES `inventario` (`id_inventario`) ON DELETE CASCADE;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
