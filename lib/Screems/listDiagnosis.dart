import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/listDiagnosis.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/Resultado.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  late List<dynamic> jsonList = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    chargeHistory();
    return Scaffold(
        appBar: AppBar(
          title: const Text("List of diagnoses"),
          backgroundColor: const Color(0xFF004BA0),
        ),
        body: FutureBuilder(
          future: chargeHistory(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: jsonList.length,
                itemBuilder: (context, index) {
                  return diagnosisTab(
                    jsonList[index]['doctor'].toString(),
                    jsonList[index]['diagnostico'],
                    jsonList[index]['fecha'],
                  );
                },
              );
            }
          }),
        ));
  }

  Future<void> chargeHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final resp = await listarDiagnosticos(widget.idPatient.toString());
    try {
      jsonList = json.decode(resp);
    } catch (excep) {
      print(excep.toString());
    }
  }
}
