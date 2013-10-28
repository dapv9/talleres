REATE TABLE EQUIPO 
(
  ID NUMBER(2) NOT NULL 
, NOMBRE VARCHAR2(15) NOT NULL 
, DEPORTE VARCHAR2(4) NOT NULL 
, POSICION NUMBER(3) NOT NULL 
, CONSTRAINT EQUIPO_PK PRIMARY KEY 
  (
    ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX ID_EQUIPO_PK ON EQUIPO (ID ASC) 
  )
  ENABLE 
);

CREATE TABLE ESTADO_JUGADOR 
(
  ID NUMBER(1) NOT NULL 
, NOMBRE VARCHAR2(10) NOT NULL 
, CONSTRAINT ESTADO_JUGADOR_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE JUGADOR_X_EQUIPO 
(
  JUGADOR VARCHAR2(10) NOT NULL 
, EQUIPO NUMBER(2) NOT NULL 
, TITULAR VARCHAR2(2) NOT NULL 
, CONSTRAINT JUGADOR_X_EQUIPO_PK PRIMARY KEY 
  (
    JUGADOR 
  , EQUIPO 
  )
  ENABLE 
);

CREATE TABLE NOTICIA 
(
  ID NUMBER(3) NOT NULL 
, TITULO VARCHAR2(50) NOT NULL 
, CONTENIDO VARCHAR2(500) NOT NULL 
, FECHA_PUBLICACION DATE NOT NULL 
, AUTOR VARCHAR2(10) NOT NULL 
, CONSTRAINT NOTICIA_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE POSICION_JUGDOR 
(
  JUGADOR VARCHAR2(10) NOT NULL 
, POSICION NUMBER(2) NOT NULL 
, CONSTRAINT POSICION_JUGDOR_PK PRIMARY KEY 
  (
    JUGADOR 
  , POSICION 
  )
  ENABLE 
);

CREATE TABLE TIPO_USUARIO 
(
  ID NUMBER(1) NOT NULL 
, NOMBRE VARCHAR2(15) NOT NULL 
, CONSTRAINT TIPO_USUARIO_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TORNEO 
(
  ID NUMBER(3) NOT NULL 
, NOMBRE_TORNEO VARCHAR2(25) NOT NULL 
, CATEGORIA NUMBER(1) NOT NULL 
, FECHA_INICIO DATE NOT NULL 
, FECHA_CIERRE DATE NOT NULL 
, EQUIPO VARCHAR2(15) NOT NULL 
, CONSTRAINT TORNEO_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE USUARIO 
(
  CEDULA VARCHAR2(10) NOT NULL 
, NOMBRE VARCHAR2(70) NOT NULL 
, FECHA_NACIMIENTO DATE NOT NULL 
, RH VARCHAR2(3) NOT NULL 
, DIRECCION VARCHAR2(40) NOT NULL 
, TELEFONO VARCHAR2(7) 
, CELULAR VARCHAR2(10) 
, CORREO_E VARCHAR2(30) NOT NULL 
, ESTRATO NUMBER(1) NOT NULL 
, EPS VARCHAR2(20) NOT NULL 
, PESO FLOAT(2) 
, ESTATURA FLOAT(2) 
, ESTADO NUMBER(1) 
, CARTERA NUMBER(6) 
, CONSTRAINT USUARIO_PK PRIMARY KEY 
  (
    CEDULA 
  )
  ENABLE 
);

CREATE TABLE USUARIOS_X_TIPO 
(
  USUARIO VARCHAR2(10) NOT NULL 
, TIPO NUMBER(1) NOT NULL 
, CONSTRAINT USUARIOS_X_TIPO_PK PRIMARY KEY 
  (
    USUARIO 
  , TIPO 
  )
  ENABLE 
);

ALTER TABLE JUGADOR_X_EQUIPO
ADD CONSTRAINT JUGADOR_X_EQUIPO_EQUIPO_FK FOREIGN KEY
(
  EQUIPO 
)
REFERENCES EQUIPO
(
  ID 
)
ENABLE;

ALTER TABLE JUGADOR_X_EQUIPO
ADD CONSTRAINT JUGADOR_X_EQUIPO_USUARIO_FK FOREIGN KEY
(
  JUGADOR 
)
REFERENCES USUARIO
(
  CEDULA 
)
ENABLE;

ALTER TABLE NOTICIA
ADD CONSTRAINT NOTICIA_USUARIO_FK FOREIGN KEY
(
  AUTOR 
)
REFERENCES USUARIO
(
  CEDULA 
)
ENABLE;

ALTER TABLE POSICION_JUGDOR
ADD CONSTRAINT POSICION_JUGDOR_USUARIO_FK FOREIGN KEY
(
  JUGADOR 
)
REFERENCES USUARIO
(
  CEDULA 
)
ENABLE;

ALTER TABLE TORNEO
ADD CONSTRAINT TORNEO_EQUIPO_FK FOREIGN KEY
(
  EQUIPO 
)
REFERENCES EQUIPO
(
  ID 
)
ENABLE;

ALTER TABLE USUARIO
ADD CONSTRAINT USUARIO_ESTADO_JUGADOR_FK FOREIGN KEY
(
  ESTADO 
)
REFERENCES ESTADO_JUGADOR
(
  ID 
)
ENABLE;

ALTER TABLE USUARIOS_X_TIPO
ADD CONSTRAINT USUARIOS_X_TIPO_FK FOREIGN KEY
(
  TIPO 
)
REFERENCES TIPO_USUARIO
(
  ID 
)
ENABLE;

ALTER TABLE USUARIOS_X_TIPO
ADD CONSTRAINT USUARIOS_X_TIPO_USUARIO_FK FOREIGN KEY
(
  USUARIO 
)
REFERENCES USUARIO
(
  CEDULA 
)
ENABLE;

ALTER TABLE EQUIPO
ADD CONSTRAINT EQUIPO_CHK_DEPORTE CHECK 
(deporte in ('7''s', '15''s'))
ENABLE;

ALTER TABLE JUGADOR_X_EQUIPO
ADD CONSTRAINT JUGADOR_X_EQUIPO_TITULAR_CHK CHECK 
(titular in ('Si', 'No'))
ENABLE;

ALTER TABLE TORNEO
ADD CONSTRAINT TORNEO_CHK_CATEGORIA CHECK 
(categoria > 0 and categoria < 5)
ENABLE;

ALTER TABLE TORNEO
ADD CONSTRAINT TORNEO_CHK_DURACION CHECK 
(fecha_inicio < fecha_cierre)
ENABLE;

ALTER TABLE USUARIO
ADD CONSTRAINT USUARIO_CHK_CARTERA CHECK 
(cartera >=0)
ENABLE;

CREATE SEQUENCE NOTICIA_SEQ INCREMENT BY 1 START WITH 1 MINVALUE 1;


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

