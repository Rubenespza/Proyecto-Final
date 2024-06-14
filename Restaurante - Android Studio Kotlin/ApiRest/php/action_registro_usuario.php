<?php
header('Content-Type: application/json');

require_once ("../controlador/Gestor.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $gestor = new Gestor();

    $usuario = $_POST['inputUsuario'];
    $pass = $_POST['inputPassword'];
    $passRepeat = $_POST['inputPasswordRepeat'];

    // Validar usuario
    $verificar_usuario = $gestor->validarUsuario($usuario);

    if ($verificar_usuario) {
        session_start();
        $_SESSION['usuario_existe'] = true;
        header("location: ../index.php");
        exit();
    }

    // Validar contraseñas
    $result = $gestor->validar($pass, $passRepeat);

    if (!$result) {
        session_start();
        $_SESSION['password_diferentes'] = true;
        header("location: ../index.php");
        exit();
    }

    session_start();
    $_SESSION['usuario'] = $usuario;
    $_SESSION['password'] = $pass;
    header("location: ../vista/completar_perfil.php");
    exit();
} else {
    $response = [
        'msg' => "Los datos no llegaron!"
    ];
    echo json_encode($response);
}
