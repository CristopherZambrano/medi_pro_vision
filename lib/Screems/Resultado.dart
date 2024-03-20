import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Resultado extends StatelessWidget {
  Resultado({super.key});

  Map<String, Color> customTheme = {
    'primary': const Color(0xFF1976D2),
    'primaryVariant': const Color(0xFF004BA0),
    'secondary': const Color(0xFFFFA000),
    'scaffoldBackgroundColor': const Color(0xFFF3F4F6),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Risk Assessment',
      theme: ThemeData(
        primaryColor: customTheme['primary'],
        scaffoldBackgroundColor: customTheme['scaffoldBackgroundColor'],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 45),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      home: DiabetesRiskScreen(customTheme: customTheme),
    );
  }
}

class DiabetesRiskScreen extends StatelessWidget {
  final Map<String, Color> customTheme;
  String name = '';
  int edad = 0;
  double pedigree = 0;
  DiabetesRiskScreen({required this.customTheme});

  void initState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Response =
        await buscarPaciente(prefs.getString('Patient').toString());
    User us = parseUserString(Response.data);
    name = '${us.nombre} ${us.apellido}';
    edad = calcularEdad(us.fechaNacimiento);
    pedigree = 0.075 * edad + 0.212 * (prefs.getInt("pedigree") ?? 0);
  }

  void userCharge(String diagnosis) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? Doctor = prefs.getInt('idUser');
    final Response =
        await buscarPaciente(prefs.getString('Patient').toString());
    User us = parseUserString(Response.data);
    final Response2 =
        await guardarDiagnostico(us.id, diagnosis, Doctor.toString());
  }

  int calcularEdad(String fechaNacimiento) {
    DateTime fechaNacimientoDateTime = DateTime.parse(fechaNacimiento);
    DateTime ahora = DateTime.now();

    int edad = ahora.year - fechaNacimientoDateTime.year;
    if (ahora.month < fechaNacimientoDateTime.month ||
        (ahora.month == fechaNacimientoDateTime.month &&
            ahora.day < fechaNacimientoDateTime.day)) {
      edad--;
    }
    return edad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk Assessment'),
        backgroundColor: customTheme['primaryVariant'],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Patient Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Name: $name'),
            Text('Age: $edad'),
            Text('Pedigree: $pedigree'),
            SizedBox(height: 20),
            Text(
              'Diabetes Risk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Your estimated risk is 80%'),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Validate Diagnosis'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(),
                    child: Text('Reject'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

User parseUserString(String userString) {
  List<String> parts = userString.split(', ');
  int id = int.parse(parts[0].substring(parts[0].indexOf('=') + 1));
  String nombre = parts[1].substring(parts[1].indexOf('=') + 1);
  String apellido = parts[2].substring(parts[2].indexOf('=') + 1);
  String email = parts[3].substring(parts[3].indexOf('=') + 1);
  String fechaNacimiento = parts[4].substring(parts[4].indexOf('=') + 1);
  String password = parts[5].substring(parts[5].indexOf('=') + 1);
  String genero = parts[6].substring(parts[6].indexOf('=') + 1);
  String direccion = parts[7].substring(parts[7].indexOf('=') + 1);
  String celular = parts[8].substring(parts[8].indexOf('=') + 1);
  String documento =
      parts[9].substring(parts[9].indexOf('=') + 1, parts[9].length - 1);

  return User(
    id: id,
    nombre: nombre,
    apellido: apellido,
    email: email,
    fechaNacimiento: fechaNacimiento,
    password: password,
    genero: genero,
    direccion: direccion,
    celular: celular,
    documento: documento,
  );
}
