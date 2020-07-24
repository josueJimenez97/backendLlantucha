<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/producto.php';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $json = file_get_contents('php://input');
    $prod=json_decode($json);
    $miRespuesta=-10;// <0 si esta mal
    $producto=new Producto($prod->nombre,$prod->categoria,$prod->imagen,$prod->idCategoria);
    
    $resp=$producto->ejecutarAccion("insertar");
    echo $prod->nombre.$prod->categoria.$prod->imagen;
    //cambiar resp para devolver el id del producto insertardo 
    
    header('Content-Type: application/json');
    echo json_encode($miRespuesta);


?>