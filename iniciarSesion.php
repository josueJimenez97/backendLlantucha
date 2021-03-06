<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/usuario.php';

    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $json = file_get_contents('php://input');
    $usuario=json_decode($json);
    $consulta= $con->prepare('select iduser 
    from "Usuario"
    where "nombre"=? and password=?');
    $consulta->execute([$usuario->user,$usuario->pass]);
    $resultado=$consulta->fetch(PDO::FETCH_OBJ);
    if($resultado){
        
        Usuario::crearSesion($resultado);
        $miRespuesta="correcto";
    }else{
        Usuario::cerrarSesion();
        $miRespuesta="incorrecto";
    }

    header('Content-Type: application/json');
    echo json_encode($miRespuesta);


?>