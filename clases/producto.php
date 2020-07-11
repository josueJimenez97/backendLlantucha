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