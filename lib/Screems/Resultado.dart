import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/Diagnosis.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/SendDiagnosis.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Widgets/dialogs.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Resultado extends StatelessWidget {
  List<int> answer = [];
  Resultado({super.key, required this.answer});

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
      home: DiabetesRiskScreen(
        customTheme: customTheme,
        answer: answer,
      ),
    );
  }
}

//Statefull

class DiabetesRiskScreen extends StatefulWidget {
  final Map<String, Color> customTheme;
  List<int> answer = [];

  DiabetesRiskScreen({required this.customTheme, required this.answer});

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

  @override
  void initState() {
    super.initState();
    prom = (calcularPromedio(widget.answer) * 100);
    userCharge();
  }

  double calcularPromedio(List<int> lista) {
    if (lista.isEmpty) {
      return 0; // Devuelve 0 si la lista está vacía para evitar una división por cero
    }
    int suma = 0;
    for (int numero in lista) {
      suma += numero;
    }
    double promedio = suma / lista.length;
    return promedio;
  }

  Future<int> sendDiagnosis(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = parseUserString(prefs.getString("User") ?? "");
    final response =
        await guardarDiagnostico(us.id, "Diabetico", user.id.toString());
    print(response.message);
    return response.code;
  }

  Future<void> userCharge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await buscarPaciente(prefs.getString('Patient').toString());
    us = parseUserString(response.data);
    setState(() {
      name = '${us.nombre} ${us.apellido}';
      edad = calcularEdad(us.fechaNacimiento);
      pedigree = 0.075 * edad + 0.212 * (prefs.getInt("pedigree") ?? 0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Risk Assessment'),
          backgroundColor: const Color(0xFF004BA0),
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
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
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
                            },
                            child: const Text('Positive diabetic'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            },
                            style: ElevatedButton.styleFrom(),
                            child: const Text('Not diabetic'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
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
