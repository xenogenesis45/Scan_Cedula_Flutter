import 'package:flutter/material.dart';

import 'package:scan_cedula/scan_cedula.dart';

// void main(){
//   runApp(
//     MaterialApp(
//       home: MyApp(),
//     )
//   );
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
    
//     return BarCode();
    
//   }
// }


void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      //oculta el debug de la parte superio
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => BarCode()
      },
      //Cambia color de toda la aplicacion
      theme: ThemeData(
        primaryColor: Colors.purple
      ), 
    );
  }
}


