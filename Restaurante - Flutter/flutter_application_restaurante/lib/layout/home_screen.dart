import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_restaurante/action/actions_registro_principal.dart';
import 'package:flutter_application_restaurante/dialogs/dialog_alta_comida.dart';
import 'package:flutter_application_restaurante/layout/ItemComidaWidget%20.dart';
import 'package:flutter_application_restaurante/layout/ItemMenuWidget%20.dart';
import 'package:flutter_application_restaurante/model/comida.dart';
import 'package:flutter_application_restaurante/model/menu.dart';

final GlobalKey<_HomeScreenState> homeScreenKey = GlobalKey<_HomeScreenState>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Menu>>? _futureMenu;
  Future<List<Comida>>? _futureComidas;
  Menu _selectedMenu = new Menu();
  String titulo = "Muestrario";

  @override
  void initState() {
    super.initState();
    _loadMenus();
  }

  void _loadMenus() async {
    List<Menu> menuList = await cargarMenus(context);
    setState(() {
      _futureMenu = Future.value(menuList);
      if (menuList.isNotEmpty) {
        _selectedMenu = menuList.first;

        titulo = _selectedMenu.nombre;
        _loadComidas(_selectedMenu.id, _selectedMenu.nombre);
      }
    });
  }

  void _loadComidas(int id_menu, String nombre_menu) {
    setState(() {
      titulo = nombre_menu;
      _futureComidas = obtenerComidas(context, id_menu, nombre_menu);
    });
  }

  void _onMenuItemClick(Menu menu) {
    titulo = menu.nombre;
    _selectedMenu = menu;
    _loadComidas(menu.id, menu.nombre);
  }

  void _onComidaItemClick(int id_comida) async {
    await eliminarComida(id_comida);
    _loadComidas(1, 'Burguer');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TITULO
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              child: const Text(
                'Menús',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //LISTA MENU
            FutureBuilder<List<Menu>>(
              future: _futureMenu,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text('Error al cargar los menús');
                } else {
                  List<Menu>? menuList = snapshot.data;
                  if (menuList != null && menuList.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: menuList.length,
                        itemBuilder: (context, index) {
                          return MenuItemWidget(
                            menu: menuList[index],
                            onClick: _onMenuItemClick,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                        child: Text('No hay menús disponibles'));
                  }
                }
              },
            ),
            //BOTON AGREGAR
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    // Acción al presionar el botón
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NuevoComidaDialog(_selectedMenu);
                      },
                    );
                  },
                  backgroundColor: Colors.pink,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),

            // TITULO MUESTRARIO
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                titulo,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // LISTA  MUESTRARIO
            Container(
              height: 400,
              child: Column(
                children: [
                  FutureBuilder<List<Comida>>(
                    future: _futureComidas,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Text('Error al cargar las comidas');
                      } else {
                        List<Comida>? comidaList = snapshot.data;
                        if (comidaList != null && comidaList.isNotEmpty) {
                          return Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemCount: comidaList.length,
                              itemBuilder: (context, index) {
                                return ItemComidaWidget(
                                  id_comida: comidaList[index].id,
                                  foto: comidaList[index].foto ?? '',
                                  nombre: comidaList[index].nombre,
                                  precio: comidaList[index].precio.toString(),
                                  onClick: _onComidaItemClick,
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/ic_vacio.png',
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(height: 10),
                                const Text('Sin resultados',
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
