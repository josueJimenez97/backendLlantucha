<?php
    class Producto implements JsonSerializable{
        private $nombre;
        private $categoria;
        private $imagen;
        private $idcategoria;
        private $idproducto;

        public function __construct($nombre,$categoria,$imagen,$idcategoria,$idproducto=-1){
            $this->nombre=$nombre;
            $this->categoria=$categoria;
            $this->imagen=$imagen;
            $this->idcategoria=$idcategoria;
            $this->idproducto=$idproducto;
        }

        public function ejecutarAccion($accion){
            $res=-10;
            switch($accion){
                case "nada": $res=1;
                break;
                case "insertar": $res=$this->insertarProducto();
            }
            return $res;
        }

        private function insertarProducto(){
            $res=-10;
            try{
                $con=Conexion::obtenerConexion();
                $consulta= $con->prepare('select * from fadd_producto(?,?,?)');
                $consulta->execute([$this->idcategoria,$this->nombre,$this->imagen]);
                $res=$consulta->fetch(PDO::FETCH_OBJ);//test this
                $res=$res->fadd_producto;
            }catch(PDOException $ex){
                $res=-$this->idcategoria-1;
            }
            
            return $res;
            
        }
        public function jsonSerialize(){
            return [
                'nombre'=>$this->nombre,
                'categoria'=>$this->categoria,
                'imagen'=>$this->imagen,
                'idCategoria'=>$this->idcategoria,
                'idproducto'=>$this->idproducto
            ];
        }
    }
?>