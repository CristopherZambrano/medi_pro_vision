import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Models/Medicamentos.dart';
import 'package:medi_pro_vision/Controllers/medicineController.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  late Future<List<Medicine>> medications;

  @override
  void initState() {
    super.initState();
    medications = listMedicine();
  }

  void saveMedicinescreem(Medicine medicine) async {
    await saveMedicine(medicine); // Tu método para guardar en la base de datos
    setState(() {
      medications = listMedicine(); // Recargar la lista de medicamentos
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List medicine',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Medications'),
            backgroundColor: const Color(0xFF007BFF),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<Medicine>>(
                    future: medications,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No medications found'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Medicine medicine = snapshot.data![index];
                            return ListTile(
                              title: Text(medicine.tradeName),
                              subtitle: Text(
                                  '${medicine.genericName} (${medicine.presentation})'),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.75,
                      child: primaryButton(
                        buttonText: "Add medication",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String tradeName = '';
                              String genericName = '';
                              String presentation = 'Tablets';
                              double concentration = 0;

                              return AlertDialog(
                                title: const Text('Add Medication'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                            labelText: 'Trade name'),
                                        onChanged: (value) {
                                          tradeName = value;
                                        },
                                      ),
                                      TextField(
                                        decoration: const InputDecoration(
                                            labelText: 'Generic name'),
                                        onChanged: (value) {
                                          genericName = value;
                                        },
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: presentation,
                                        decoration: const InputDecoration(
                                            labelText: 'Presentation'),
                                        onChanged: (String? newValue) {
                                          presentation = newValue!;
                                        },
                                        items: ['Tablets', 'Syrup', 'Injection']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      TextField(
                                        decoration: const InputDecoration(
                                            labelText: 'Concentration (MG)'),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          concentration =
                                              double.tryParse(value) ?? 0;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  secondaryButton(
                                    buttonText: "Cancel",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  primaryButton(
                                    buttonText: "Save",
                                    onPressed: () {
                                      if (tradeName.isNotEmpty &&
                                          genericName.isNotEmpty &&
                                          concentration > 0) {
                                        Medicine newMedicine = Medicine(
                                          id: 0,
                                          tradeName: tradeName,
                                          genericName: genericName,
                                          presentation:
                                              "$presentation $concentration MG",
                                        );
                                        saveMedicinescreem(newMedicine);
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Please fill all fields')),
                                        );
                                      }
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
