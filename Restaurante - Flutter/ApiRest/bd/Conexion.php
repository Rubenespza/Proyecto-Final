<?php
    class Conexion{
        //public static $conexion;
        public static function conexion() : PDO{
        
                try{
                    $conexion= new PDO ('mysql:host=localhost; dbname=restaurante','root','');
                    $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                    $conexion->exec("SET CHARACTER SET UTF8");
                }
                catch(Exception $e){
                    die("Error" . $e->getMessage());
                }
            return   $conexion;      
        }
    }
