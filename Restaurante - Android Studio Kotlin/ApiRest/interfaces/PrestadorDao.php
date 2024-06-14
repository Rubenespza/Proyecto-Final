<?php
interface PrestadorDao
{
    public function insertar(Prestador $prestador): int;

    public function existe(Prestador $prestador): bool;

    public function actualizar(Prestador $prestador) : bool;

    public function obtener(int $id_usuario) : Prestador;

    public function eliminar(int $id) : bool;
}

?>