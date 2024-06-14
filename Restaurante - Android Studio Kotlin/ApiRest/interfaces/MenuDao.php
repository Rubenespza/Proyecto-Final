<?php
interface MenuDao
{
    public function obtenerTodos(): array;

    public function obtener(string $nombre): Menu;

    public function obtenerNombre(int $id): string;

    public function eliminar(string $nombre): bool;

    public function actualizar(Menu $menu): bool;

    public function insertar(Menu $menu): bool;
    

}


?>