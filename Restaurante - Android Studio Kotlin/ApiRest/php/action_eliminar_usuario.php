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
    $result1 = $gestor->eliminarComidas($obj_restaurante->getId());
    $result2 = $gestor->eliminarRestaurante($obj_restaurante->getId());
    $result3 = $gestor->eliminarPrestador($obj_prestador->getId());
    $result4 = $gestor->eliminarUsuario($obj_usuario->getUsuario());

    if ($result1 && $result2 && $result3 && $result4) {

        $response = [
            'acceso' => true,
            'msg' => "Exito!"
        ];
        echo json_encode($response);
    } else {
        $response = [
            'acceso' => false,
            'msg' => "El usuario no fue eliminado!"
        ];
        echo json_encode($response);
    }

} else {
    $response = [
        'msg' => "Los datos no llegaron!"
    ];
    echo json_encode($response);
}



