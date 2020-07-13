<?php
//clase encargada de establecer la conexion con la base de datos postgres
class Conexion{
    private static $conexion;
    //establece una conexion a la base de datos solo si no se ha establecido anteriormente
    public static function abrirConexion(){
        
        if(!isset(self::$conexion)){
            try{
                include_once 'config.php';
                self::$conexion= new PDO('pgsql:host='.SERVIDOR.'; dbname='.BASE_DATOS, NOMBRE_USUARIO, CONTRASENIA);
                self::$conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                self::$conexion->exec("SET NAMES 'UTF8'");
            }catch(PDOException $ex){
                print "ERROR".$ex->getMessage()."<br>";
            }
        }
    }
    //cierra la conexion con la base de datos
    public static function cerrarConexion(){
        
        if(isset(self::$conexion)){
            self::$conexion=null;
        }
    }
    //devuelve la conexion, en caso de no tener la conexion..procede a abrirla
    public static function obtenerConexion(){

        if(!isset(self::$conexion)){
            self::abrirConexion();
        }
        return self::$conexion;
    }
}
?>