<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/producto.php';
    
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $miRespuesta="correcto";
    $json = file_get_contents('php://input');
    $ITEM=json_decode($json);

    $categoria= $ITEM->idCategoria;
    $idproducto= $ITEM->idProducto;
    $fabrica= $ITEM->fabrica;
    $cantidad= $ITEM->cantidad;
    $precio= $ITEM->precio;

    $consulta= $con->prepare("select * from getidfabrica(?)");
    $consulta->execute($fabrica);
    $idfabrica=$consulta->fetch(PDO::FETCH_OBJ);// testear esto
    
    $idfabrica=$idfabrica->getidfabrica;
    
    if (!$idfabrica)
    {
        $consulta=$con->prepare("insert into \"Fabrica\"(nombrefabrica) values (?);");
        $consulta->execute($fabrica);


        $consulta= $con->prepare("select * from getidfabrica(?)");
        $consulta->execute($fabrica);

        $idfabrica=$consulta->fetch(PDO::FETCH_OBJ);// testear esto
        $idfabrica=$idfabrica->getidfabrica;
    }
    if (!$idfabrica || !$categoria || !$idproducto || !$fabrica || !$cantidad){
        $miRespuesta="incorrecto2";
    }
    
    $consulta2= $con->prepare("select * from fadd_item(?,?,?,?,?)");
    $consulta2->execute([$categoria,$idproducto,$idfabrica,$cantidad,$precio]);
    $resultado=$consulta2->fetch(PDO::FETCH_OBJ);

    if (!$resultado)
        $miRespuesta="incorrecto3";
    
    
    header('Content-Type: application/json');
    echo json_encode($miRespuesta);


?>