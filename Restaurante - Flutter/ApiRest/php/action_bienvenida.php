<?php
require_once("../controlador/Gestor.php");


$gestor = new Gestor();

$menues = $gestor->obtenerTodosMenues();

header('Content-Type: application/json');

$json = json_encode($menues);


echo $json;
