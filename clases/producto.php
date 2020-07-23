<?php
    class Producto implements JsonSerializable{
        private $nombre;
        private $categoria;
        private $imagen;
        private $precio;
        public function __construct($nombre,$categoria,$imagen, $precio){
            $this->nombre=$nombre;
            $this->categoria=$categoria;
            $this->imagen=$imagen;
            $this->precio=$precio;
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
            $res=10;
            try{
                $con=Conexion::obtenerConexion();
                $consulta= $con->prepare('select * from fadd_product(?,?,?,?)');
                $consulta->execute([$this->categoria,$this->nombre,$this->imagen,$this->precio]);
               
            }catch(PDOException $ex){
                $res=-10;
            }
            $res=$consulta->fetch(PDO::FETCH_OBJ);//test this
            
        }
        public function jsonSerialize(){
            return [
                'nombre'=>$this->nombre,
                'categoria'=>$this->categoria,
                'imagen'=>$this->imagen,
                'precio'=>$this->precio
                
            ];
        }
    }
?>