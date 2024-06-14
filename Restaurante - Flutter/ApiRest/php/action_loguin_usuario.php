<?php
header('Content-Type: application/json');

require_once ("../controlador/Gestor.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usuario = isset($_POST['usuario']) ? $_POST['usuario'] : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';

    $gestor = new Gestor();

    $validar_login = $gestor->verificarLogin($usuario, $password);
    $obj_usuario = $gestor->obtenerUsuario($usuario, $password);
    $obj_restaurante = $gestor->obtenerDatosRestaurante($usuario, $password);

    if ($validar_login) {

        $response = [
            'usuario' => $usuario,
            'password' => $password,
            'id_restaurante' => $obj_restaurante->getId(),
            'acceso' => true,
            'msg' => "Exito!"
        ];
        echo json_encode($response);
    } else {
        $response = [
            'acceso' => false,
            'msg' => "El usuario no existe!"
        ];
        echo json_encode($response);
    }

} else {
    $response = [
        'msg' => "Los datos no llegaron!"
    ];
    echo json_encode($response);
}



