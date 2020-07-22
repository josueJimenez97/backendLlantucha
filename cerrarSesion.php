<?php
    header('Access-Control-Allow-Origin: *'); 
    header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
    require_once './conexion.php';
    require_once './clases/usuario.php';
    Conexion::cerrarConexion();
    Usuario::cerrarSesion();
    
    header('Content-Type: application/json');
    echo "Correcto";

?>