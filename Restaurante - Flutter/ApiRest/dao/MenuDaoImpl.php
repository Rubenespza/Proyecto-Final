<?php
class MenuDaoImpl implements MenuDao
{
    private $bd;
    public function __construct($conexion)
    {
        $this->bd = $conexion;
    }

    /**
     * @return array
     */
    public function obtenerTodos(): array
    {
        $v = array();

        $sql = "select * from menu";
        $crear = $this->bd->prepare($sql);

        $crear->execute();

        $result = $crear->fetchAll();

        foreach ($result as $r) {
            $obj = new Menu();

            $obj->setId($r["id_menu"]);
            $obj->setNombre($r["nombre"]);
			$obj->foto = base64_encode($r["foto"]);

            $v[] = $obj;
        }

        return $v;
    }
	/**
	 * @param string $nombre
	 * @return Menu
	 */
	public function obtener(string $nombre): Menu {
        $obj = new Menu();

		$sql = "select * from Menu where nombre=?";
		$consulta = $this->bd->prepare($sql);

		$consulta->bindParam(1, $nombre);
		$consulta->execute();
		$result = $consulta->fetchAll();

		foreach ($result as $r) {
			$obj->setId($r["id_menu"]);
			$obj->setNombre($r["nombre"]);
			$obj->foto = $r["foto"];
		}

		return $obj;
	}
	/**
	 * @param int $id
	 * @return string
	 */
	public function obtenerNombre(int $id): string {
        $obj = new Menu();

		$sql = "select * from Menu where id_menu=?";
		$consulta = $this->bd->prepare($sql);

		$consulta->bindParam(1, $id);
		$consulta->execute();
		$result = $consulta->fetchAll();

		foreach ($result as $r) {
			$obj->setId($r["id_menu"]);
			$obj->setNombre($r["nombre"]);
			$obj->foto = $r["foto"];
		}

		return $obj->getNombre();
	}

	
	public function actualizar(Menu $menu): bool
    {
        $sql = "UPDATE menu SET nombre = :nombre WHERE id_menu = :id";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':nombre', $menu->getNombre());
        $stmt->bindParam(':id', $menu->getId());
        return $stmt->execute();
    }

    public function eliminar(string $nombre): bool
    {
        $sql = "DELETE FROM menu WHERE nombre = :nombre";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':nombre', $nombre);
        $stmt->execute();

        $filasAfectadas = $stmt->rowCount();

		if ($filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}
    }

    public function insertar(Menu $menu): bool
    {
        $sql = "INSERT INTO menu (nombre, foto) VALUES (:nombre, :foto)";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':nombre', $menu->getNombre());
        $stmt->bindParam(':foto', $menu->foto);
        return $stmt->execute();
    }
}
