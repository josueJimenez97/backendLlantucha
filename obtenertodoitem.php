<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/item.php';
    require_once './clases/producto.php';
    $con=Conexion::obtenerConexion(); //ABRIMOS CONEXION A POSTGRES CONFIGUAR config.php CON LO DATOS DE SU POSTGRES
    $listaProductos=array();
    for($idtipo=1;$idtipo<5;$idtipo++)
    {
        $consulta= $con->prepare("SELECT *
                              FROM gettodoitem()");
        $consulta->execute();
        $resultado=$consulta->fetchAll();
        $lista= array();
        foreach($resultado as $fila){
            $item=new Item($fila[0],$fila[1],$fila[2]);
            $producto=new Producto($fila[3],'','~',0,$fila[4]);
            array_push($listaProductos,$item);
            array_push($listaProductos,$producto);
        }
    }
    
    header('Content-Type: application/json');
    echo json_encode($listaProductos);


?>