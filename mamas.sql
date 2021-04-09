-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-04-2021 a las 10:24:31
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mamas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asig_alumno`
--

CREATE TABLE `asig_alumno` (
  `id_ciclo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nota` decimal(3,0) NOT NULL,
  `estado` int(1) NOT NULL COMMENT '0- Espera 1-Aceptado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asig_alumno`
--

INSERT INTO `asig_alumno` (`id_ciclo`, `id_usuario`, `nota`, `estado`) VALUES
(10, 12, '7', 1),
(10, 13, '8', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asig_ciclos`
--

CREATE TABLE `asig_ciclos` (
  `id_usuario` int(11) NOT NULL,
  `id_ciclo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asig_convalidacion`
--

CREATE TABLE `asig_convalidacion` (
  `id_usuario` int(11) NOT NULL,
  `id_asignatura` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asig_convalidacion`
--

INSERT INTO `asig_convalidacion` (`id_usuario`, `id_asignatura`, `estado`) VALUES
(12, 9, 2),
(13, 11, 1),
(12, 12, 1),
(12, 11, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asig_materias`
--

CREATE TABLE `asig_materias` (
  `id_ciclo` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asig_materias`
--

INSERT INTO `asig_materias` (`id_ciclo`, `id_materia`) VALUES
(10, 9),
(10, 10),
(10, 11),
(11, 9),
(11, 10),
(11, 11),
(12, 9),
(12, 11),
(13, 11),
(14, 12),
(14, 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asig_preguntas`
--

CREATE TABLE `asig_preguntas` (
  `id_examen` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asig_preguntas`
--

INSERT INTO `asig_preguntas` (`id_examen`, `id_pregunta`) VALUES
(1, 2),
(1, 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asig_profesor`
--

CREATE TABLE `asig_profesor` (
  `id_materia` int(11) NOT NULL,
  `id_ciclo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asig_profesor`
--

INSERT INTO `asig_profesor` (`id_materia`, `id_ciclo`, `id_usuario`) VALUES
(9, 10, 3),
(10, 10, 9),
(11, 10, 10),
(11, 13, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asig_respuestas`
--

CREATE TABLE `asig_respuestas` (
  `id_pregunta` int(11) NOT NULL,
  `id_respuesta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asig_respuestas`
--

INSERT INTO `asig_respuestas` (`id_pregunta`, `id_respuesta`) VALUES
(15, 1),
(15, 2),
(15, 3),
(15, 4),
(18, 5),
(18, 6),
(18, 7),
(18, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asig_rol`
--

CREATE TABLE `asig_rol` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asig_rol`
--

INSERT INTO `asig_rol` (`id_usuario`, `id_rol`) VALUES
(3, 3),
(9, 2),
(10, 2),
(11, 2),
(12, 1),
(13, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciclos`
--

CREATE TABLE `ciclos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `plazas` int(3) NOT NULL DEFAULT 25
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ciclos`
--

INSERT INTO `ciclos` (`id`, `nombre`, `descripcion`, `plazas`) VALUES
(10, 'DAW', 'DESARROLLO APLICACIONES WEB', 20),
(11, 'DAM', 'DESARROLLO APLICACIONES MULTIPLATAFORMA', 30),
(12, 'ASIR', 'administracion de sistemas informaticos en red', 10),
(13, 'Ciberseguridad', 'master en ciberseguridad', 5),
(14, 'comercio', 'comercio con una plaza', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes`
--

CREATE TABLE `examenes` (
  `id` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `contenido` varchar(40) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `estado` int(11) NOT NULL,
  `ponderacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `examenes`
--

INSERT INTO `examenes` (`id`, `id_materia`, `contenido`, `descripcion`, `estado`, `ponderacion`) VALUES
(1, 11, 'tema1-hardware', 'introduccion al hardware', 1, 10),
(2, 11, 'tema 2-software', 'introduccion', 1, 10),
(3, 11, 'Tema 3-mix', 'mix', 1, 15),
(4, 11, 'Tema 4 - redes', 'redes y servidores', 0, 20),
(5, 11, 'Tema5 - ubuntu', 'ubuntu', 0, 30),
(6, 11, 'tema-6', 'fin', 0, 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`id`, `nombre`, `descripcion`) VALUES
(9, 'Lenguaje de Marcas', 'HTML CSS etc'),
(10, 'Programacion', 'Java y mas mucho mas'),
(11, 'Fundamentos de Hardware', 'introduccion'),
(12, 'comercio asig 1', 'asignatura 1 de comercio'),
(13, 'comercio asig 2', 'comercio asignatura 2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE `perfil` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellidos` varchar(30) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  `nacimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`id`, `nombre`, `apellidos`, `dni`, `telefono`, `nacimiento`) VALUES
(3, 'fernando', 'aranzabe', '06280855L', '123456787', '2021-03-05'),
(9, 'inma', 'gijon', '06280822A', '666666666', '2021-04-01'),
(10, 'jose luis', 'gonzalez', '06280822P', '666666444', '2021-03-17'),
(11, 'diego', 'cordoba', '06284859P', '666666666', '2021-01-12'),
(12, 'israel', 'molina', '06280822M', '662141179', '2020-12-24'),
(13, 'javier', 'lopez', '06280833K', '666444222', '2021-04-09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `enunciado` varchar(100) NOT NULL,
  `tipo` int(1) NOT NULL,
  `puntuacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`id`, `id_materia`, `enunciado`, `tipo`, `puntuacion`) VALUES
(2, 11, 'prueba 2', 3, 5),
(3, 11, 'prueba 3', 2, 40),
(4, 11, 'hola', 1, 1),
(5, 11, 'hola2', 1, 2),
(6, 11, 'asdfsdfsd', 1, 99),
(7, 11, 'awerwe', 3, 10),
(8, 11, 'aawetyghg', 3, 50),
(9, 11, 'poiehs', 3, 4),
(10, 11, 'pw3heno', 3, 2),
(11, 11, 'aaaaaaaaaaa', 3, 11),
(12, 11, 'asdwwww', 3, 22),
(13, 11, '3asdfasd', 3, 3),
(14, 11, 'ssssssssssss', 3, 3),
(15, 11, '555555', 3, 55),
(16, 11, 'numerica', 1, 12),
(17, 11, 'numerica2', 1, 13),
(18, 11, 'num3', 1, 14),
(19, 11, 'prueba ', 0, 99),
(21, 11, 'asdfasdfasdfasdf', 0, 33),
(22, 11, 'pregunta1', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `Respuesta` varchar(150) NOT NULL,
  `correcta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`id`, `id_pregunta`, `Respuesta`, `correcta`) VALUES
(1, 15, '5', 1),
(2, 15, '55', 0),
(3, 15, '555', 0),
(4, 15, '5555', 1),
(5, 18, '111', 0),
(6, 18, '22', 1),
(7, 18, '3', 0),
(8, 18, '44444', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `descripcion`) VALUES
(1, 'alumno'),
(2, 'profesor'),
(3, 'administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(2) NOT NULL,
  `email` varchar(25) NOT NULL,
  `password` varchar(32) NOT NULL COMMENT 'Cifrada',
  `isActive` int(1) NOT NULL DEFAULT 0 COMMENT '0 -desativado 1-Activado',
  `intentos` int(1) NOT NULL DEFAULT 0 COMMENT 'maximo de 3 se reinicia al hacer login'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `email`, `password`, `isActive`, `intentos`) VALUES
(3, 'fernando@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 1, 0),
(9, 'inma@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 1, 0),
(10, 'jluis@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 1, 0),
(11, 'diego@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 1, 0),
(12, 'isra9movil@hotmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 1, 0),
(13, 'javier@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 1, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asig_alumno`
--
ALTER TABLE `asig_alumno`
  ADD KEY `id_ciclo` (`id_ciclo`,`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `asig_ciclos`
--
ALTER TABLE `asig_ciclos`
  ADD KEY `id_usuario` (`id_usuario`,`id_ciclo`),
  ADD KEY `id_ciclo` (`id_ciclo`);

--
-- Indices de la tabla `asig_convalidacion`
--
ALTER TABLE `asig_convalidacion`
  ADD KEY `id_usuario` (`id_usuario`,`id_asignatura`),
  ADD KEY `id_asignatura` (`id_asignatura`);

--
-- Indices de la tabla `asig_materias`
--
ALTER TABLE `asig_materias`
  ADD KEY `id_ciclo` (`id_ciclo`,`id_materia`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `asig_preguntas`
--
ALTER TABLE `asig_preguntas`
  ADD KEY `id_examen` (`id_examen`,`id_pregunta`),
  ADD KEY `id_pregunta` (`id_pregunta`);

--
-- Indices de la tabla `asig_profesor`
--
ALTER TABLE `asig_profesor`
  ADD KEY `id_materia` (`id_materia`,`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_ciclo` (`id_ciclo`);

--
-- Indices de la tabla `asig_respuestas`
--
ALTER TABLE `asig_respuestas`
  ADD KEY `id_pregunta` (`id_pregunta`,`id_respuesta`),
  ADD KEY `id_respuesta` (`id_respuesta`);

--
-- Indices de la tabla `asig_rol`
--
ALTER TABLE `asig_rol`
  ADD KEY `id_usuario` (`id_usuario`,`id_rol`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `ciclos`
--
ALTER TABLE `ciclos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `examenes`
--
ALTER TABLE `examenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pregunta` (`id_pregunta`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ciclos`
--
ALTER TABLE `ciclos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `examenes`
--
ALTER TABLE `examenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asig_alumno`
--
ALTER TABLE `asig_alumno`
  ADD CONSTRAINT `asig_alumno_ibfk_1` FOREIGN KEY (`id_ciclo`) REFERENCES `ciclos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_alumno_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asig_ciclos`
--
ALTER TABLE `asig_ciclos`
  ADD CONSTRAINT `asig_ciclos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_ciclos_ibfk_2` FOREIGN KEY (`id_ciclo`) REFERENCES `ciclos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asig_convalidacion`
--
ALTER TABLE `asig_convalidacion`
  ADD CONSTRAINT `asig_convalidacion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_convalidacion_ibfk_2` FOREIGN KEY (`id_asignatura`) REFERENCES `materias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asig_materias`
--
ALTER TABLE `asig_materias`
  ADD CONSTRAINT `asig_materias_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_materias_ibfk_2` FOREIGN KEY (`id_ciclo`) REFERENCES `ciclos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asig_preguntas`
--
ALTER TABLE `asig_preguntas`
  ADD CONSTRAINT `asig_preguntas_ibfk_1` FOREIGN KEY (`id_examen`) REFERENCES `examenes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_preguntas_ibfk_2` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asig_profesor`
--
ALTER TABLE `asig_profesor`
  ADD CONSTRAINT `asig_profesor_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_profesor_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_profesor_ibfk_3` FOREIGN KEY (`id_ciclo`) REFERENCES `ciclos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asig_respuestas`
--
ALTER TABLE `asig_respuestas`
  ADD CONSTRAINT `asig_respuestas_ibfk_2` FOREIGN KEY (`id_respuesta`) REFERENCES `respuestas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_respuestas_ibfk_3` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asig_rol`
--
ALTER TABLE `asig_rol`
  ADD CONSTRAINT `asig_rol_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asig_rol_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `examenes`
--
ALTER TABLE `examenes`
  ADD CONSTRAINT `examenes_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `perfil`
--
ALTER TABLE `perfil`
  ADD CONSTRAINT `perfil_ibfk_1` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `preguntas_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
