<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/producto.php';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $json = file_get_contents('php://input');
    
    $idTipo=$_GET['idTipo'];
    $consulta= $con->prepare("SELECT*
    FROM(
      SELECT \"nombre_producto\",\"imagen\",\"cantidad\",\"Tipo_Producto_idtipo\"
        FROM \"Item\"  as item, \"Producto\" as prod
      WHERE item.\"Producto_id_producto\"= prod.\"id_producto\" AND
         item.\"Producto_Tipo_Producto_idtipo\"=prod.\"Tipo_Producto_idtipo\"
      ) as dos, \"Tipo_Producto\" as tipo
    WHERE dos.\"Tipo_Producto_idtipo\"=tipo.\"idtipo\" AND tipo.\"nombretipo\"='Obra Gruesa'");
    $consulta->execute();
    $consulta->execute([$prod->categoria]);
    /*$resp=$consulta->fetch(PDO::FETCH_OBJ);
    $resp->nombre;
    if ($consulta->fetch(PDO::FETCH_OBJ))
    {
        print("yes");
    }
    */
    $resultado=$consulta->fetchAll();
    
    $listaProductos=array();
    foreach($resultado as $fila){
        $producto=new Producto($fila[0],$fila[5],$fila[1],$fila[2]);
        array_push($listaProductos,$producto);
    }
    header('Content-Type: application/json');
    echo json_encode($listaProductos);


?>