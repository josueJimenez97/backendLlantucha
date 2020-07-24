<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/item.php';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $idtipo = $_GET['idtipo'];
    $idproducto = $_GET['idproducto'];
    $consulta= $con->prepare("SELECT *
                              FROM getitem( ?,? )");
    if (!$idproducto || !$idtipo)
    {
        echo json_encode("incorrecto");
    }

    $consulta->execute([$idproducto,$idtipo]);
    $resultado=$consulta->fetchAll();
    $listaItems=array();
    foreach($resultado as $fila){
        $item=new Item($fila[4],$fila[2],$fila[3]);
        array_push($listaItems,$item);
    }
    header('Content-Type: application/json');
    echo json_encode($listaItems);


?>