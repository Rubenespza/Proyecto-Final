<?php
class PrestadorDaoImpl implements PrestadorDao
{
    private $bd;
    public function __construct($conexion)
    {
        $this->bd = $conexion;
    }
    /**
     *
     * @param Prestador $prestador
     *
     * @return int
     */
    function insertar(Prestador $prestador): int
    {
        $nombre_prestador = $prestador->getNombre();
        $apellido_prestador = $prestador->getApellido();
        $direcion_prestador = $prestador->getDireccion();
        $id_usuario_prestador = $prestador->getId_usuario();

        $sql3 = "insert into  prestador (nombre, apellido, direccion, Usuario_id) values 
                    (:nombre, :apellido, :direccion, :id_foranea)";
        $crear = $this->bd->prepare($sql3);

        $crear->bindParam(":nombre", $nombre_prestador);
        $crear->bindParam(":apellido", $apellido_prestador);
        $crear->bindParam(":direccion", $direcion_prestador);
        $crear->bindParam(":id_foranea", $id_usuario_prestador);
        $crear->execute();

        $id_foranea =$this->bd->lastInsertId();

        return $id_foranea;
    }

    function actualizar(Prestador $prestador): bool{
        $id = $prestador->getId();
        $nombre_prestador = $prestador->getNombre();
        $apellido_prestador = $prestador->getApellido();
        $direcion_prestador = $prestador->getDireccion();
        $id_usuario_prestador = $prestador->getId_usuario();
        
        $sql = "UPDATE Prestador SET nombre=:nombre, apellido=:apellido, direccion=:direccion, Usuario_id=:id_usuario WHERE id=:id";

        $crear = $this->bd->prepare($sql);
        
        $crear->bindParam(":id", $id);
        $crear->bindParam(":nombre", $nombre_prestador);
        $crear->bindParam(":apellido", $apellido_prestador);
        $crear->bindParam(":direccion", $direcion_prestador);
        $crear->bindParam(":id_usuario", $id_usuario_prestador);

        $resultado = $crear->execute();
        return $resultado;
    }

    /**
     *
     * @param prestador $prestador
     *
     * @return bool
     */
    function existe(prestador $prestador): bool
    {

        return false;
    }
	/**
	 * @param int $id_usuario
	 * @return Prestador
	 */
	public function obtener(int $id_usuario): Prestador {
        $obj = new Prestador();

		$sql = "select * from Prestador where Usuario_id=:id_usuario";
		$consulta = $this->bd->prepare($sql);

		$consulta->bindParam(":id_usuario", $id_usuario);
		$consulta->execute();

		$result = $consulta->fetchAll();

        foreach ($result as $r) {
            $obj->setId($r["id"]);
            $obj->setNombre(($r["nombre"]));
            $obj->setApellido($r["apellido"]);
			$obj->setDireccion($r["direccion"]);
            $obj->setId_usuario($r["Usuario_id"]);
        }

        return $obj;
	}

    public function eliminar(int $id): bool
    {
        $sql = "DELETE FROM Prestador WHERE id = :id";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(":id", $id);
        $stmt->execute();

        $filasAfectadas = $stmt->rowCount();

        if ($filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}

    }
}
