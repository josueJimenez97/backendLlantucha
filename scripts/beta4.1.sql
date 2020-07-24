BEGIN
CREATE SEQUENCE seq_producto
        INCREMENT 1
        MINVALUE 110
        MAXVALUE 2147483648 START 2220
        CACHE 1;


CREATE SEQUENCE test_usuario
        INCREMENT 1
        MINVALUE 110
        MAXVALUE 2147483648 START 1110
        CACHE 1;


CREATE SEQUENCE seq_fabrica
        INCREMENT 1
        MINVALUE 110
        MAXVALUE 2147483648 START 3330
        CACHE 1;
CREATE SEQUENCE test_venta
        INCREMENT 1
        MINVALUE 110
        MAXVALUE 2147483648 START 5550
        CACHE 1;
--Insertar estas sequencias primero 
-- Table: public.Tipo_Producto

-- DROP TABLE public."Tipo_Producto";

CREATE TABLE public."Tipo_Producto"
(
    idtipo integer NOT NULL,
    nombretipo character varying COLLATE pg_catalog."default",
    CONSTRAINT "Tipo_Producto_pkey" PRIMARY KEY (idtipo)
)

TABLESPACE pg_default;

ALTER TABLE public."Tipo_Producto"
    OWNER to postgres;
    -- Table: public.Fabrica

-- DROP TABLE public."Fabrica";

CREATE TABLE public."Fabrica"
(
    idfabrica integer NOT NULL DEFAULT nextval('seq_fabrica'::regclass),
    nombrefabrica character varying COLLATE pg_catalog."default",
    CONSTRAINT "Fabrica_pkey" PRIMARY KEY (idfabrica)
)

TABLESPACE pg_default;

ALTER TABLE public."Fabrica"
    OWNER to postgres;
    -- Table: public.Usuario

-- DROP TABLE public."Usuario";

CREATE TABLE public."Usuario"
(
    iduser integer NOT NULL DEFAULT nextval('test_usuario'::regclass),
    nombre character varying COLLATE pg_catalog."default",
    correo character varying COLLATE pg_catalog."default" NOT NULL,
    password character varying COLLATE pg_catalog."default",
    CONSTRAINT "Usuario_pkey" PRIMARY KEY (iduser)
)

TABLESPACE pg_default;

ALTER TABLE public."Usuario"
    OWNER to postgres;
    -- Table: public.Interfaz

-- DROP TABLE public."Interfaz";

CREATE TABLE public."Interfaz"
(
    id_interfaz integer NOT NULL,
    nombre_interfaz character varying COLLATE pg_catalog."default",
    CONSTRAINT "Interfaz_pkey" PRIMARY KEY (id_interfaz)
)

TABLESPACE pg_default;

ALTER TABLE public."Interfaz"
    OWNER to postgres;
COMMIT;
------------------------------PARTE------------------------------------
-- Table: public.Producto

-- DROP TABLE public."Producto";

CREATE TABLE public."Producto"
(
    id_producto integer NOT NULL DEFAULT nextval('seq_producto'::regclass),
    "Tipo_Producto_idtipo" integer NOT NULL,
    nombre_producto character varying COLLATE pg_catalog."default",
    imagen character varying COLLATE pg_catalog."default",
    CONSTRAINT "Producto_pkey" PRIMARY KEY (id_producto, "Tipo_Producto_idtipo"),
    CONSTRAINT "Producto_Tipo_Producto_idtipo_fkey" FOREIGN KEY ("Tipo_Producto_idtipo")
        REFERENCES public."Tipo_Producto" (idtipo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Producto"
    OWNER to postgres;
    -- Table: public.Venta

-- DROP TABLE public."Venta";

CREATE TABLE public."Venta"
(
    idventa integer NOT NULL DEFAULT nextval('test_venta'::regclass),
    "Usuario_iduser" integer NOT NULL,
    fechaventa date,
    CONSTRAINT "Venta_pkey" PRIMARY KEY (idventa, "Usuario_iduser"),
    CONSTRAINT "Venta_Usuario_iduser_fkey" FOREIGN KEY ("Usuario_iduser")
        REFERENCES public."Usuario" (iduser) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Venta"
    OWNER to postgres;
    -- Table: public.Visita

-- DROP TABLE public."Visita";

CREATE TABLE public."Visita"
(
    "Fecha_Visita" date NOT NULL,
    "Usuario_iduser" integer NOT NULL,
    "Interfaz_id_interfaz" integer NOT NULL,
    tiempo double precision,
    CONSTRAINT "Visita_pkey" PRIMARY KEY ("Fecha_Visita", "Usuario_iduser", "Interfaz_id_interfaz"),
    CONSTRAINT "Visita_Interfaz_id_interfaz_fkey" FOREIGN KEY ("Interfaz_id_interfaz")
        REFERENCES public."Interfaz" (id_interfaz) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Visita_Usuario_iduser_fkey" FOREIGN KEY ("Usuario_iduser")
        REFERENCES public."Usuario" (iduser) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Visita"
    OWNER to postgres;
------------------------------PARTE------------------------------------
-- Table: public.log_usuario

-- DROP TABLE public.log_usuario;

CREATE TABLE public.log_usuario
(
    "Fecha_interaccion" date NOT NULL,
    "Visita_Fecha_Visita" date NOT NULL,
    "Visita_Usuario_iduser" integer NOT NULL,
    "Visita_Interfaz_id_interfaz" integer NOT NULL,
    "Caracteristicas" character varying(255) COLLATE pg_catalog."default",
    "Variables" character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT log_usuario_pkey PRIMARY KEY ("Fecha_interaccion", "Visita_Fecha_Visita", "Visita_Usuario_iduser", "Visita_Interfaz_id_interfaz"),
    CONSTRAINT "log_usuario_Visita_Fecha_Visita_Visita_Usuario_iduser_Visi_fkey" FOREIGN KEY ("Visita_Interfaz_id_interfaz", "Visita_Usuario_iduser", "Visita_Fecha_Visita")
        REFERENCES public."Visita" ("Interfaz_id_interfaz", "Usuario_iduser", "Fecha_Visita") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.log_usuario
    OWNER to postgres;
    -- Table: public.Calificacion

-- DROP TABLE public."Calificacion";

CREATE TABLE public."Calificacion"
(
    "Venta_idventa" integer NOT NULL,
    "Venta_Usuario_iduser" integer NOT NULL,
    descripcion character varying COLLATE pg_catalog."default",
    puntuacion integer,
    CONSTRAINT "Calificacion_pkey" PRIMARY KEY ("Venta_idventa", "Venta_Usuario_iduser"),
    CONSTRAINT "Calificacion_Venta_idventa_Venta_Usuario_iduser_fkey" FOREIGN KEY ("Venta_Usuario_iduser", "Venta_idventa")
        REFERENCES public."Venta" ("Usuario_iduser", idventa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Calificacion"
    OWNER to postgres;
-- Table: public.Item

-- DROP TABLE public."Item";

CREATE TABLE public."Item"
(
    "Producto_Tipo_Producto_idtipo" integer NOT NULL,
    "Producto_id_producto" integer NOT NULL,
    "Fabrica_idfrabica" integer NOT NULL,
    cantidad integer,
    precio integer,
    CONSTRAINT "Item_pkey" PRIMARY KEY ("Producto_Tipo_Producto_idtipo", "Producto_id_producto", "Fabrica_idfrabica"),
    CONSTRAINT "Item_Fabrica_idfrabica_fkey" FOREIGN KEY ("Fabrica_idfrabica")
        REFERENCES public."Fabrica" (idfabrica) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Item_Producto_Tipo_Producto_idtipo_Producto_id_producto_fkey" FOREIGN KEY ("Producto_Tipo_Producto_idtipo", "Producto_id_producto")
        REFERENCES public."Producto" ("Tipo_Producto_idtipo", id_producto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Item"
    OWNER to postgres;

------------------------------PARTE------------------------------------


-- Table: public.Detalle_Venta

-- DROP TABLE public."Detalle_Venta";

CREATE TABLE public."Detalle_Venta"
(
    "Venta_idventa" integer NOT NULL,
    "Item_Producto_Tipo_Producto_idtipo" integer NOT NULL,
    "Venta_Usuario_iduser" integer NOT NULL,
    "Item_Producto_id_producto" integer NOT NULL,
    "Item_Fabrica_idfrabica" integer NOT NULL,
    cantidad integer,
    totalparcial double precision,
    CONSTRAINT "Detalle_Venta_pkey" PRIMARY KEY ("Venta_idventa", "Item_Producto_Tipo_Producto_idtipo", "Venta_Usuario_iduser", "Item_Producto_id_producto", "Item_Fabrica_idfrabica"),
    CONSTRAINT "Detalle_Venta_Item_Producto_Tipo_Producto_idtipo_Item_Prod_fkey" FOREIGN KEY ("Item_Fabrica_idfrabica", "Item_Producto_Tipo_Producto_idtipo", "Item_Producto_id_producto")
        REFERENCES public."Item" ("Fabrica_idfrabica", "Producto_Tipo_Producto_idtipo", "Producto_id_producto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Detalle_Venta_Venta_idventa_Venta_Usuario_iduser_fkey" FOREIGN KEY ("Venta_Usuario_iduser", "Venta_idventa")
        REFERENCES public."Venta" ("Usuario_iduser", idventa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Detalle_Venta"
    OWNER to postgres;