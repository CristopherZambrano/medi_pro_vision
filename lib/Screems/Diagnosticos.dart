import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/Questionary.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Screems/listDiagnosis.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diagnostico extends StatelessWidget {
  const Diagnostico({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      title: 'Diagnostico',
      home: const DiagnosticoScreem(),
    );
  }
}

class DiagnosticoScreem extends StatefulWidget {
  const DiagnosticoScreem({super.key});

  @override
  State<DiagnosticoScreem> createState() => _DiagnosticoScreemState();
}

class _DiagnosticoScreemState extends State<DiagnosticoScreem> {
  bool isPatient = false;
  final TextEditingController _searchController = TextEditingController();
  User? _foundPatient;
  User user = User(
    id: 0,
    nombre: '',
    apellido: '',
    email: '',
    fechaNacimiento: '',
    password: '',
    genero: '',
    direccion: '',
    celular: '',
    documento: '',
  );

  void _search() async {
    final id = _searchController.text;
    final response = await buscarPaciente(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.code == 1) {
      setState(() {
        print(response.data.toString());
        user = user.parseUserString(response.data.toString());
        prefs.setString("Patient", id);
        isPatient = true;
        _foundPatient = user;
      });
    } else {
      setState(() {
        _foundPatient = null;
      });
      isPatient = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Patient Not Found"),
            content: Text("No patient was found with the ID $id."),
            actions: <Widget>[
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Patient Search"),
            backgroundColor: const Color(0xFF007BFF),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: "Enter Patient ID",
                    suffixIcon: IconButton(
                      onPressed: _searchController.clear,
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 0.45,
                  child:
                      primaryButton(buttonText: "Search", onPressed: _search),
                ),
                const SizedBox(height: 20),
                if (_foundPatient != null) ...[
                  Card(
                    color: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Color(
                            0xFFD0E4F7), // Borde de la tarjeta (azul claro)
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoText('ID: ${_foundPatient?.id ?? ""}'),
                          _infoText(
                              'Name: ${_foundPatient?.nombre ?? ""} ${_foundPatient?.apellido ?? ""}'),
                          _infoText("Email: ${_foundPatient?.email ?? ""}"),
                          _infoText(
                              "Birthday: ${_foundPatient?.fechaNacimiento ?? ""}"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.65,
                    child: primaryButton(
                        buttonText: "New Diagnosis",
                        icon: Icons.add,
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Questionary()));
                        }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: secondaryButton(
                        buttonText: "See diagnoses",
                        icon: Icons.remove_red_eye,
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ListDiagnosis(idPatient: user.id)));
                        }),
                  ),
                ],
              ],
            ),
          ),
        ));
  }

  Widget _infoText(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      );
}
