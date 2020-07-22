<?php
    class Usuario implements JsonSerializable{
        private static $userid;

        
        //cierra la conexion con la base de datos
        public static function cerrarSesion(){
            self::$userid=null;
        }
        //devuelve la conexion, en caso de no tener la conexion..procede a abrirla
        public static function crearSesion($valor){
            self::$userid=$valor;
            return self::$userid;
        }
        public static function obtenerSesion(){
            return self::$userid;
        }
        public function jsonSerialize(){
            return [
                'userid'=>$this->userid,
            ];
        }
    }
?>
