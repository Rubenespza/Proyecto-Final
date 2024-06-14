import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_NAME = "MyAppPrefs";
const String KEY_JSON = "json";

// Función para guardar datos
Future<void> saveData(BuildContext context, String msg) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(KEY_JSON, msg);
}

// Función para obtener datos
Future<String?> getData(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(KEY_JSON);
}
