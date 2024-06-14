import 'package:flutter/material.dart';
import '../util/AppColors.dart';
import '../util/AppString.dart';

class Slide0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr, // Especifica la dirección del texto
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors
              .dot_dark_screen1, // Reemplaza esto con el color equivalente a dot_dark_screen1
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ic_food.png', // Reemplaza esto con la ruta correcta de tu imagen
                  width:
                      200.0, // Reemplaza esto con el valor correspondiente de img_width_height
                  height:
                      200.0, // Reemplaza esto con el valor correspondiente de img_width_height
                ),
                Text(
                  AppString
                      .slide_0_title, // Reemplaza esto con el valor correspondiente de slide_0_title
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        24.0, // Reemplaza esto con el valor correspondiente de slide_title
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          16.0), // Reemplaza esto con el valor correspondiente de desc_padding
                  child: Text(
                    AppString
                        .slide_0_desc, // Reemplaza esto con el valor correspondiente de slide_0_desc
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          16.0, // Reemplaza esto con el valor correspondiente de slide_desc
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Slide0(),
  ));
}
