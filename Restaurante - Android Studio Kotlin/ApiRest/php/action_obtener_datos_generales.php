<?php
header('Content-Type: application/json');

require_once ("../controlador/Gestor.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usuario = isset($_POST['usuario']) ? $_POST['usuario'] : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';

    $gestor = new Gestor();

    $obj_usuario = $gestor->obtenerUsuario($usuario, $password);
    $obj_prestador = $gestor->obtenerPrestador($obj_usuario->getId());
    $obj_restaurante = $gestor->obtenerDatosRestaurante($usuario, $password);
   
    $obj_registroDataGeneral = new RegistroDataGeneral();

    $obj_registroDataGeneral->usuario= $obj_usuario;
    $obj_registroDataGeneral->prestador = $obj_prestador;
    $obj_registroDataGeneral->restaurante = $obj_restaurante;
    
    $response = [
        'obj' => json_encode($obj_registroDataGeneral)
    ];
    echo json_encode($response);

} else {
    $response = [
        'msg' => "Los datos no llegaron!"
    ];
    echo json_encode($response);
}



