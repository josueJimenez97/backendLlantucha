<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/producto.php';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $idproducto = $_GET['idproducto'];
    $idtipo = $_GET['idtipo'];
    $consulta= $con->prepare("SELECT *
                              FROM getitem( ?,? )");
    if (!$idproducto || !$idtipo)
    {
        echo json_encode("incorrecto");
    }

    $consulta->execute([$idtipo,$idproducto]);
    $resultado=$consulta->fetchAll();
    $listaProductos=array();
    foreach($resultado as $fila){
        $item=array();
        
        $item['precio']=$fila[0];
        $item['nombrefab']=$fila[1];
        
        array_push($listaProductos,$item);
    }
    header('Content-Type: application/json');
    echo json_encode($listaProductos);


?>