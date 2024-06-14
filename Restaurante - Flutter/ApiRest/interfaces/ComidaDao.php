<?php
interface ComidaDao
{
    public function insertar(Comida $comida): int;
    public function obtenerComidas(int $id, $menu): array;
    public function obtener(int $id): Comida;
    public function actualizar(Comida $comida): void;

    public function obtenerTodos(array $indices): array;
    public function eliminar(int $id): bool;
    public function obtenerTodosRegistros(): array;

}

?>