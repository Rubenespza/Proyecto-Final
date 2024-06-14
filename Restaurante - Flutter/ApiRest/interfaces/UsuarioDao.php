<?php
interface UsuarioDao
{
    public function insertar(Usuario $usuario): int;

    public function existe(string $us, string $pass): bool;

    public function validarCorreo(string $correo) : bool;

    public function validarUsuario(string $usuario) : bool;

    public function verificarLogin(string $usuario, string $password) : bool;

    public function obtener(string $usuario, string $pass) : Usuario;

    public function obtenerSolo(string $usuario) : Usuario;

    public function actualizar(Usuario $usuario) : bool;
    
    public function eliminar(string $usuario) : bool;
}


?>