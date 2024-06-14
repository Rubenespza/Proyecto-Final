<?php
class Menu
{
    public int $id;
	public string $nombre;
	public string $foto;
    public function __construct()
    {
        $_id = -1;
        $_nombre = "Indefenido";

        $this->id = $_id;
        $this->nombre = $_nombre;
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


}
