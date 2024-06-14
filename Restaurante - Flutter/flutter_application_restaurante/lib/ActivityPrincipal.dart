import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_restaurante/controlador/restclient.dart';
import 'package:flutter_application_restaurante/loguinActivity.dart';
import 'package:flutter_application_restaurante/util/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'layout/home_screen.dart';
import 'layout/profile_screen.dart';

void main() {
  runApp(ActivityPrincipal());
}

class ActivityPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> eliminarCuenta() async {
    String? jsonString = await getData(context);
    if (jsonString != null) {
      Map<String, dynamic> jsonObject = jsonDecode(jsonString);
      String usuario = jsonObject['usuario'];
      String password = jsonObject['password'];

      final dio = Dio(); // Provide a dio instance
      dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
      dio.options.headers['Demo-Header'] =
          'demo header'; // config your dio headers globally

      final client = RestClient(dio);
      final response = await client.eliminar(usuario, password);

      String responseBody = jsonEncode(response.data);
      Map<String, dynamic> map =
          json.decode(responseBody); // Utiliza json.decode aquí
      bool acceso = map['acceso'];

      if (acceso) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );

        Fluttertoast.showToast(
          msg: "Cuenta eliminada exitosamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error: no ha sido eliminado!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurante App'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'delete',
                child: Text('Eliminar'),
              ),
              PopupMenuItem(
                value: 'exit',
                child: Text('Salir de la app'),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                // Acción para eliminar
                eliminarCuenta();
              } else if (value == 'exit') {
                // Acción para salir de la app
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.pink,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
