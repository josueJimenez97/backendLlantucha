-- -------------------------------------------------------------------------
-- PostgreSQL SQL create tables
-- exported at Mon Jul 13 09:01:13 BOT 2020 with easyDesigner
-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- Table: Usuario
-- -------------------------------------------------------------------------
CREATE TABLE "Usuario" (
  "iduser" INTEGER NOT NULL,
  "nombre" VARCHAR NULL,
  "correo" VARCHAR NOT NULL,
  "password" VARCHAR NULL,
  PRIMARY KEY ("iduser")
);

-- -------------------------------------------------------------------------
-- Table: Fabrica
-- -------------------------------------------------------------------------
CREATE TABLE "Fabrica" (
  "idfrabica" INTEGER NOT NULL,
  "nombrefabrica" VARCHAR NULL,
  PRIMARY KEY ("idfrabica")
);

-- -------------------------------------------------------------------------
-- Table: Detalle_Venta
-- -------------------------------------------------------------------------
CREATE TABLE "Detalle_Venta" (
  "Venta_idventa" INTEGER NOT NULL,
  "Item_Producto_Tipo_Producto_idtipo" INTEGER NOT NULL,
  "Item_Producto_Fabrica_idfrabica" INTEGER NOT NULL,
  "Venta_Usuario_iduser" INTEGER NOT NULL,
  "Item_Producto_id_producto" INTEGER NOT NULL,
  "cantidad" INTEGER NULL,
  "totalparcial" DOUBLE NULL,
  PRIMARY KEY ("Venta_idventa", "Item_Producto_Tipo_Producto_idtipo", "Item_Producto_Fabrica_idfrabica", "Venta_Usuario_iduser", "Item_Producto_id_producto")
);

-- -------------------------------------------------------------------------
-- Table: Venta
-- -------------------------------------------------------------------------
CREATE TABLE "Venta" (
  "idventa" INTEGER NOT NULL,
  "Usuario_iduser" INTEGER NOT NULL,
  "fechaventa" DATE NULL,
  PRIMARY KEY ("idventa", "Usuario_iduser")
);

-- -------------------------------------------------------------------------
-- Table: Tipo_Producto
-- -------------------------------------------------------------------------
CREATE TABLE "Tipo_Producto" (
  "idtipo" INTEGER NOT NULL,
  "nombretipo" VARCHAR NULL,
  PRIMARY KEY ("idtipo")
);

-- -------------------------------------------------------------------------
-- Table: Producto
-- -------------------------------------------------------------------------
CREATE TABLE "Producto" (
  "id_producto" INTEGER NOT NULL,
  "Tipo_Producto_idtipo" INTEGER NOT NULL,
  "Fabrica_idfrabica" INTEGER NOT NULL,
  "nombre_producto" VARCHAR NULL,
  "imagen" VARCHAR NULL,
  PRIMARY KEY ("id_producto", "Tipo_Producto_idtipo", "Fabrica_idfrabica")
);

-- -------------------------------------------------------------------------
-- Table: Item
-- -------------------------------------------------------------------------
CREATE TABLE "Item" (
  "Producto_Tipo_Producto_idtipo" INTEGER NOT NULL,
  "Producto_Fabrica_idfrabica" INTEGER NOT NULL,
  "Producto_id_producto" INTEGER NOT NULL,
  "garantia" BOOL NULL,
  "cantidad" INTEGER NULL,
  PRIMARY KEY ("Producto_Tipo_Producto_idtipo", "Producto_Fabrica_idfrabica", "Producto_id_producto")
);

-- -------------------------------------------------------------------------
-- Table: Calificacion
-- -------------------------------------------------------------------------
CREATE TABLE "Calificacion" (
  "Venta_idventa" INTEGER NOT NULL,
  "Venta_Usuario_iduser" INTEGER NOT NULL,
  "descripcion" VARCHAR NULL,
  "puntuacion" INTEGER NULL,
  PRIMARY KEY ("Venta_idventa", "Venta_Usuario_iduser")
);

-- -------------------------------------------------------------------------
-- Table: Interfaz
-- -------------------------------------------------------------------------
CREATE TABLE "Interfaz" (
  "id_interfaz" INTEGER NOT NULL,
  "nombre_interfaz" VARCHAR NULL,
  PRIMARY KEY ("id_interfaz")
);

-- -------------------------------------------------------------------------
-- Table: log_usuario
-- -------------------------------------------------------------------------
CREATE TABLE "log_usuario" (
  "Fecha_interaccion" DATE NOT NULL,
  "Visita_Fecha_Visita" DATE NOT NULL,
  "Visita_Usuario_iduser" INTEGER NOT NULL,
  "Visita_Interfaz_id_interfaz" INTEGER NOT NULL,
  "Caracteristicas" VARCHAR(255) NULL,
  "Variables" VARCHAR(255) NULL,
  PRIMARY KEY ("Fecha_interaccion", "Visita_Fecha_Visita", "Visita_Usuario_iduser", "Visita_Interfaz_id_interfaz")
);

-- -------------------------------------------------------------------------
-- Table: Visita
-- -------------------------------------------------------------------------
CREATE TABLE "Visita" (
  "Fecha_Visita" DATE NOT NULL,
  "Usuario_iduser" INTEGER NOT NULL,
  "Interfaz_id_interfaz" INTEGER NOT NULL,
  "tiempo" DOUBLE NULL,
  PRIMARY KEY ("Fecha_Visita", "Usuario_iduser", "Interfaz_id_interfaz")
);

-- -------------------------------------------------------------------------
-- Relations for table: Detalle_Venta
-- -------------------------------------------------------------------------
ALTER TABLE "Detalle_Venta" ADD FOREIGN KEY ("Venta_idventa", "Venta_Usuario_iduser") 
    REFERENCES "Venta" ("idventa", "Usuario_iduser")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Detalle_Venta" ADD FOREIGN KEY ("Item_Producto_Tipo_Producto_idtipo", "Item_Producto_Fabrica_idfrabica", "Item_Producto_id_producto") 
    REFERENCES "Item" ("Producto_Tipo_Producto_idtipo", "Producto_Fabrica_idfrabica", "Producto_id_producto")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Venta
-- -------------------------------------------------------------------------
ALTER TABLE "Venta" ADD FOREIGN KEY ("Usuario_iduser") 
    REFERENCES "Usuario" ("iduser")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Producto
-- -------------------------------------------------------------------------
ALTER TABLE "Producto" ADD FOREIGN KEY ("Tipo_Producto_idtipo") 
    REFERENCES "Tipo_Producto" ("idtipo")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Producto" ADD FOREIGN KEY ("Fabrica_idfrabica") 
    REFERENCES "Fabrica" ("idfrabica")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Item
-- -------------------------------------------------------------------------
ALTER TABLE "Item" ADD FOREIGN KEY ("Producto_Tipo_Producto_idtipo", "Producto_Fabrica_idfrabica", "Producto_id_producto") 
    REFERENCES "Producto" ("Tipo_Producto_idtipo", "Fabrica_idfrabica", "id_producto")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Calificacion
-- -------------------------------------------------------------------------
ALTER TABLE "Calificacion" ADD FOREIGN KEY ("Venta_idventa", "Venta_Usuario_iduser") 
    REFERENCES "Venta" ("idventa", "Usuario_iduser")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: log_usuario
-- -------------------------------------------------------------------------
ALTER TABLE "log_usuario" ADD FOREIGN KEY ("Visita_Fecha_Visita", "Visita_Usuario_iduser", "Visita_Interfaz_id_interfaz") 
    REFERENCES "Visita" ("Fecha_Visita", "Usuario_iduser", "Interfaz_id_interfaz")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Visita
-- -------------------------------------------------------------------------
ALTER TABLE "Visita" ADD FOREIGN KEY ("Usuario_iduser") 
    REFERENCES "Usuario" ("iduser")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Visita" ADD FOREIGN KEY ("Interfaz_id_interfaz") 
    REFERENCES "Interfaz" ("id_interfaz")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
