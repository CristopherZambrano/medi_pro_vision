import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _searchController = TextEditingController();
  Patient? _foundPatient;

  final Map<String, Patient> _patientsDatabase = {
    "12345678": Patient(
        id: "12345678",
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        age: 30),
    "87654321": Patient(
        id: "87654321",
        firstName: "Jane",
        lastName: "Doe",
        email: "jane.doe@example.com",
        age: 28),
    // Add more patients here
  };

  void _search() {
    final id = _searchController.text;
    if (_patientsDatabase.containsKey(id)) {
      setState(() {
        _foundPatient = _patientsDatabase[id];
      });
    } else {
      setState(() {
        _foundPatient = null;
      });
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
      ),
      body: Padding(
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
                          'Name: ${_foundPatient?.firstName ?? ""} ${_foundPatient?.lastName ?? ""}'),
                      _infoText("Email: ${_foundPatient?.email ?? ""}"),
                      _infoText("Age: ${_foundPatient?.age.toString() ?? ""}"),
                    ],
                  ),
                ),
              )
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Aquí iría la lógica para generar nuevo diagnóstico
          },
          label: const Text('Nuevo Diagnóstico'),
          icon: const Icon(Icons.add),
          backgroundColor: const Color(0xFF03DAC6)),
    );
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

class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int age;

  Patient(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.age});
}
