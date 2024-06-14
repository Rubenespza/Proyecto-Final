<?php

interface RestauranteDao
{
    public function insertar(Restaurante $restaurante): int;
    public function obtener(int $id_prestador) : Restaurante;
    public function actualizar(Restaurante $restaurante) : bool;

    public function eliminar(int $id): bool;
}

?>