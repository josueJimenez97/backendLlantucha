-- PROCEDURE: public.add_item(integer, integer, integer, integer, integer)

-- DROP PROCEDURE public.add_item(integer, integer, integer, integer, integer);

CREATE OR REPLACE PROCEDURE public.add_item(
	idtipo integer,
	idproducto integer,
	idfabrica integer,
	cant integer,
	precio integer)
LANGUAGE 'plpgsql'
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
	COMMIT;
END IF;

END;$BODY$;
-- PROCEDURE: public.add_producto(integer, character varying, character varying)

-- DROP PROCEDURE public.add_producto(integer, character varying, character varying);

CREATE OR REPLACE PROCEDURE public.add_producto(
	idtipo integer,
	nombre character varying,
	imagen character varying)
LANGUAGE 'plpgsql'
AS $BODY$BEGIN
insert into "Producto"("Tipo_Producto_idtipo",nombre_producto,imagen)
values (idtipo,nombre,imagen);

END;$BODY$;
-- PROCEDURE: public.add_usuario(character varying, character varying, character varying)

-- DROP PROCEDURE public.add_usuario(character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE public.add_usuario(
	nombre character varying,
	passw character varying,
	correo character varying)
LANGUAGE 'plpgsql'
AS $BODY$BEGIN
	INSERT INTO "Usuario"(nombre,correo,password)
	VALUES (nombre,correo,passw);
END;$BODY$;
-- PROCEDURE: public.add_venta(integer)

-- DROP PROCEDURE public.add_venta(integer);

CREATE OR REPLACE PROCEDURE public.add_venta(
	userid integer)
LANGUAGE 'plpgsql'
AS $BODY$BEGIN
	INSERT INTO "Venta"("Usuario_iduser",fechaventa)
	VALUES (userid,now());
END;$BODY$;
-- PROCEDURE: public.add_visita(integer, integer, double precision)

-- DROP PROCEDURE public.add_visita(integer, integer, double precision);

CREATE OR REPLACE PROCEDURE public.add_visita(
	userid integer,
	interfazid integer,
	tiempo double precision)
LANGUAGE 'plpgsql'
AS $BODY$BEGIN
	INSERT INTO "Visita"
	VALUES (now(),userid,interfazid,tiempo);
	
	   
END;$BODY$;
