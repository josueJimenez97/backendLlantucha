<?php
    class Producto implements JsonSerializable{
        private $nombre;
        private $categoria;
        private $imagen;
        private $cantidad;

        public function __construct($nombre,$categoria,$imagen,$cantidad){
            $this->nombre=$nombre;
            $this->categoria=$categoria;
            $this->imagen=$imagen;
            $this->cantidad=$cantidad;
        }

        public function ejecutarAccion($accion){
            $res=false;
            switch($accion){
                case "nada": $res=true;
                break;
                case "insertar": $res=$this->insertarProducto();
            }
            return $res;
        }

        private function insertarProducto(){
            $res=true;
            try{
                $con=Conexion::obtenerConexion();
                $consulta= $con->prepare("insert into producto (nombre,imagen,categoria,cantidad) 
                values (?,?,?,?)");
                $consulta->execute([$this->nombre,$this->imagen,$this->categoria,$this->cantidad]);
               
            }catch(PDOException $ex){
                $res=false;
            }
            return $res;
        }
        public function jsonSerialize(){
            return [
                'nombre'=>$this->nombre,
                'categoria'=>$this->categoria,
                'imagen'=>$this->imagen,
                'cantidad'=>$this->cantidad
            ];
        }
    }
?>