import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String responseText = ''; // Variable para almacenar la respuesta HTTP
  TextEditingController urlController = TextEditingController(); // Controlador para el campo de entrada de URL

  // Función para realizar la solicitud HTTP y actualizar la respuesta
  void fetchData(String url) async {
    if (url.isEmpty) {
      setState(() {
        responseText = 'Por favor, ingresa una URL válida.';
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // La solicitud se completó con éxito
        setState(() {
          responseText = response.body;
        });
      } else {
        // La solicitud no se completó con éxito
        setState(() {
          responseText = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      // Error de red
      setState(() {
        responseText = 'Error de red: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejemplo de Solicitud HTTP en Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: urlController,
                decoration: InputDecoration(labelText: 'Ingresa la URL'),
              ),
              ElevatedButton(
                onPressed: () {
                  fetchData(urlController.text); // Llama a fetchData con la URL ingresada
                },
                child: Text('Realizar Solicitud HTTP'),
              ),
              SizedBox(height: 20),
              Text('Respuesta HTTP:'),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(responseText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
