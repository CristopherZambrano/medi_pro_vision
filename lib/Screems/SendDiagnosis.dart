import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Controllers/medicineController.dart';
import 'package:medi_pro_vision/Models/Medicamentos.dart';
import 'package:medi_pro_vision/Models/detailTreatment.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Widgets/dialogs.dart';
import 'package:medi_pro_vision/Widgets/textBox.dart';

class SendTreatment extends StatelessWidget {
  final int treatmentId;

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
  final int treatmentId;

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
              MedicationPageContent(
                treatmentDetails: treatmentDetails,
                iddiagnostico: widget.treatmentId,
              ),
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
          await saveTreatment(widget.treatmentId, treatmentDetails, context);
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
  final int iddiagnostico;
  final Map<String, dynamic> treatmentDetails;

  const MedicationPageContent(
      {Key? key, required this.treatmentDetails, required this.iddiagnostico})
      : super(key: key);

  @override
  _MedicationPageContentState createState() => _MedicationPageContentState();
}

class _MedicationPageContentState extends State<MedicationPageContent> {
  late Future<List<Medicine>> medications;
  List<SelectedMedication> selectedMedications = [];

  @override
  void initState() {
    super.initState();
    medications = listMedicine();
  }

  void addMedicationDetails(Medicine medicine) async {
    String dosis = medicine.presentation;
    String? frecuencia;
    DateTime? fechaFin;
    TextEditingController frequency = TextEditingController();
    TextEditingController endDate = TextEditingController();
    List<String> medicationFrequency = [
      "Once a day",
      "Twice a day",
      "Three times a day",
      "Four times a day",
      "Every 4 hours",
      "Every 2 hours",
      "Once a week",
      "Every two weeks",
      "Once a month"
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Details for ${medicine.tradeName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              selectFormText(
                messageError: "Select any options",
                labelText: "Frequency",
                control: frequency,
                options: medicationFrequency,
              ),
              formDate(
                "Select any date",
                "Date end dosis",
                "End date",
                const Icon(Icons.calendar_month),
                endDate,
                context,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                frecuencia = frequency.text.toString();
                fechaFin = DateTime.tryParse(endDate.text);
                if (frecuencia != null && fechaFin != null) {
                  setState(() {
                    selectedMedications
                        .removeWhere((med) => med.idMedicina == medicine.id);
                    selectedMedications.add(SelectedMedication(
                      idMedicina: medicine.id,
                      dosis: dosis,
                      frecuencia: frecuencia!,
                      fechaInicio: DateTime.now(),
                      fechaFin: fechaFin!,
                    ));

                    // Actualizar el JSON en treatmentDetails
                    widget.treatmentDetails["medication"] =
                        selectedMedications.map((med) => med.toJson()).toList();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
                bool isSelected = selectedMedications
                    .any((med) => med.idMedicina == medicine.id);
                return ListTile(
                  title: Text(medicine.tradeName),
                  subtitle: Text(medicine.genericName + medicine.presentation),
                  trailing: IconButton(
                    icon: Icon(isSelected
                        ? Icons.check_box
                        : Icons.check_box_outline_blank),
                    onPressed: () => addMedicationDetails(medicine),
                  ),
                );
              },
            );
          }
        },
      ),
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

Future<dynamic> saveTreatment(int treatmentId,
    Map<String, dynamic> treatmentDetails, BuildContext context) async {
  guardarTratamiento(treatmentId, treatmentDetails);
  showDialogAlertAndRedirection(
      context, "Treatment registered", "Treatment registered succesfully",
      onPressed: () {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  });
}
