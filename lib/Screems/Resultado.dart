import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/Diagnosis.dart';
import 'package:medi_pro_vision/Models/user.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/SendDiagnosis.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';
import 'package:medi_pro_vision/Widgets/dialogs.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Resultado extends StatelessWidget {
  List<int> answer = [];
  Resultado({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Risk Assessment',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      home: DiabetesRiskScreen(
        answer: answer,
      ),
    );
  }
}

//Statefull

class DiabetesRiskScreen extends StatefulWidget {
  List<int> answer = [];
  DiabetesRiskScreen({required this.answer});
  _DiabetesRiskScreemState createState() => _DiabetesRiskScreemState();
}

class _DiabetesRiskScreemState extends State<DiabetesRiskScreen> {
  late String name = '';
  late int edad = 0;
  late double pedigree = 0;
  late User us;
  late Diagnosis diagno;
  late double prom = 0;
  bool isloading = true;
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

  @override
  void initState() {
    super.initState();
    userCharge();
    prom = calcularProbabilidadDiabetes(widget.answer, pedigree);
  }

  Future<int> sendDiagnosis(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataUser = prefs.getString('user');
    if (dataUser != null) {
      Map<String, dynamic> userMap = jsonDecode(dataUser);
      user = User.fromJson(userMap);
    }
    /*final response =
        await guardarDiagnostico(us.id, "Diabetico", user.id.toString());
    return response;*/
    return 2;
  }

  Future<void> userCharge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await buscarPaciente(prefs.getString('Patient').toString());
    us = user.parseUserString(response.data);
    setState(() {
      name = '${us.nombre} ${us.apellido}';
      edad = calcularEdad(us.fechaNacimiento);
      pedigree = 0.075 * edad + 0.212 * (prefs.getDouble("pedigree") ?? 0);
      isloading = false;
    });
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

  double calcularProbabilidadDiabetes(List<int> answer, double pedigree) {
    double puntajeTotal = 0.0;
    for (int i = 0; i < answer.length; i++) {
      switch (i) {
        case 0: // Frecuencia urinaria
          puntajeTotal += answer[i] == 1 ? 5 : 0;
          break;
        case 1: // Aumento de la sed
          puntajeTotal += answer[i] == 1 ? 5 : 0;
          break;
        case 2: // Cansancio o fatiga
          puntajeTotal += answer[i] == 1 ? 5 : 0;
          break;
        case 3: // Pérdida de peso sin razón aparente
          puntajeTotal += answer[i] == 1 ? 7 : 0;
          break;
        case 4: // Visión borrosa
          puntajeTotal += answer[i] == 1 ? 4 : 0;
          break;
        case 5: // Tiempo de cicatrización
          puntajeTotal += answer[i] > 0 ? 6 : 0;
          break;
        case 6: // Apetito
          puntajeTotal += answer[i] > 0 ? 5 : 0;
          break;
        case 7: // Infecciones genitales
          puntajeTotal += answer[i] == 1 ? 5 : 0;
          break;
        case 8: // Picazón sin explicación
          puntajeTotal += answer[i] == 1 ? 5 : 0;
          break;
        case 9: // Cambios de humor repentinos
          puntajeTotal += answer[i] == 1 ? 4 : 0;
          break;
        case 10: // Hormigueo en manos o pies
          puntajeTotal += answer[i] == 1 ? 5 : 0;
          break;
        case 11: // Calambres
          puntajeTotal += answer[i] == 1 ? 3 : 0;
          break;
        case 12: // Pérdida de cabello
          puntajeTotal += answer[i] == 1 ? 4 : 0;
          break;
        case 13: // Antecedentes familiares de diabetes (padres)
          puntajeTotal += answer[i] == 1 ? 7 : (answer[i] == 2 ? 10 : 0);
          break;
        case 14: // Número de hermanos con diabetes
          puntajeTotal += answer[i] *
              3; // Incrementa puntaje basado en cantidad de hermanos
          break;
        case 15: // Número de hijos con diabetes
          puntajeTotal +=
              answer[i] * 3; // Incrementa puntaje basado en cantidad de hijos
          break;
        case 16: // Índice glucémico actual
          puntajeTotal += (answer[i] > 120)
              ? 10
              : 0; // Puntaje alto si es superior al rango normal
          break;
        case 17: // Hemoglobina
          puntajeTotal += (answer[i] < 12)
              ? 5
              : 0; // Puntaje alto si está por debajo del rango normal
          break;
        default:
          break;
      }
    }
    puntajeTotal += pedigree * 10;
    double probabilidad = (puntajeTotal / 100) * 100;
    probabilidad = probabilidad.clamp(0, 100);
    return probabilidad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Risk Assessment'),
          backgroundColor: const Color(0xFF007BFF),
        ),
        body: isloading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Patient Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text('Name: $name'),
                    Text('Age: $edad'),
                    Text('Pedigree: ${pedigree.toStringAsFixed(3)}'),
                    const SizedBox(height: 20),
                    const Text(
                      'Diabetes Risk',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: verPorcentaje(prom),
                    ),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: primaryButton(
                              buttonText: "Positive diabetic",
                              onPressed: () {
                                sendDiagnosis(context).then((value) {
                                  if (value == 1) {
                                    showDialogAlert(context, "Error",
                                        "Error when entering diagnosis");
                                  } else {
                                    showDialogAlertAndRedirection(
                                        context,
                                        "Succesfully",
                                        "Diagnosis entered correctly",
                                        onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const sendTreatment()));
                                    });
                                  }
                                });
                              }),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: secondaryButton(
                            buttonText: "Not diabetic",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
  }
}
