<?php
class Comida
{
    public int $id;
    public string $nombre;
	public int $id_menu;
	public string $precio;
	public string $foto;
	public string $descripcion;

    public function __construct()
    {
		$msg_indeterminado = "indefindo";

        $this->id = -1;
        $this->nombre = $msg_indeterminado;
        $this->id_menu = -1;
		$this->precio = $msg_indeterminado;
		$this->descripcion = $msg_indeterminado;
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
	 * @return int
	 */
	public function getId_menu(): int {
		return $this->id_menu;
	}
	
	/**
	 * @param int $id_menu 
	 * @return self
	 */
	public function setId_menu(int $id_menu): self {
		$this->id_menu = $id_menu;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getFoto() {
		return $this->foto;
	}
	
	/**
	 * @param mixed $foto 
	 * @return self
	 */
	public function setFoto($foto): self {
		$this->foto = $foto;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getDescripcion(): string {
		return $this->descripcion;
	}
	
	/**
	 * @param string $descripcion 
	 * @return self
	 */
	public function setDescripcion(string $descripcion): self {
		$this->descripcion = $descripcion;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getPrecio(): string {
		return $this->precio;
	}
	
	/**
	 * @param string $precio 
	 * @return self
	 */
	public function setPrecio(string $precio): self {
		$this->precio = $precio;
		return $this;
	}
}