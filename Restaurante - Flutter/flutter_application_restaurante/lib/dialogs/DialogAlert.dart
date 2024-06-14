import 'package:flutter/material.dart';

void showProgressDialog(String msg, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Previene el cierre del diálogo al tocar fuera
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text(msg),
            ],
          ),
        ),
      );
    },
  );
}

void showCloseDialog(String msg, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Previene el cierre del diálogo al tocar fuera
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(msg),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                },
                child: Text('Cerrar'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void hideProgressDialog(BuildContext context) {
  Navigator.of(context).pop(); // Cierra el diálogo
}
