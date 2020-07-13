<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/Producto';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $json = file_get_contents('php://input');
    $prod=json_decode($json);
    $miRespuesta="correcto";
    $producto=new Producto($prod->nombre,$prod->categoria,$prod->imagen,$prod->cantidad);
    $resp=$producto->ejecutarAccion("insertar");
    if(!$resp){
        $miRespuesta="incorrecto";
    }
    
    header('Content-Type: application/json');
    echo json_encode($miRespuesta);


?>