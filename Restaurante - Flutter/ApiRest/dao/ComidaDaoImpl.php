<?php
class ComidaDaoImpl implements ComidaDao
{
    private $bd;
    public function __construct($conexion)
    {
        $this->bd = $conexion;
    }

	/**
	 * @param Comida $comida
	 * @return int
	 */
	public function insertar(Comida $comida): int {
		$nombre = $comida->getNombre();
        $id_menu = $comida->getId_menu();
		$precio = $comida->getPrecio();
		$foto = $comida->getFoto();
		$descripcion = $comida->getDescripcion();

		$sql = "insert into  Comida (nombre, id_menu, precio, foto, descripcion) values (?, ?, ?, ?, ?)";

		$crear = $this->bd->prepare($sql);
		$crear->bindParam(1, $nombre);
        $crear->bindParam(2, $id_menu);
		$crear->bindParam(3, $precio);
		$crear->bindParam(4, $foto);
		$crear->bindParam(5, $descripcion);
		$crear->execute();

		$id_foranea =$this->bd->lastInsertId();

		return $id_foranea;
	}
	
	/**
	 *
	 * @param int $id
	 * @return array
	 */
	public function obtenerComidas(int $id, $menu): array {

		$arraycomida=array(array());
        $obj = new Comida();

		for($i=0;$i<count($menu);$i++) {

			$sql = "select * from Comida where id in 
				(select Comida_id from Comida_has_Restaurante where Restaurante_id in
				(select id from Restaurante where Prestador_id in 
				(select id from Prestador where Usuario_id=?))) and id_menu in 
				(select id_menu from Menu where nombre='".$menu[$i]."');";

			$consulta = $this->bd->prepare($sql);

			$consulta->bindParam(1, $id);
			$consulta->execute();

			$result = $consulta->fetchAll();

			foreach($result as $r){
				$obj->setId($r["id"]);
				$obj->setNombre(($r["nombre"]));
				$obj->setId_Menu($r["id_menu"]);
				$obj->setPrecio($r["precio"]);
				$arraycomida[$i][]=$obj;
			}

        }

        return $arraycomida;
	}
    
	public function obtener(int $id): Comida {

        $obj = new Comida();

		$sql = "select * from Comida where id = ?;";

		$consulta = $this->bd->prepare($sql);

		$consulta->bindParam(1, $id);
		$consulta->execute();

		$result = $consulta->fetchAll();

        foreach ($result as $r) {

            $obj->setId($r["id"]);
            $obj->setNombre($r["nombre"]);
			$obj->setId_menu($r["id_menu"]);
			$obj->setPrecio($r["precio"]);
			$obj->setFoto(base64_encode($r["foto"]));
			$obj->setDescripcion($r["descripcion"]);
        }

        return $obj;
	}
	public function actualizar(Comida $comida): void{
		$id = $comida->getId();
        $nombre = $comida->getNombre();
       
		$sql = "UPDATE Comida SET nombre=?  WHERE id=?";

		$crear = $this->bd->prepare($sql);

        $crear->bindParam(1, $nombre);
        $crear->bindParam(2, $id);
        
        $crear->execute();
	}
	/**
	 * @param array $indices
	 * @return array
	 */
	public function obtenerTodos(array $indices): array {
		$comidas = Array();

		foreach($indices as $id){
			$sql = "select * from Comida where id = ?;";
	
			$consulta = $this->bd->prepare($sql);
	
			$consulta->bindParam(1, $id);
			$consulta->execute();
	
			$result = $consulta->fetchAll();
	
			foreach ($result as $r) {
				$comidas[] = $this->obtener($r["id"]);
			}
		}
		

        return $comidas;
	}

	public function eliminar(int $id): bool {
        $sql = "DELETE FROM Comida WHERE id =?";

        $eliminar = $this->bd->prepare($sql);
        $eliminar->bindParam(1, $id);
        $eliminar->execute();

		$filasAfectadas = $eliminar->rowCount();

		if ($filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}
    }

	public function obtenerTodosRegistros(): array
    {
        $v = array();

        $sql = "select * from Comida;";

        $consulta = $this->bd->prepare($sql);
        $consulta->execute();

        $result = $consulta->fetchAll();

        foreach ($result as $r) {
            $v[] = $this->obtener($r["id"]);
        }

        return $v;
    }


}