<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/Producto.php';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES

    $consulta= $con->prepare("select * from producto");
    $consulta->execute();
    $resultado=$consulta->fetchAll();
    $listaProductos=array();
    foreach($resultado as $fila){
        $producto=new Producto($fila[1],$fila[3],$fila[2],$fila[4]);
        array_push($listaProductos,$producto);
    }
    header('Content-Type: application/json');
    echo json_encode($listaProductos);


?>