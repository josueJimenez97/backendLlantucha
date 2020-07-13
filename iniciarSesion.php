<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';

    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $json = file_get_contents('php://input');
    $usuario=json_decode($json);
    $consulta= $con->prepare('select idusuario 
    from usuario
    where "nombreUsuario"=? and contrasenia=?');
    $consulta->execute([$usuario->user,$usuario->pass]);
    $resultado=$consulta->fetch(PDO::FETCH_OBJ);
    if($resultado){
        $miRespuesta="correcto";
    }else{
        $miRespuesta="incorrecto";
    }
    header('Content-Type: application/json');
    echo json_encode($miRespuesta);


?>