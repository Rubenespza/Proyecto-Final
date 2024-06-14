<?php
class Restaurante
{
    public int $id;
    public string $nombre;
    public string $direccion;
    public string $telefono;
    public int $id_prestador;
    public string $facebook;
    public string $descripcion;
    public string $foto;


    public function __construct()
    {
        $msg_indefinido = "indefinido";

        $this->id = -1;
        $this->nombre = $msg_indefinido;
        $this->direccion = $msg_indefinido;
        $this->telefono = $msg_indefinido;
        $this->id_prestador = -1;
        $this->facebook = $msg_indefinido;
        $this->descripcion = $msg_indefinido;
    }

    /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }

    /**
     * @param int $id 
     * @return self
     */
    public function setId(int $id): self
    {
        $this->id = $id;
        return $this;
    }

    /**
     * @return string
     */
    public function getNombre(): string
    {
        return $this->nombre;
    }

    /**
     * @param string $nombre 
     * @return self
     */
    public function setNombre(string $nombre): self
    {
        $this->nombre = $nombre;
        return $this;
    }

    /**
     * @return string
     */
    public function getDireccion(): string
    {
        return $this->direccion;
    }

    /**
     * @param string $direccion 
     * @return self
     */
    public function setDireccion(string $direccion): self
    {
        $this->direccion = $direccion;
        return $this;
    }

    /**
     * @return string
     */
    public function getTelefono(): string
    {
        return $this->telefono;
    }

    /**
     * @param string $telefono 
     * @return self
     */
    public function setTelefono(string $telefono): self
    {
        $this->telefono = $telefono;
        return $this;
    }

    /**
     * @return int
     */
    public function getId_prestador(): int
    {
        return $this->id_prestador;
    }

    /**
     * @param int $id_prestador 
     * @return self
     */
    public function setId_prestador(int $id_prestador): self
    {
        $this->id_prestador = $id_prestador;
        return $this;
    }


    /**
     * @return string
     */
    public function getFacebook(): string
    {
        return $this->facebook;
    }

    /**
     * @param string $facebook 
     * @return self
     */
    public function setFacebook(string $facebook): self
    {
        $this->facebook = $facebook;
        return $this;
    }


    /**
     * @return mixed
     */
    public function getFoto()
    {
        return $this->foto;
    }

    /**
     * @param mixed $foto 
     * @return self
     */
    public function setFoto($foto): self
    {
        $this->foto = $foto;
        return $this;
    }

    /**
     * @return string
     */
    public function getDescripcion(): string
    {
        return $this->descripcion;
    }

    /**
     * @param string $descripcion 
     * @return self
     */
    public function setDescripcion(string $descripcion): self
    {
        $this->descripcion = $descripcion;
        return $this;
    }

    public function fromJson($data) {
        if (isset($data->id)) {
            $this->setId($data->id);
        }

        if (isset($data->nombre)) {
            $this->setNombre($data->nombre);
        }

        if (isset($data->direccion)) {
            $this->setDireccion($data->direccion);
        }

        if (isset($data->telefono)) {
            $this->setTelefono($data->telefono);
        }

        if (isset($data->id_prestador)) {
            $this->setId_prestador($data->id_prestador);
        }

        if (isset($data->facebook)) {
            $this->setFacebook($data->facebook);
        }

        if (isset($data->descripcion)) {
            $this->setDescripcion($data->descripcion);
        }

        if (isset($data->foto)) {
            $this->setFoto(base64_decode($data->foto));
        }
    }
}