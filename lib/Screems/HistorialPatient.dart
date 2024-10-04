import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/Diagnosis.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Historial del Paciente',
      theme: ThemeData(
        primaryColor: const Color(0xFF6200EE),
        primaryColorDark: const Color(0xFF3700B3),
        scaffoldBackgroundColor: const Color(0xFFF0F0F0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF6200EE)),
            minimumSize:
                MaterialStateProperty.all(const Size(double.infinity, 45)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF6200EE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF6200EE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF3700B3)),
          ),
        ),
      ),
      home: PatientHistoryPage(),
    );
  }
}

class PatientHistoryPage extends StatefulWidget {
  @override
  _PatientHistoryPageState createState() => _PatientHistoryPageState();
}

class _PatientHistoryPageState extends State<PatientHistoryPage> {
  List<Diagnosis> diagnosisList = [];
  List<dynamic> jsonData = [];
  String name = "";

  @override
  void initState() {
    super.initState();
    _loadPatientDiagnosis();
  }

  Future<void> _loadPatientDiagnosis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await listarDiagnosticos(prefs.getInt("idUser").toString());
    /* if (response.code == 2) {
      try {
        String json = remplazar(response.data.toString());
        json = json
            .replaceAll('{', '{"')
            .replaceAll('=', '":"')
            .replaceAll(', ', '","')
            .replaceAll('}', '"}');
        String correctedJsonString = json.replaceAll('"}","{"', '"},{"');
        print(correctedJsonString);
        jsonData = jsonDecode(correctedJsonString);
        print(jsonData);
        //List<String> jsonObjects = correctedJsonString.split(',');

        setState(() {
          /* for (String jsonObject in jsonObjects) {
            Map<String, dynamic> jsonMap = jsonDecode(jsonObject);
            diagnosisList.add(Diagnosis.fromJson(jsonMap));
          } */

          /* print(json);
          jsonData = jsonDecode(json);
          print(jsonData); */
          diagnosisList = jsonData.map((dynamic item) {
            return Diagnosis.fromJson(Map<String, dynamic>.from(item));
          }).toList();
        });
      } catch (e) {
        print('Error al analizar los diagnósticos: $e');
      }
    } */
  }

  Future<String> ChargeName(String id) async {
    final response = await DoctorName(id);
    if (response.code == 2) {
      print(response.data);
      return response.data;
    } else {
      return "No disponible";
    }
  }

  String remplazar(String data) {
    data = data.replaceAll('Diagnosis', '');

// Reemplazar '(' por '{'
    data = data.replaceAll('(', '{');

// Reemplazar ')' por '}'
    data = data.replaceAll(')', '}');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Historial del Paciente'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          )),
      body: ListView.builder(
        itemCount: diagnosisList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(diagnosisList[index].idDoctor.toString()),
              subtitle: Text(diagnosisList[index].dateDiagnosis.toString()),
              trailing: Text(diagnosisList[index].diagnosis.toString()),
            ),
          );
        },
      ),
    );
  }
}
