-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.24-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para cinemar
CREATE DATABASE IF NOT EXISTS `cinemar` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `cinemar`;

-- Volcando estructura para tabla cinemar.butacas
CREATE TABLE IF NOT EXISTS `butacas` (
  `idButacas` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` int(11) DEFAULT NULL,
  `idSala` int(11) DEFAULT NULL,
  PRIMARY KEY (`idButacas`),
  KEY `FK_butacas_butacas` (`idSala`),
  CONSTRAINT `FK_butacas_butacas` FOREIGN KEY (`idSala`) REFERENCES `sala` (`idSala`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.butacas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `butacas` DISABLE KEYS */;
/*!40000 ALTER TABLE `butacas` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.cartelera
CREATE TABLE IF NOT EXISTS `cartelera` (
  `idCartelera` int(11) NOT NULL AUTO_INCREMENT,
  `hora` date DEFAULT NULL,
  `idPelicula` int(11) DEFAULT NULL,
  `idSala` int(11) DEFAULT NULL,
  `precioTotal` double DEFAULT NULL,
  PRIMARY KEY (`idCartelera`),
  KEY `FK_cartelera_peliculas` (`idPelicula`),
  KEY `FK_cartelera_sala` (`idSala`),
  CONSTRAINT `FK_cartelera_peliculas` FOREIGN KEY (`idPelicula`) REFERENCES `peliculas` (`idPelicula`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cartelera_sala` FOREIGN KEY (`idSala`) REFERENCES `sala` (`idSala`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.cartelera: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cartelera` DISABLE KEYS */;
/*!40000 ALTER TABLE `cartelera` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.estado
CREATE TABLE IF NOT EXISTS `estado` (
  `idEstado` int(11) NOT NULL AUTO_INCREMENT,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.estado: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.genero
CREATE TABLE IF NOT EXISTS `genero` (
  `idGenero` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idGenero`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.genero: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `genero` DISABLE KEYS */;
INSERT INTO `genero` (`idGenero`, `descripcion`) VALUES
	(1, 'Comedia'),
	(2, 'Accion'),
	(3, 'Infantil'),
	(4, 'Terror'),
	(5, 'Drama'),
	(6, 'Suspenso');
/*!40000 ALTER TABLE `genero` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.paliculas
CREATE TABLE IF NOT EXISTS `paliculas` (
  `idPeliculas` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `duracion` varchar(50) NOT NULL,
  `atp` tinyint(4) NOT NULL,
  `idGenero` int(11) NOT NULL,
  `plus` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idPeliculas`),
  KEY `FK_paliculas_genero` (`idGenero`),
  CONSTRAINT `FK_paliculas_genero` FOREIGN KEY (`idGenero`) REFERENCES `genero` (`idGenero`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.paliculas: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `paliculas` DISABLE KEYS */;
INSERT INTO `paliculas` (`idPeliculas`, `nombre`, `duracion`, `atp`, `idGenero`, `plus`) VALUES
	(3, 'Lightyear', '1h 58min', 1, 3, NULL),
	(5, 'Jurassic World: Dominion', '2h 10min', 1, 1, NULL),
	(7, 'The Black Phone', '1h 50min', 0, 4, NULL),
	(9, 'Top Gun: Maverick', '1h 56min', 1, 2, NULL);
/*!40000 ALTER TABLE `paliculas` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.reserva
CREATE TABLE IF NOT EXISTS `reserva` (
  `idReserva` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL DEFAULT 0,
  `idEstado` int(11) NOT NULL DEFAULT 0,
  `idTipoPago` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idReserva`),
  KEY `FK_reserva_usuario` (`idUsuario`),
  KEY `FK_reserva_estado` (`idEstado`),
  KEY `FK_reserva_tipopago` (`idTipoPago`),
  CONSTRAINT `FK_reserva_estado` FOREIGN KEY (`idEstado`) REFERENCES `estado` (`idEstado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_reserva_tipopago` FOREIGN KEY (`idTipoPago`) REFERENCES `tipo_pago` (`id_tipoPago`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_reserva_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.reserva: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.reserva_butacas
CREATE TABLE IF NOT EXISTS `reserva_butacas` (
  `idButaca` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  PRIMARY KEY (`idButaca`,`idReserva`),
  KEY `FK__reserva` (`idReserva`),
  CONSTRAINT `FK__butacas` FOREIGN KEY (`idButaca`) REFERENCES `butacas` (`idButacas`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK__reserva` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.reserva_butacas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `reserva_butacas` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva_butacas` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.rol_usuarios
CREATE TABLE IF NOT EXISTS `rol_usuarios` (
  `id_rol_usuarios` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_rol_usuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.rol_usuarios: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `rol_usuarios` DISABLE KEYS */;
INSERT INTO `rol_usuarios` (`id_rol_usuarios`, `descripcion`) VALUES
	(1, 'admin'),
	(2, 'usuario comun');
/*!40000 ALTER TABLE `rol_usuarios` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.sala
CREATE TABLE IF NOT EXISTS `sala` (
  `idSala` int(11) NOT NULL AUTO_INCREMENT,
  `capcidad` int(11) NOT NULL DEFAULT 0,
  `nombre` int(11) NOT NULL DEFAULT 0,
  `idTiposala` int(11) NOT NULL DEFAULT 0,
  `idPelicula` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idSala`),
  KEY `FK_sala_tiposala` (`idTiposala`),
  KEY `FK_sala_pelicula` (`idPelicula`),
  CONSTRAINT `FK_sala_pelicula` FOREIGN KEY (`idPelicula`) REFERENCES `peliculas` (`idPelicula`) ON UPDATE CASCADE,
  CONSTRAINT `FK_sala_tiposala` FOREIGN KEY (`idTiposala`) REFERENCES `tipo_sala` (`id_tipoSala`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.sala: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.tipo_pago
CREATE TABLE IF NOT EXISTS `tipo_pago` (
  `id_tipoPago` int(11) NOT NULL AUTO_INCREMENT,
  `tipoPago` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tipoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.tipo_pago: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_pago` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.tipo_sala
CREATE TABLE IF NOT EXISTS `tipo_sala` (
  `id_tipoSala` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_tipoSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.tipo_sala: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_sala` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_sala` ENABLE KEYS */;

-- Volcando estructura para tabla cinemar.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `apellido` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `idRol` int(11) DEFAULT NULL,
  `esFrecuente` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `FK__rol_usuarios` (`idRol`),
  CONSTRAINT `FK__rol_usuarios` FOREIGN KEY (`idRol`) REFERENCES `rol_usuarios` (`id_rol_usuarios`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cinemar.usuario: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id_usuario`, `apellido`, `nombre`, `email`, `dni`, `password`, `idRol`, `esFrecuente`) VALUES
	(1, 'Palisa', 'Carlos', 'carlospalisa@gmail.com', '25571370', 'admin1', 1, 1),
	(2, 'Moyano', 'Sergio', 'sergio@moyano.com', '22222222', 'admin2', 1, 1),
	(3, 'Valdez', 'Cristian', 'cristian@valdez', '33333333', 'user1', 2, 1),
	(4, 'Rivero', 'Victor Hugo', 'victorhugo@rivero.com', '44444444', 'user2', 2, 1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
