-- FUNCTION: public.getprodtipo(integer)

-- DROP FUNCTION public.getprodtipo(integer);

CREATE OR REPLACE FUNCTION public.getprodtipo(
	tipoprod integer)
    RETURNS TABLE(nomprod character varying, categoria character varying, imagen character varying, cantidad integer) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$BEGIN
RETURN QUERY SELECT dos."nombre_producto",tipo."nombretipo",dos."imagen",dos."cantidad"
    FROM(
      	SELECT "nombre_producto",prod."imagen",item."cantidad","Tipo_Producto_idtipo"
      	  FROM "Item"  as item, "Producto" as prod
      WHERE item."Producto_id_producto"= prod."id_producto" AND
         item."Producto_Tipo_Producto_idtipo"=prod."Tipo_Producto_idtipo"
      ) as dos, "Tipo_Producto" as tipo
    WHERE dos."Tipo_Producto_idtipo"=tipo."idtipo" AND tipo."idtipo"=tipoprod;
END;
$BODY$;

ALTER FUNCTION public.getprodtipo(integer)
    OWNER TO postgres;


-- FUNCTION: public.userverificacion(character varying)

-- DROP FUNCTION public.userverificacion(character varying);

CREATE OR REPLACE FUNCTION public.userverificacion(
  correo character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$DECLARE
resp boolean:= FALSE;
BEGIN
IF (SELECT count (*)
    FROM "Usuario" as usuario
    WHERE usuario."correo" = correo) =1 THEN
  resp:=TRUE;
END IF;
return resp;

END;$BODY$;

ALTER FUNCTION public.userverificacion(character varying)
    OWNER TO postgres;
