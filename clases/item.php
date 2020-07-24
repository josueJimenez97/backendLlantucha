<?php
    class Item implements JsonSerializable{
        private $nombre;
        private $cantidad;
        private $precio;

        public function __construct($nombre,$cantidad,$precio){
            $this->nombre=$nombre;
            $this->cantidad=$cantidad;
            $this->precio=$precio;
        }
        public function jsonSerialize(){
            return [
                'nombre'=>$this->nombre,
                'cantidad'=>$this->cantidad,
                'precio'=>$this->precio
            ];
        }
    }
?>