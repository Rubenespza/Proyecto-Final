<?php
class UsuarioDaoImpl implements UsuarioDao
{
	private $bd;
	public function __construct($conexion)
	{
		$this->bd = $conexion;
	}
	/**
	 *
	 * @param Usuario $usuario
	 *
	 * @return int
	 */
	function insertar(Usuario $usuario): int
	{
		$us = $usuario->getUsuario();
		$pass = $usuario->getPassword();

		$sql1 = "insert into  Usuario (usuario, password) values (:usuario, :pass)";

		$crear = $this->bd->prepare($sql1);
		$crear->bindParam(":usuario", $us);
		$crear->bindParam(":pass", $pass);
		$crear->execute();

		$id_foranea = $this->bd->lastInsertId();

		return $id_foranea;
	}

	/**
	 *
	 * @param Usuario $usuario
	 *
	 * @return bool
	 */
	public function existe(string $user, string $clave): bool
	{
		$consulta = $this->bd->prepare("select * from Usuario where usuario=:usuario and password=:clave");

		$consulta->bindParam(":usuario", $user);
		$consulta->bindParam(":clave", $clave);
		$consulta->execute();

		$numero_registros = $consulta->rowCount();

		if ($numero_registros != 0) {
			return true;
		}
		return false;
	}

	/**
	 * @param string $correo
	 * @return bool
	 */
	public function validarCorreo(string $correo): bool
	{
		$vcorreo = "select * from Usuario WHERE correo = :correo";

		$consulta = $this->bd->prepare($vcorreo);

		$consulta->bindParam(":correo", $correo);
		$consulta->execute();

		$numero_registros = $consulta->rowCount();

		if ($numero_registros != 0) {
			return true;
		}
		return false;
	}
	/**
	 * @param string $usuario
	 * @return bool
	 */
	public function validarUsuario(string $usuario): bool
	{
		$vusuario = "select * from Usuario WHERE usuario = :usuario";

		$consulta = $this->bd->prepare($vusuario);

		$consulta->bindParam(":usuario", $usuario);
		$consulta->execute();

		$numero_registros = $consulta->rowCount();

		if ($numero_registros != 0) {
			return true;
		}
		return false;
	}
	/**
	 * @param string $correo
	 * @param string $password
	 * @return bool
	 */
	public function verificarLogin(string $usuario, string $password): bool
	{
		$consulta = $this->bd->prepare("select * from Usuario where usuario=:usuario and password=:password");

		$consulta->bindParam(":usuario", $usuario);
		$consulta->bindParam(":password", $password);
		$consulta->execute();

		$numero_registros = $consulta->rowCount();

		if ($numero_registros != 0) {
			return true;
		}
		return false;
	}
	/**
	 * @param string $usuario
	 * @return mixed
	 */
	public function obtener(string $usuario, string $pass): Usuario
	{
		$obj = new Usuario();

		$sql = "select * from Usuario where usuario=:usuario and password=:pass";
		$consulta = $this->bd->prepare($sql);

		$consulta->bindParam(":usuario", $usuario);
		$consulta->bindParam(":pass", $pass);
		$consulta->execute();

		$result = $consulta->fetchAll();

		foreach ($result as $r) {

			$obj->setId($r["id"]);
			$obj->setUsuario(($r["usuario"]));
			$obj->setPassword($r["password"]);
		}

		return $obj;
	}

	public function obtenerSolo(string $usuario): Usuario
	{
		$obj = new Usuario();

		$sql = "select * from Usuario where usuario=:usuario";
		$consulta = $this->bd->prepare($sql);

		$consulta->bindParam(":usuario", $usuario);
		$consulta->execute();

		$result = $consulta->fetchAll();

		foreach ($result as $r) {

			$obj->setId($r["id"]);
			$obj->setUsuario(($r["usuario"]));
			$obj->setPassword($r["password"]);
		}

		return $obj;
	}

	/**
	 * @param Usuario $usuario
	 * @return bool
	 */
	public function actualizar(Usuario $usuario): bool
	{
		$id = $usuario->getId();
		$user = $usuario->getUsuario();
		$password = $usuario->getPassword();

		$sql = "UPDATE Usuario SET usuario=:usuario, password=:password WHERE id=:id";

		$crear = $this->bd->prepare($sql);

		$crear->bindParam(":id", $id);
		$crear->bindParam(":usuario", $user);
		$crear->bindParam(":password", $password);

		$resultado = $crear->execute();

		return $resultado;
	}

	public function eliminar(string $usuario): bool
	{
		$sql = "DELETE FROM Usuario WHERE usuario = :usuario";
		$consulta = $this->bd->prepare($sql);
		$consulta->bindParam(":usuario", $usuario);
		$consulta->execute();

		$filasAfectadas = $consulta->rowCount();

		if ($filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}

	}
}
