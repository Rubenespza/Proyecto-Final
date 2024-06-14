<?php
class ComidaHasRestaurante
{
    private int $id_comida;
    private int $id_restaurante;

    public function __construct()
    {

        $this->id_comida = -1;
		$this->id_restaurante = -1;
    }

	/**
	 * @return int
	 */
	public function getId_restaurante(): int {
		return $this->id_restaurante;
	}
	
	/**
	 * @param int $id_restaurante 
	 * @return self
	 */
	public function setId_restaurante(int $id_restaurante): self {
		$this->id_restaurante = $id_restaurante;
		return $this;
	}

	/**
	 * @return int
	 */
	public function getId_comida(): int {
		return $this->id_comida;
	}
	
	/**
	 * @param int $id_comida 
	 * @return self
	 */
	public function setId_comida(int $id_comida): self {
		$this->id_comida = $id_comida;
		return $this;
	}
}