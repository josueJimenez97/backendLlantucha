<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/producto.php';
    
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $miRespuesta="correcto";

    $categoria= $_GET['categoria'];
    $idproducto= $_GET['idproducto'];
    $fabrica= $_GET['fabrica'];
    $cantidad= $_GET['cantidad'];

    $consulta= $con->prepare("select * from getidfabrica(?)");
    $consulta->execute($fabrica);
    $idfabrica=$consulta->fetch(PDO::FETCH_OBJ);// testear esto
    if (!$idfabrica || !$categoria || !$idproducto || !$fabrica || !$cantidad)
        $miRespuesta="incorrecto";

    $consulta= $con->prepare("call add_item(?,?,?)");
    $consulta->execute($categoria,$idproducto,$idfabrica,$cantidad);
    $idfabrica=$consulta->fetch(PDO::FETCH_OBJ);

    if (!$idfabrica)
        $miRespuesta="incorrecto";
    
    
    header('Content-Type: application/json');
    echo json_encode($miRespuesta);


?>