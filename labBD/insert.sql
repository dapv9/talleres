
/* Tabla estado_jugador */
INSERT INTO estado_jugador (id, nombre) VALUES (1, 'Activo');
INSERT INTO estado_jugador (id, nombre) VALUES (2, 'Lesionado');
INSERT INTO estado_jugador (id, nombre) VALUES (3, 'Retirado');
INSERT INTO estado_jugador (id, nombre) VALUES (4, 'Ausente');

/* Tabla usuario */
INSERT INTO usuario (cedula, nombre, fecha_nacimiento, rh, direccion, correo_e, estrato, eps, estado) VALUES ('123', 'Pepe Patea Traseros', TO_DATE('01-12-1987', 'MM-DD-YYYY'), 'o+', 'Cll falsa No. 123', '123@gmail.com', 2, 'Sura', 2);
INSERT INTO usuario (cedula, nombre, fecha_nacimiento, rh, direccion, correo_e, estrato, eps, estado) VALUES ('234', 'Bartholomew JoJo Simpson', TO_DATE('06-12-1987', 'MM-DD-YYYY'), 'ab+', 'Avenida siempre viva 742', 'bart@gmail.com', 3, 'Sura', 1);
INSERT INTO usuario (cedula, nombre, fecha_nacimiento, rh, direccion, correo_e, estrato, eps, estado) VALUES ('345', 'Tobi Lleras Rojas', TO_DATE('05-28-1990', 'MM-DD-YYYY'), 'o+', 'Cll 10D No. 101', 'tlr@gmail.com', 4, 'Sura', 1);

/* Tabla equipo */
INSERT INTO equipo (nombre, deporte, posicion) VALUES ('Hachas A', '15''s', 2);
INSERT INTO equipo (nombre, deporte, posicion) VALUES ('Hachas B', '15''s', 4);
INSERT INTO equipo (nombre, deporte, posicion) VALUES ('Athalantas', '7''s', 1);

/* Tabla tipo_usuario */
INSERT INTO tipo_usuario (id, nombre) VALUES (1, 'Administrador');
INSERT INTO tipo_usuario (id, nombre) VALUES (2, 'Entrenador');
INSERT INTO tipo_usuario (id, nombre) VALUES (3, 'Jugador');

/* Tabla noticia */
INSERT INTO noticia (id, titulo, contenido, fecha_publicacion, autor) VALUES (1, 'Fecha fin de semana', 'Esta fin de semana juega el equipo A a las 11am, nos vemos a las 10am en la cancha para calentar.', TO_DATE('10-25-2013', 'MM-DD-YYYY'), '123');
INSERT INTO noticia (id, titulo, contenido, fecha_publicacion, autor) VALUES (2, 'Cancelado el partido', 'Se canceló el partido de este fin de semana. Nos vemos a la 1 para ver el partido de Francia vs Inglaterra.', TO_DATE('10-25-2013', 'MM-DD-YYYY'), '123');

/* Tabla posicion_jugador */
INSERT INTO posicion_jugador (jugador, posicion) VALUES ('123', 9);
INSERT INTO posicion_jugador (jugador, posicion) VALUES ('123', 10);
INSERT INTO posicion_jugador (jugador, posicion) VALUES ('123', 11);
INSERT INTO posicion_jugador (jugador, posicion) VALUES ('123', 14);
INSERT INTO posicion_jugador (jugador, posicion) VALUES ('234', 6);
INSERT INTO posicion_jugador (jugador, posicion) VALUES ('234', 7);
INSERT INTO posicion_jugador (jugador, posicion) VALUES ('345', 4);

/* Tabla usuario_x_tipo */
INSERT INTO usuario_x_tipo (usuario, tipo) VALUES ('123', 1);
INSERT INTO usuario_x_tipo (usuario, tipo) VALUES ('123', 3);
INSERT INTO usuario_x_tipo (usuario, tipo) VALUES ('234', 3);
INSERT INTO usuario_x_tipo (usuario, tipo) VALUES ('345', 3);

/* Tabla torneo */
INSERT INTO torneo (id, nombre_torneo, categoria, fecha_inicio, fecha_cierre, equipo) VALUES (1, 'Metropolitano', 1, TO_DATE('06-10-2013', 'MM-DD-YYYY'), TO_DATE('12-15-2013', 'MM-DD-YYYY'), 'Hachas A');
INSERT INTO torneo (id, nombre_torneo, categoria, fecha_inicio, fecha_cierre, equipo) VALUES (2, 'Metropolitano', 3, TO_DATE('06-10-2013', 'MM-DD-YYYY'), TO_DATE('12-16-2013', 'MM-DD-YYYY'), 'Hachas B');
INSERT INTO torneo (id, nombre_torneo, categoria, fecha_inicio, fecha_cierre, equipo) VALUES (3, 'Copa ciudad de Medellin', 2, TO_DATE('08-17-2013', 'MM-DD-YYYY'), TO_DATE('08-19-2013', 'MM-DD-YYYY'), 'Athalantas');

/* Tabla jugador_x_equipo */
INSERT INTO jugador_x_equipo (jugador, equipo, titular) VALUES ('123', 'Hachas A', 'Si');
INSERT INTO jugador_x_equipo (jugador, equipo, titular) VALUES ('234', 'Hachas B', 'Si');
INSERT INTO jugador_x_equipo (jugador, equipo, titular) VALUES ('345', 'Hachas A', 'No');

