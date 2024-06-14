<?php
class RestauranteDaoImpl implements RestauranteDao
{
    private $bd;
    public function __construct($conexion)
    {
        $this->bd = $conexion;
    }

    /**
     * @param Restaurante $restaurante
     * @return int
     */
    public function insertar(Restaurante $restaurante): int
    {
        $nombre = $restaurante->getNombre();
        $direccion = $restaurante->getDireccion();
        $telefono = $restaurante->getTelefono();
        $id_prestador = $restaurante->getId_prestador();
        $facebook = $restaurante->getFacebook();
        $foto = $restaurante->getFoto();
        $descripcion = $restaurante->getDescripcion();

        $sql = "insert into  restaurante (nombre, direccion, telefono, Prestador_id, facebook, foto, descripcion) values 
                    (:nombre, :direccion, :telefono, :Prestador_id, :facebook, :foto, :descripcion)";
        $crear = $this->bd->prepare($sql);

        $crear->bindParam(":nombre", $nombre);
        $crear->bindParam(":direccion", $direccion);
        $crear->bindParam(":telefono", $telefono);
        $crear->bindParam(":Prestador_id", $id_prestador);
        $crear->bindParam(":facebook", $facebook);
        $crear->bindParam(":foto", $foto, PDO::PARAM_LOB);
        $crear->bindParam(":descripcion", $descripcion);

        $crear->execute();

        $id_foranea = $this->bd->lastInsertId();

        return $id_foranea;
    }
    /**
     * @param int $id_prestador
     * @return Restaurante
     */
    public function obtener(int $id_prestador): Restaurante
    {
        $obj = new Restaurante();

        $sql = "select * from Restaurante where Prestador_id=?";
        $consulta = $this->bd->prepare($sql);

        $consulta->bindParam(1, $id_prestador);
        $consulta->execute();

        $result = $consulta->fetchAll();


        foreach ($result as $r) {
            $obj->setId($r["id"]);
            $obj->setNombre(($r["nombre"]));
            $obj->setDireccion($r["direccion"]);
            $obj->setTelefono($r["telefono"]);
            $obj->setId_prestador($r["Prestador_id"]);
            $obj->setFacebook($r["facebook"]);
            $obj->setFoto(base64_encode($r["foto"]));
            $obj->setDescripcion($r["descripcion"]);
        }

        return $obj;
    }
    /**
     * @param Restaurante $restaurante
     * @return bool
     */
    public function actualizar(Restaurante $restaurante): bool
    {
        $id = $restaurante->getId();
        $nombre = $restaurante->getNombre();
        $direccion = $restaurante->getDireccion();
        $telefono = $restaurante->getTelefono();
        $id_prestador = $restaurante->getId_prestador();
        $facebook = $restaurante->getFacebook();
        $foto = $restaurante->getFoto();
        $descripcion = $restaurante->getDescripcion();


        $sql = "UPDATE Restaurante 
        SET nombre=?, direccion=?, telefono=?, Prestador_id=?,
         facebook=?, foto=?, descripcion=?
          WHERE id=?";

        $crear = $this->bd->prepare($sql);

        $crear->bindParam(1, $nombre);
        $crear->bindParam(2, $direccion);
        $crear->bindParam(3, $telefono);
        $crear->bindParam(4, $id_prestador);
        $crear->bindParam(5, $facebook);
        $crear->bindParam(6, $foto);
        $crear->bindParam(7, $descripcion);
        $crear->bindParam(8, $id);

        $resultado = $crear->execute();
        return $resultado;
    }

    public function eliminar(int $id): bool
    {
        $sql = "DELETE FROM Restaurante WHERE id = :id";
        $crear = $this->bd->prepare($sql);
        $crear->bindParam(":id", $id);
        $crear->execute();

        $filasAfectadas = $crear->rowCount();

        if ($filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}

    }
}