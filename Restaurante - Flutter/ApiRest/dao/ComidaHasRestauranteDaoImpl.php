<?php
class ComidaHasRestauranteDaoImpl implements ComidaHasRestauranteDao
{
    private $bd;
    public function __construct($conexion)
    {
        $this->bd = $conexion;
    }

    /**
     * @param ComidaHasRestaurante $obj
     */
    public function insertar(ComidaHasRestaurante $obj): void
    {

        $id_comida = $obj->getId_comida();
        $id_restaurante = $obj->getId_restaurante();

        $sql1 = "insert into  Comida_has_Restaurante (Comida_id, Restaurante_id) values (?, ?)";

        $crear = $this->bd->prepare($sql1);
        $crear->bindParam(1, $id_comida);
        $crear->bindParam(2, $id_restaurante);
        $crear->execute();
    }
    /**
     * @param int $id_restaurante
     * @return array
     */
    public function obtenerIndicesComidas(int $id_restaurante): array
    {
        $indices = array();

        $sql = "select * from Comida_has_Restaurante where Restaurante_id=?";
        $consulta = $this->bd->prepare($sql);

        $consulta->bindParam(1, $id_restaurante);
        $consulta->execute();
        $result = $consulta->fetchAll();

        foreach ($result as $r) {
            $indices[] = $r["Comida_id"];
        }

        return $indices;
    }

    public function eliminar(int $id_comida, int $id_restaurante): bool
    {
        $sql = "delete from Comida_has_Restaurante where Comida_id =? and Restaurante_id =?";
        $eliminar = $this->bd->prepare($sql);
        $eliminar->bindParam(1, $id_comida);
        $eliminar->bindParam(2, $id_restaurante);
        $eliminar->execute();

        $filasAfectadas = $eliminar->rowCount();

		if ($filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}
    }

    public function eliminarPorIdRestaurante(int $id_restaurante): bool
    {
        $sql = "delete from Comida_has_Restaurante where Restaurante_id =?";
        $eliminar = $this->bd->prepare($sql);
        $eliminar->bindParam(1, $id_restaurante);
        $eliminar->execute();

        $filasAfectadas = $eliminar->rowCount();

		if ($filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}
    }

    public function eliminarPorIdComida(int $id_comida): bool
    {
        $sql = "delete from Comida_has_Restaurante where Comida_id =?";
        $eliminar = $this->bd->prepare($sql);
        $eliminar->bindParam(1, $id_comida);
        $eliminar->execute();

        $filasAfectadas = $eliminar->rowCount();

		if ($filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}
    }

    public function obtenerTodos(): array
    {
        $v = array();

        $sql = "select * from Comida_has_Restaurante;";

        $consulta = $this->bd->prepare($sql);
        $consulta->execute();

        $result = $consulta->fetchAll();

        foreach ($result as $r) {
            $obj = new ComidaHasRestaurante();

            $obj->setId_comida($r["Comida_id"]);
            $obj->setId_restaurante($r["Restaurante_id"]);

            $v[] = $obj;
        }

        return $v;
    }

    public function obtener(int $id): ComidaHasRestaurante{
        $obj = new ComidaHasRestaurante();
        $sql = "select * from Comida_has_Restaurante where id=?";
        $consulta = $this->bd->prepare($sql);
        $consulta->bindParam(1, $id);
        $consulta->execute();
        $result = $consulta->fetchAll();
        foreach ($result as $r) {
            $obj->setId_comida($r["Comida_id"]);
            $obj->setId_restaurante($r["Restaurante_id"]);
        }
        return $obj;
    }
}