<?php
require_once ("../bd/Conexion.php");

require_once ("../modelo/Prestador.php");
require_once ("../modelo/Usuario.php");
require_once ("../modelo/Menu.php");
require_once ("../modelo/Restaurante.php");
require_once ("../modelo/Comida.php");
require_once ("../modelo/ComidaHasRestaurante.php");
require_once ("../modelo/RegistroDataGeneral.php");

require_once ("../interfaces/UsuarioDao.php");
require_once ("../interfaces/PrestadorDao.php");
require_once ("../interfaces/MenuDao.php");
require_once ("../interfaces/RestauranteDao.php");
require_once ("../interfaces/ComidaDao.php");
require_once ("../interfaces/ComidaHasRestauranteDao.php");

require_once ("../dao/PrestadorDaoImpl.php");
require_once ("../dao/UsuarioDaoImpl.php");
require_once ("../dao/MenuDaoImpl.php");
require_once ("../dao/RestauranteDaoImpl.php");
require_once ("../dao/ComidaDaoImpl.php");
require_once ("../dao/ComidaHasRestauranteDaoImpl.php");

class Gestor
{
    private $bd;
    private $usuarioDao;
    private $prestadorDao;
    private $menuDao;
    private $restauranteDao;
    private $comidaDao;
    private $comidaHasRestaurante;

    public function __construct()
    {
        $this->bd = Conexion::conexion();
        $this->usuarioDao = new UsuarioDaoImpl($this->bd);
        $this->prestadorDao = new PrestadorDaoImpl($this->bd);
        $this->menuDao = new MenuDaoImpl($this->bd);
        $this->restauranteDao = new RestauranteDaoImpl($this->bd);
        $this->comidaDao = new ComidaDaoImpl($this->bd);
        $this->comidaHasRestaurante = new ComidaHasRestauranteDaoImpl($this->bd);
    }

    public function registrarLogin(Usuario $usuario, Prestador $prestador, Restaurante $restaurante): bool
    {
        $resultado = false;
        $id_foranea = $this->usuarioDao->insertar($usuario);

        $prestador->setId_usuario($id_foranea);

        $id_prestador = $this->prestadorDao->insertar($prestador);

        $restaurante->setId_prestador($id_prestador);

        $id_restaurante = $this->restauranteDao->insertar($restaurante);

        if ($id_restaurante != -1) {
            $resultado = true;
        }

        return $resultado;
    }

    public function validarCorreo(string $correo): bool
    {
        $resultado = $this->usuarioDao->validarCorreo($correo);
        return $resultado;
    }

    public function validarUsuario(string $usuario): bool
    {
        $resultado = $this->usuarioDao->validarUsuario($usuario);
        return $resultado;
    }

    public function verificarLogin(string $usuario, string $password): bool
    {
        $resultado = $this->usuarioDao->verificarLogin($usuario, $password);
        return $resultado;
    }

    public function obtenerTodosMenues(): array
    {
        $vector = $this->menuDao->obtenerTodos();

        return $vector;
    }

    public function obtenerTodosMenuesObjetos(): array
    {
        $vector = $this->menuDao->obtenerTodos();

        return $vector;
    }

    public function obtenerDatosRestaurante(string $us, string $pass): Restaurante
    {
        $usuario = $this->usuarioDao->obtener($us, $pass);
        $prestador = $this->prestadorDao->obtener($usuario->getId());
        $restaurante = $this->restauranteDao->obtener($prestador->getId());

        return $restaurante;
    }
    //
    public function obtenerComidas(int $id, $menu): array
    {
        $comidaarray = $this->comidaDao->obtenerComidas($id, $menu);
        return $comidaarray;
    }
    public function obtenerOneComida(int $id): Comida
    {
        $comida = $this->comidaDao->obtener($id);
        return $comida;
    }

    public function buscarUsuario(string $usuario, string $pass): Usuario
    {
        return $this->usuarioDao->obtener($usuario, $pass);
    }

    public function buscarPrestador(int $id_usuario): Prestador
    {
        return $this->prestadorDao->obtener($id_usuario);
    }

    public function buscarRestaurante(int $id_prestador): Restaurante
    {
        return $this->restauranteDao->obtener($id_prestador);
    }

    public function actualizarUsuario(Usuario $usuario): bool
    {
        return $this->usuarioDao->actualizar($usuario);
    }

    public function actualizarPrestador(Prestador $prestador): bool
    {
        return $this->prestadorDao->actualizar($prestador);
    }

    public function actualizarRestaurante(Restaurante $restaurante): bool
    {
        return $this->restauranteDao->actualizar($restaurante);
    }

    public function obtenerContactos(string $usuario, string $pass): array
    {
        $restaurante = $this->obtenerDatosRestaurante($usuario, $pass);

        $contactos = [
            ['facebook', $restaurante->getFacebook()],
            ['telefono', $restaurante->getTelefono()]
        ];
        return $contactos;
    }
    public function obtenerUsuarioSolo($usuario): Usuario
    {
        return $this->usuarioDao->obtenerSolo($usuario);
    }

    public function obtenerUsuario($usuario, $password): Usuario
    {
        return $this->usuarioDao->obtener($usuario, $password);
    }

    public function obtenerPrestador(int $id_usuario): Prestador
    {
        return $this->prestadorDao->obtener($id_usuario);
    }

    public function obtenerRestaurante(int $id_prestador): Restaurante
    {
        return $this->restauranteDao->obtener($id_prestador);
    }

    public function getRecurso($foto): string
    {
        $recurso = 'data:image/jpg;base64,' . $foto;
        return $recurso;
    }

    public function actualizarDatos(Usuario $usuario, Prestador $prestador, Restaurante $restaurante): bool
    {
        $this->actualizarUsuario($usuario);
        $this->actualizarPrestador($prestador);
        $this->actualizarRestaurante($restaurante);

        return true;
    }

    public function obtenerMenuObj(string $nombre): Menu
    {
        return $this->menuDao->obtener($nombre);
    }

    public function guardarPlato(
        string $usuario,
        string $passowrd,
        Comida $obj_comida,
        Menu $obj_menu
    ): int {
        // TABLA RESTAURANTE
        $obj_restaurante = $this->obtenerDatosRestaurante($usuario, $passowrd);

        // TABLA MENU
        $menu = $this->menuDao->obtener($obj_menu->getNombre());

        // TABAL COMIDA
        $obj_comida->setId_menu($menu->getId());
        $id_comida = $this->comidaDao->insertar($obj_comida);

        // TABLA COMIDA_HAS_RESTAURANTE
        $obj_comida_has_restaurante = new ComidaHasRestaurante();

        $obj_comida_has_restaurante->setId_comida($id_comida);
        $obj_comida_has_restaurante->setId_restaurante($obj_restaurante->getId());

        $this->comidaHasRestaurante->insertar($obj_comida_has_restaurante);

        return $id_comida;
    }


    public function obtenerRepertorio(string $usuario, $password): array
    {
        $obj_restaurante = $this->obtenerDatosRestaurante($usuario, $password);

        $indices_comidas = $this->comidaHasRestaurante->obtenerIndicesComidas($obj_restaurante->getId());

        $comidas = $this->comidaDao->obtenerTodos($indices_comidas);

        return $comidas;
    }

    public function obtenerMenu(int $id): string
    {
        return $this->menuDao->obtenerNombre($id);
    }

    public function obtenerPlatosPorCategoria(int $id_menu, int $id_restaurante): array
    {
        $comidas_by_categoria = array();

        $indices_comidas = $this->comidaHasRestaurante->obtenerIndicesComidas($id_restaurante);
        $comidas = $this->comidaDao->obtenerTodos($indices_comidas);

        foreach ($comidas as $obj) {
            if ($obj->getId_menu() == $id_menu) {
                $comidas_by_categoria[] = $obj;
            }
        }

        return $comidas_by_categoria;
    }

    public function validar(string $password, string $passwordRepeat): bool
    {
        return strcmp($password, $passwordRepeat) == 0;
    }

    public function eliminarComidas(int $id_restaurante): bool
    {
        $v = $this->comidaHasRestaurante->obtenerTodos();
        $indices_comidas = $this->comidaHasRestaurante->obtenerIndicesComidas($id_restaurante);
        $cantidad = count($indices_comidas);

        $i = 0;
        foreach ($v as $obj) {
            if ($obj->getId_restaurante() == $id_restaurante) {
                $result = $this->comidaHasRestaurante->eliminarPorIdRestaurante($id_restaurante);

                if ($result) {
                    $i++;
                }
            }
        }

        foreach ($indices_comidas as $obj) {
            $this->comidaDao->eliminar($obj);
        }


        return $i == $cantidad;
    }

    public function eliminarComidaPorIdComida(int $id_comida): bool
    {
        $v = $this->comidaHasRestaurante->obtenerTodos();
        foreach ($v as $obj) {
            if ($obj->getId_comida() == $id_comida) {
                $result = $this->comidaHasRestaurante->eliminarPorIdComida($id_comida);
            }
        }

        $y = $this->comidaDao->obtenerTodosRegistros();

        foreach ($y as $obj) {
            if ($obj->getId() == $id_comida) {
                $result = $this->comidaDao->eliminar($id_comida);
            }
        }


        return true;
    }

    public function eliminarRestaurante(int $id_restaurante): bool
    {
        return $this->restauranteDao->eliminar($id_restaurante);
    }

    public function eliminarPrestador(int $id_prestador): bool
    {
        return $this->prestadorDao->eliminar($id_prestador);
    }

    public function eliminarUsuario(string $nombre): bool
    {
        return $this->usuarioDao->eliminar($nombre);
    }

}