<?php
require_once ("../controlador/Gestor.php");



if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usuario = isset($_POST['usuario']) ? $_POST['usuario'] : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';
    $gestor = new Gestor();

    $obj = $gestor->obtenerDatosRestaurante($usuario, $password);


    if ($obj) {
        $response = [
            'acceso' => true,
            'msg' => json_encode($obj)
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
