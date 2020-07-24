<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/producto.php';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $idtipo = $_GET['idTipo'];
    $consulta= $con->prepare("SELECT *
                              FROM getprodtipo( ? )");
    $consulta->execute([$idtipo]);
    
    $resultado=$consulta->fetchAll();
    
    $listaProductos=array();
    foreach($resultado as $fila){
        $producto=new Producto($fila[0],$fila[1],$fila[2],$idtipo,$fila[3]);
        array_push($listaProductos,$producto);
    }
    header('Content-Type: application/json');
    echo json_encode($listaProductos);


?>