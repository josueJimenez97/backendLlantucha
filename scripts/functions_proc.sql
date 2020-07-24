-- FUNCTION: public.fadd_item(integer, integer, integer, integer, integer)

-- DROP FUNCTION public.fadd_item(integer, integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION public.fadd_item(
	idtipo integer,
	idproducto integer,
	idfabrica integer,
	cant integer,
	precio integer)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$BEGIN
IF (SELECT COUNT(*)
   FROM "Item" as item
   WHERE item."Producto_Tipo_Producto_idtipo"=idtipo and 
   		 item."Producto_id_producto"=idproducto and 
         item."Fabrica_idfrabica"=idfabrica)=0   THEN
	INSERT INTO  "Item"("Producto_Tipo_Producto_idtipo","Producto_id_producto","Fabrica_idfrabica",cantidad,precio)
	VALUES (idtipo,idproducto,idfabrica,cant,precio);
	
ELSE
	
	UPDATE "Item"
	SET cantidad= cantidad+cant
	WHERE "Producto_Tipo_Producto_idtipo"=idtipo and "Producto_id_producto"=idproducto and "Fabrica_idfrabica"=idfabrica;
END IF;
RETURN 0;
END;$BODY$;

ALTER FUNCTION public.fadd_item(integer, integer, integer, integer, integer)
    OWNER TO postgres;

-- FUNCTION: public.fadd_product(integer, character varying, character varying, integer)

-- DROP FUNCTION public.fadd_product(integer, character varying, character varying, integer);

CREATE OR REPLACE FUNCTION public.fadd_product(
	idtipo integer,
	nombre character varying,
	imagen character varying,
	precio integer)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$BEGIN
insert into "Producto"("Tipo_Producto_idtipo",nombre_producto,imagen,precio)
values (idtipo,nombre,imagen,precio);
return (SELECT max(id_producto)
	   FROM "Producto");

END;$BODY$;

ALTER FUNCTION public.fadd_product(integer, character varying, character varying, integer)
    OWNER TO postgres;

-- FUNCTION: public.fadd_producto(integer, character varying, character varying)

-- DROP FUNCTION public.fadd_producto(integer, character varying, character varying);

CREATE OR REPLACE FUNCTION public.fadd_producto(
	idtipo integer,
	nombre character varying,
	imagen character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$BEGIN
insert into "Producto"("Tipo_Producto_idtipo",nombre_producto,imagen)
values (idtipo,nombre,imagen);
return (SELECT max(id_producto)
	   FROM "Producto");

END;$BODY$;

ALTER FUNCTION public.fadd_producto(integer, character varying, character varying)
    OWNER TO postgres;

-- FUNCTION: public.fadd_usuario(character varying, character varying, character varying)

-- DROP FUNCTION public.fadd_usuario(character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION public.fadd_usuario(
	nombre character varying,
	passw character varying,
	correo character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$BEGIN
	INSERT INTO "Usuario"(nombre,correo,password)
	VALUES (nombre,correo,passw);
return 0;
END;$BODY$;

ALTER FUNCTION public.fadd_usuario(character varying, character varying, character varying)
    OWNER TO postgres;

-- FUNCTION: public.fadd_venta(integer)

-- DROP FUNCTION public.fadd_venta(integer);

CREATE OR REPLACE FUNCTION public.fadd_venta(
	userid integer)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$BEGIN
	INSERT INTO "Venta"("Usuario_iduser",fechaventa)
	VALUES (userid,now());
	return 0;
END;$BODY$;

ALTER FUNCTION public.fadd_venta(integer)
    OWNER TO postgres;

-- FUNCTION: public.fadd_visita(integer, integer, double precision)

-- DROP FUNCTION public.fadd_visita(integer, integer, double precision);

CREATE OR REPLACE FUNCTION public.fadd_visita(
	userid integer,
	interfazid integer,
	tiempo double precision)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$BEGIN
	INSERT INTO "Visita"
	VALUES (now(),userid,interfazid,tiempo);
	return 0;
	   
END;$BODY$;

ALTER FUNCTION public.fadd_visita(integer, integer, double precision)
    OWNER TO postgres;

