<?php
header('Content-Type: application/json');

require_once ("../controlador/Gestor.php");

$gestor = new Gestor();
// Verificar si los datos esperados están presentes en la solicitud
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $json = file_get_contents('php://input');
    $data = json_decode($json, true); // Decodificar a un array asociativo

    if (isset($data['comida'], $data['id_restaurante'])) {
        $comida = $data['comida'];
        $id_restaurante = $data['id_restaurante'];
        $nombre_menu = $data['menu'];
        $usuario = $data['usuario'];
        $password = $data['password'];

        $obj_menu = $gestor->obtenerMenuObj($nombre_menu);
        $obj_comida = new Comida();

        $obj_comida->setNombre($comida['nombre']);
        $obj_comida->setPrecio($comida['precio']);
        $obj_comida->setFoto(base64_decode($comida['foto']));
        $obj_comida->setDescripcion($comida['descripcion']);
        $obj_comida->setId($comida['idMenu']);

        // Llamar a la función registrarLogin con los objetos configurados
        $resultado = $gestor->guardarPlato($usuario, $password, $obj_comida, $obj_menu);

        // Devolver una respuesta según el resultado de la operación
        if ($resultado) {
            // Operación exitosa
            $response = [
                'acceso' => true,
                'msg' => "Exito!"
            ];
        } else {
            // Error en la operación
            $response = [
                'acceso' => false,
                'msg' => "La comida no ha sido guardad!"
            ];
        }
    } else {
        // Datos faltantes en la solicitud
        $response = [
            'acceso' => false,
            'msg' => "Datos incompletos en la solicitud"
        ];
    }

    echo json_encode($response);
} else {
    // Datos esperados no presentes en la solicitud
    echo json_encode(array("mensaje" => "Datos insuficientes"));
}
