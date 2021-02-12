import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:http/http.dart' as http;

class BarCode extends StatefulWidget {
  @override
  _BarCodeState createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCode> {

  String _data = "No hay ningun Escaneo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: Text("Codigo de barras"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Resultado",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _data,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(50)),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () async {
                  _scan();
                },
                child: Text("Escanear codigo de barras",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  //escanea los datos encriptados

  // void _scan() async {
  //   await FlutterBarcodeScanner.scanBarcode(
  //           "#000000", "cancel", true, ScanMode.BARCODE)
  //       .then((value) => setState(() => _data = value));
  // }

  //Imprime en consola

  // void _scan() async {
  //   await FlutterBarcodeScanner.scanBarcode(
  //           "#000000", "cancel", true, ScanMode.BARCODE)
  //       .then((value) {
  //         sendDataToServer(value);
  //         setState(() => _data = value);
  //         });
  // }

  //trae difenrentes datos
  
  // void _scan() async {
  //   await FlutterBarcodeScanner.scanBarcode(
  //           "#000000", "cancel", true, ScanMode.BARCODE)
  //       .then((value) async{
  //         String respuestaServer = await sendDataToServer(value).toString();

  //         setState(() => _data = respuestaServer);
  //         });
  // }

  void _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "cancel", true, ScanMode.BARCODE)
        .then((value) async {
      String respuestaServer = jsonEncode(await sendDataToServer(value));

      setState(() => _data = respuestaServer);
    });
  }

  Future<Map<String, dynamic>> sendDataToServer(String bodyReq) async {
    Map<String, dynamic> respuesta;
    try {
      var url =
          'https://us-central1-cc-col.cloudfunctions.net/transformPdf417CCtoDataCol';
      var response =
          await http.post(url, body: bodyReq).timeout(Duration(seconds: 60));
      print('**************************************');
      print(bodyReq);
      print('Response status save-data: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        respuesta = jsonDecode(response.body);
        print(respuesta);
        return respuesta;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
