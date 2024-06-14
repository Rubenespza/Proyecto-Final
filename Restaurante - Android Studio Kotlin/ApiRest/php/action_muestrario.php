<?php
require_once ("../controlador/Gestor.php");

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id_menu = isset($_POST['id_menu']) ? $_POST['id_menu'] : '-1';
    $id_restaurante = isset($_POST['id_restaurante']) ? $_POST['id_restaurante'] : '-1';


    $gestor = new Gestor();

    $platos = $gestor->obtenerPlatosPorCategoria((int)$id_menu, (int)$id_restaurante);

    header('Content-Type: application/json');

    $json = json_encode($platos);
    echo $json;


} else {
    $response = [
        'msg' => "Los datos no llegaron!"
    ];
    echo json_encode($response);
}



