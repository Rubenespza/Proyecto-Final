<?php
header('Content-Type: application/json');

require_once ("../controlador/Gestor.php");

$gestor = new Gestor();
// Verificar si los datos esperados están presentes en la solicitud
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $json = file_get_contents('php://input');
    $data = json_decode($json, true); // Decodificar a un array asociativo

    if (isset($data['usuario'], $data['prestador'], $data['restaurante'])) {
        $usuario = $data['usuario'];
        $prestador = $data['prestador'];
        $restaurante = $data['restaurante'];

        // Crear instancias de las clases Usuario, Prestador y Restaurante
        $obj_usuario = new Usuario();
        $obj_prestador = new Prestador();
        $obj_restaurante = new Restaurante();

        // Configurar los datos recibidos en las instancias de las clases correspondientes
        $obj_usuario->setUsuario($usuario['usuario']);
        $obj_usuario->setPassword($usuario['password']);

        $obj_prestador->setNombre($prestador['nombre']);
        $obj_prestador->setApellido($prestador['apellido']);
        $obj_prestador->setDireccion($prestador['direccion']);

        $obj_restaurante->setNombre($restaurante['nombre']);
        $obj_restaurante->setDireccion($restaurante['direccion']);
        $obj_restaurante->setTelefono($restaurante['telefono']);
        $obj_restaurante->setFacebook($restaurante['facebook']);
        $obj_restaurante->setDescripcion($restaurante['descripcion']);
        $obj_restaurante->setFoto(base64_decode($restaurante['foto']));

        // Llamar a la función registrarLogin con los objetos configurados
        $resultado = $gestor->registrarLogin($obj_usuario, $obj_prestador, $obj_restaurante);

        // Devolver una respuesta según el resultado de la operación
        if ($resultado) {
            $obj = $gestor->obtenerDatosRestaurante($usuario['usuario'], $usuario['password']);

            // Operación exitosa
            $response = [
                'usuario' => $usuario['usuario'],
                'password' => $usuario['password'],
                'id_restaurante' => $obj->getId(),
                'acceso' => true,
                'msg' => "Exito!"
            ];
        } else {
            // Error en la operación
            $response = [
                'acceso' => false,
                'msg' => "El usuario no existe!"
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
