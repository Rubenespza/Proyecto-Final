<?php
interface ComidaHasRestauranteDao
{
    public function insertar(ComidaHasRestaurante $obj): void;

    public function obtenerIndicesComidas(int $id_restaurante): array;

    public function eliminar(int $id_comida, int $id_restaurante): bool;

    public function eliminarPorIdRestaurante(int $id_restaurante): bool;
    public function eliminarPorIdComida(int $id_comida): bool;

    public function obtenerTodos() : array;
}

?>