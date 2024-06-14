<?php
header('Content-Type: application/json');

require_once ("../controlador/Gestor.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id_comida = isset($_POST['id_comida']) ? $_POST['id_comida'] : '';

    $gestor = new Gestor();


    $result = $gestor->eliminarComidaPorIdComida((int)$id_comida);

    if ($result) {

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



