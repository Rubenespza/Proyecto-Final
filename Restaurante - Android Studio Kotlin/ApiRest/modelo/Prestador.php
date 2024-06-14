<?php
class Prestador
{
    public int $id;
    public string $nombre;
    public string $apellido;
    public string $direccion;
    public int $id_usuario;

    public function __construct()
    {
		$msg_indeterminado = "indefindo";

        $this->id = -1;
		$this->nombre = $msg_indeterminado;
        $this->apellido = $msg_indeterminado;
        $this->direccion = $msg_indeterminado;
        $this->id_usuario = -1;
    }

	/**
	 * @return int
	 */
	public function getId(): int {
		return $this->id;
	}
	
	/**
	 * @param int $id 
	 * @return self
	 */
	public function setId(int $id): self {
		$this->id = $id;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getNombre(): string {
		return $this->nombre;
	}
	
	/**
	 * @param string $nombre 
	 * @return self
	 */
	public function setNombre(string $nombre): self {
		$this->nombre = $nombre;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getApellido(): string {
		return $this->apellido;
	}
	
	/**
	 * @param string $apellido 
	 * @return self
	 */
	public function setApellido(string $apellido): self {
		$this->apellido = $apellido;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getDireccion(): string {
		return $this->direccion;
	}
	
	/**
	 * @param string $direccion 
	 * @return self
	 */
	public function setDireccion(string $direccion): self {
		$this->direccion = $direccion;
		return $this;
	}

	/**
	 * @return int
	 */
	public function getId_usuario(): int {
		return $this->id_usuario;
	}
	
	/**
	 * @param int $id_usuario 
	 * @return self
	 */
	public function setId_usuario(int $id_usuario): self {
		$this->id_usuario = $id_usuario;
		return $this;
	}

	public function fromJson($data) {
        foreach ($data as $key => $value) {
            if (property_exists($this, $key)) {
                $this->$key = $value;
            }
        }
    }
}
	
?>