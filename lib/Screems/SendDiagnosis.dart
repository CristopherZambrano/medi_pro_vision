import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/medicineController.dart';
import 'package:medi_pro_vision/Models/Medicamentos.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';

class SendTreatment extends StatelessWidget {
  final int treatmentId; // Recibe el ID del tratamiento

  const SendTreatment({Key? key, required this.treatmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetic Treatment',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      home: TreatmentSelectionPage(treatmentId: treatmentId),
    );
  }
}

class TreatmentSelectionPage extends StatefulWidget {
  final int treatmentId; // Usado para mandar a la base de datos

  const TreatmentSelectionPage({Key? key, required this.treatmentId})
      : super(key: key);

  @override
  _TreatmentSelectionPageState createState() => _TreatmentSelectionPageState();
}

class _TreatmentSelectionPageState extends State<TreatmentSelectionPage> {
  bool _showDietDetails = false;
  bool _showMedicationDetails = false;
  bool _showInsulinDetails = false;

  final Map<String, dynamic> treatmentDetails = {
    "diet": [
      "Sugars and sweets",
      "Sugary drinks",
      "Refined flours",
      "Fast food"
    ],
    "medication": [], // Aquí se almacenarán los medicamentos seleccionados
    "insulinDose": 0.0, // Dosis de insulina
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Treatments'),
        backgroundColor: const Color(0xFF007BFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Dietary Changes'),
              trailing: IconButton(
                icon: Icon(
                    _showDietDetails ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _showDietDetails = !_showDietDetails;
                  });
                },
              ),
            ),
            if (_showDietDetails)
              DietPageContent(treatmentDetails: treatmentDetails),
            ListTile(
              title: const Text('Medication Intake'),
              trailing: IconButton(
                icon: Icon(_showMedicationDetails
                    ? Icons.expand_less
                    : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _showMedicationDetails = !_showMedicationDetails;
                  });
                },
              ),
            ),
            if (_showMedicationDetails)
              MedicationPageContent(treatmentDetails: treatmentDetails),
            ListTile(
              title: const Text('Insulin Injections'),
              trailing: IconButton(
                icon: Icon(_showInsulinDetails
                    ? Icons.expand_less
                    : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _showInsulinDetails = !_showInsulinDetails;
                  });
                },
              ),
            ),
            if (_showInsulinDetails)
              InsulinPageContent(treatmentDetails: treatmentDetails),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await saveTreatment(widget.treatmentId, treatmentDetails);
        },
        backgroundColor: const Color(0xFF03DAC6),
        label: const Text('Save Treatment'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}

class DietPageContent extends StatelessWidget {
  final Map<String, dynamic> treatmentDetails;

  const DietPageContent({Key? key, required this.treatmentDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: treatmentDetails["diet"]
          .map<Widget>((item) => ListTile(title: Text(item)))
          .toList(),
    );
  }
}

class MedicationPageContent extends StatefulWidget {
  final Map<String, dynamic> treatmentDetails;

  const MedicationPageContent({Key? key, required this.treatmentDetails})
      : super(key: key);

  @override
  _MedicationPageContentState createState() => _MedicationPageContentState();
}

class _MedicationPageContentState extends State<MedicationPageContent> {
  late Future<List<Medicine>> medications;
  List<Medicine> selectedMedications = [];

  @override
  void initState() {
    super.initState();
    medications = listMedicine();
  }

  void toggleSelection(Medicine medicine, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedMedications.add(medicine);
      } else {
        selectedMedications.remove(medicine);
      }
      widget.treatmentDetails["medication"] = selectedMedications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FutureBuilder<List<Medicine>>(
        future: medications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No medications found'));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Medicine medicine = snapshot.data![index];
                bool isSelected = selectedMedications.contains(medicine);
                return ListTile(
                  title: Text(medicine.tradeName),
                  subtitle: Text(medicine.genericName + medicine.presentation),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (bool? value) {
                      toggleSelection(medicine, value ?? false);
                    },
                  ),
                );
              },
            );
          }
        },
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
                      builder: (BuildContext contex) {
                        String tradeName = '';
                        String genericName = '';
                        String presentation = 'Tablets'; // Valor inicial
                        double concentration = 0;

                        return AlertDialog(
                          title: const Text('Add Medication'),
                          content: SingleChildScrollView(
                            child: Column(
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
                                    concentration = double.tryParse(value) ?? 0;
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (tradeName.isNotEmpty &&
                                    genericName.isNotEmpty &&
                                    concentration > 0) {
                                  Medicine med = Medicine(
                                      id: 0,
                                      tradeName: tradeName,
                                      genericName: genericName,
                                      presentation:
                                          "$presentation${concentration}MG");
                                  saveMedicine(med);
                                  MaterialPageRoute(
                                      builder: (context) => const SendTreatment(
                                            treatmentId: 1,
                                          ));
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      });
                }),
          ))
    ]);
  }
}

class InsulinPageContent extends StatefulWidget {
  final Map<String, dynamic> treatmentDetails;

  const InsulinPageContent({Key? key, required this.treatmentDetails})
      : super(key: key);

  @override
  _InsulinPageContentState createState() => _InsulinPageContentState();
}

class _InsulinPageContentState extends State<InsulinPageContent> {
  double _insulinDose = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _insulinDose,
          min: 0,
          max: 100,
          divisions: 20,
          label: _insulinDose.round().toString(),
          onChanged: (double value) {
            setState(() {
              _insulinDose = value;
              widget.treatmentDetails["insulinDose"] = _insulinDose;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Insulin Dose: ${_insulinDose.round().toString()} ml'),
        ),
      ],
    );
  }
}

// Función para guardar el tratamiento en la base de datos
Future<void> saveTreatment(
    int treatmentId, Map<String, dynamic> treatmentDetails) async {
  print(treatmentId);
  print(treatmentDetails);
}
