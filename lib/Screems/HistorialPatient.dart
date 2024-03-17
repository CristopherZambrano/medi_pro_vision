import 'package:flutter/material.dart';

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

class PatientHistoryPage extends StatelessWidget {
  final List<PatientDiagnosis> patientDiagnosis = [
    PatientDiagnosis('Dr. Smith', DateTime(2023, 4, 10), 'No issues found.'),
    PatientDiagnosis('Dr. Johnson', DateTime(2023, 3, 20),
        'Prescribed medication for allergies.'),
    PatientDiagnosis(
        'Dr. Williams', DateTime(2023, 2, 15), 'Recommended surgery.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial del Paciente'),
      ),
      body: ListView.builder(
        itemCount: patientDiagnosis.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(patientDiagnosis[index].doctor),
              subtitle: Text(
                  '${patientDiagnosis[index].diagnosisDate.year}-${patientDiagnosis[index].diagnosisDate.month}-${patientDiagnosis[index].diagnosisDate.day}'),
              trailing: Text(patientDiagnosis[index].result),
            ),
          );
        },
      ),
    );
  }
}

class PatientDiagnosis {
  final String doctor;
  final DateTime diagnosisDate;
  final String result;

  PatientDiagnosis(this.doctor, this.diagnosisDate, this.result);
}
