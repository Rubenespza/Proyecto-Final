<?php
header('Content-Type: application/json');

require_once ("../controlador/Gestor.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $gestor = new Gestor();

    $json = file_get_contents('php://input');
    $data = json_decode($json);
    
    $obj_usuario = new Usuario();
    $obj_prestador = new Prestador();
    $obj_restaurante = new Restaurante();

    $obj_usuario->fromJson($data->usuario);
    $obj_prestador->fromJson($data->prestador);
    $obj_restaurante->fromJson($data->restaurante);

    $gestor->actualizarDatos($obj_usuario, $obj_prestador, $obj_restaurante);

    $response = [
        'acceso' => true,
        'msg' => "exito!"
    ];
    echo json_encode($response);

} else {
    $response = [
        'msg' => "Los datos no llegaron!"
    ];
    echo json_encode($response);
}



