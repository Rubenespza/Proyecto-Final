<?php
class Usuario
{
    public int $id;
    public string $usuario;
    public string $password;
	
    public function __construct()
    {
		$msg_sin_usuario = "sin usuario.";
		$msg_sin_password = "sin password.";

        $this->id = -1;
        $this->usuario = $msg_sin_usuario;
        $this->password = $msg_sin_password;
    }

    
	/**
	 * @return int
	 */
	function getId(): int {
		return $this->id;
	}
	
	/**
	 * @param int $id 
	 * @return Usuario
	 */
	function setId(int $id): self {
		$this->id = $id;
		return $this;
	}
	/**
	 * @return string
	 */
	function getUsuario(): string {
		return $this->usuario;
	}
	
	/**
	 * @param string $usuario 
	 * @return Usuario
	 */
	function setUsuario(string $usuario): self {
		$this->usuario = $usuario;
		return $this;
	}
	/**
	 * @return string
	 */
	function getPassword(): string {
		return $this->password;
	}
	
	/**
	 * @param string $password 
	 * @return Usuario
	 */
	function setPassword(string $password): self {
		$this->password = $password;
		return $this;
	}

	public function fromJson($data) {
        foreach ($data as $key => $value) {
            if (property_exists($this, $key)) {
                $this->$key = $value;
            }
        }
    }
	
	public function __toString() {
        return "Usuario {id: $this->id, usuario: '$this->usuario', password: '$this->password'}";
    }
}

?>