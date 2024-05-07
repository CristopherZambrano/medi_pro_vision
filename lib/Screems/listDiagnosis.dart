import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/Resultado.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDiagnosis extends StatelessWidget {
  int idPatient;
  ListDiagnosis({super.key, required this.idPatient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "List of diagnoses",
      home: ListDiagnosisScreem(idPatient: idPatient),
    );
  }
}

class ListDiagnosisScreem extends StatefulWidget {
  int idPatient;
  ListDiagnosisScreem({super.key, required this.idPatient});

  @override
  State<ListDiagnosisScreem> createState() => _ListDiagnosisScreemState();
}

class _ListDiagnosisScreemState extends State<ListDiagnosisScreem> {
  late User us;

  @override
  Widget build(BuildContext context) {
    print(chargeHistory().toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of diagnoses"),
        backgroundColor: const Color(0xFF004BA0),
      ),
    );
  }

  Future<String> chargeHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final resp = await listarDiagnosticos(widget.idPatient.toString());
    print(resp.data);
    return resp.data;
  }
}
