insert into "Usuario"(nombre,correo,password)
VALUES ('admin','admin','admin');
insert into "Tipo_Producto"(idtipo,nombretipo)
VALUES (1,'Obra Gruesa');
insert into "Tipo_Producto"(idtipo,nombretipo)
VALUES (2,'Obra Fina');
insert into "Tipo_Producto"(idtipo,nombretipo)
VALUES (3,'Herramientas');
insert into "Tipo_Producto"(idtipo,nombretipo)
VALUES (4,'Maquinaria');

insert into "Fabrica"(nombrefabrica)
values ('Hammer');
insert into "Fabrica"(nombrefabrica)
values ('Camba');
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

-- FUNCTION: public.getidfabrica(character varying)

-- DROP FUNCTION public.getidfabrica(character varying);

CREATE OR REPLACE FUNCTION public.getidfabrica(
	nombre character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$DECLARE
resp integer:= -1;
BEGIN
	resp=(select idfabrica
	from "Fabrica" as fabrica
	where fabrica.nombrefabrica = nombre
	limit 1);
	RETURN resp;
END;
$BODY$;

ALTER FUNCTION public.getidfabrica(character varying)
    OWNER TO postgres;

-- FUNCTION: public.getitem(integer, integer)

-- DROP FUNCTION public.getitem(integer, integer);

CREATE OR REPLACE FUNCTION public.getitem(
	idpro integer,
	idtip integer)
    RETURNS TABLE(idprod integer, idtipo integer, cantidad integer, precio integer, nombrefab character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$BEGIN
RETURN QUERY 
	SELECT idpro,idtip,item.cantidad,item.precio,fabrica.nombrefabrica
	FROM "Item" as item, "Fabrica" as fabrica
	WHERE item."Producto_Tipo_Producto_idtipo"=idtip AND item."Producto_id_producto"=idpro AND fabrica.idfabrica=item."Fabrica_idfrabica";
END;
$BODY$;

ALTER FUNCTION public.getitem(integer, integer)
    OWNER TO postgres;

-- FUNCTION: public.getitemtipo(integer)

-- DROP FUNCTION public.getitemtipo(integer);

CREATE OR REPLACE FUNCTION public.getitemtipo(
	tipoprod integer)
    RETURNS TABLE(nomprod character varying, categoria character varying, imagen character varying, cantidad integer) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$BEGIN
RETURN QUERY SELECT dos."nombre_producto",tipo."nombretipo",dos."imagen",dos."Producto_id_producto"
    FROM(
      	SELECT "nombre_producto",prod."imagen",item."Producto_id_producto","Tipo_Producto_idtipo"
      	  FROM "Item"  as item, "Producto" as prod
      WHERE item."Producto_id_producto"= prod."id_producto" AND
         item."Producto_Tipo_Producto_idtipo"=prod."Tipo_Producto_idtipo"
      ) as dos, "Tipo_Producto" as tipo
    WHERE dos."Tipo_Producto_idtipo"=tipo."idtipo" AND tipo."idtipo"=tipoprod;
END;
$BODY$;

ALTER FUNCTION public.getitemtipo(integer)
    OWNER TO postgres;

-- FUNCTION: public.getprod()

-- DROP FUNCTION public.getprod();

CREATE OR REPLACE FUNCTION public.getprod(
	)
    RETURNS TABLE(idprod integer, idtipo integer, nombre character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$BEGIN
RETURN QUERY 
	SELECT id_producto,"Tipo_Producto_idtipo",nombre_producto 
	FROM "Producto";
END;
$BODY$;

ALTER FUNCTION public.getprod()
    OWNER TO postgres;

-- FUNCTION: public.getprodtipo(integer)

-- DROP FUNCTION public.getprodtipo(integer);

CREATE OR REPLACE FUNCTION public.getprodtipo(
	tipoprod integer)
    RETURNS TABLE(nomprod character varying, categoria integer, imagen character varying, idprod integer) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$BEGIN
RETURN QUERY SELECT prod.nombre_producto,prod."Tipo_Producto_idtipo",prod.imagen,prod.id_producto
	FROM "Producto" as prod
	WHERE prod."Tipo_Producto_idtipo"=tipoprod;
END;
$BODY$;

ALTER FUNCTION public.getprodtipo(integer)
    OWNER TO postgres;

-- FUNCTION: public.usermail(character varying)

-- DROP FUNCTION public.usermail(character varying);

CREATE OR REPLACE FUNCTION public.usermail(
	coreo character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$DECLARE
resp boolean:= FALSE;
BEGIN
IF (SELECT count (*)
   	FROM "Usuario" as usuario
    WHERE usuario.correo = coreo) =1 THEN
	resp:=TRUE;
END IF;
return resp;

END;$BODY$;

ALTER FUNCTION public.usermail(character varying)
    OWNER TO postgres;
