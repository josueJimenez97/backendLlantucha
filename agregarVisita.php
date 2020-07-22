<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/usuario.php';

    $con=Conexion::obtenerConexion(); 
    $usuariologin=Usuario::obtenerSesion(); 
    $idtipo = $_GET['idTipo'];// requerimos id del interfaz
    $tiempo = $_GET['tiempo'];
    $miRespuesta="correcto";    

    $consulta=$con->prepare("CALL add_visita( ?,? ?,?)");
    $consulta->execute([$usuariologin,$idtipo,$tiempo]);
    $resultado=$consulta->fetch(PDO::FETCH_OBJ);

    if(!$usuariologin || !$idtipo|| !$resultado){
        $miRespuesta="incorrecto";
    }
    
    echo json_encode($miRespuesta);


?>