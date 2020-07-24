<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/producto.php';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    
    $consulta= $con->prepare("SELECT *
    FROM \"Producto\"");
    $consulta->execute();    
    $resultado=$consulta->fetchAll();
    
    $listaProductos=array();
    foreach($resultado as $fila){
        $producto=new Producto($fila[2],'~',$fila[3],$fila[1],$fila[0]);
        array_push($listaProductos,$producto);
    }
    header('Content-Type: application/json');
    echo json_encode($listaProductos);


?>