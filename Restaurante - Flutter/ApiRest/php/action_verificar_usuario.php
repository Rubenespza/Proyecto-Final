<?php
header('Content-Type: application/json');

require_once ("../controlador/Gestor.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usuario = isset($_POST['usuario']) ? $_POST['usuario'] : '';

    $gestor = new Gestor();

    $validar_login = $gestor->validarUsuario($usuario);

    if ($validar_login) {

        $response = [
            'acceso' => false,
            'msg' => "Exito!"
        ];
        echo json_encode($response);
    } else {
        $response = [
            'acceso' => true,
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



