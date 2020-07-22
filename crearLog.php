<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/usuario.php';

    $con=Conexion::obtenerConexion(); 
    $usuariologin=Usuario::obtenerSesion(); 
    
    $miRespuesta="correcto";    

    if(!$usuariologin || !$idtipo){
        $miRespuesta="incorrecto";
    }
    
    echo json_encode($miRespuesta);


?>