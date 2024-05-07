import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/Questionary.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Screems/listDiagnosis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diagnostico extends StatelessWidget {
  const Diagnostico({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF6200EE),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF03DAC6),
        ),
        scaffoldBackgroundColor: const Color(0xFFF0EAE2),
      ),
      title: 'Diagnostico',
      home: DiagnosticoScreem(),
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
  late User user;

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

  void _search() async {
    final id = _searchController.text;
    final response = await buscarPaciente(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.code == 1) {
      setState(() {
        user = parseUserString(response.data);
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
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
                ElevatedButton(
                  onPressed: _search,
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Search'),
                ),
                const SizedBox(height: 20),
                if (_foundPatient != null) ...[
                  Card(
                    color: const Color(0xFF03DAC6),
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
                  TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questionary()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF03DAC6)),
                          padding: MaterialStateProperty.all<
                                  EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(horizontal: 16.0))),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text(
                            "New Diagnosis",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                  const SizedBox(),
                  TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ListDiagnosis(idPatient: user.id)));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                          padding: MaterialStateProperty.all<
                                  EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(horizontal: 16.0))),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text(
                            "See diagnoses",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
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
