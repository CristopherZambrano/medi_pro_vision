import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/medicineController.dart';
import 'package:medi_pro_vision/Models/Medicamentos.dart';
import 'package:medi_pro_vision/Screems/home.dart';

class sendTreatment extends StatelessWidget {
  const sendTreatment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tratamiento Diabético',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      home: const TreatmentSelectionPage(),
    );
  }
}

class TreatmentSelectionPage extends StatefulWidget {
  const TreatmentSelectionPage({Key? key}) : super(key: key);

  @override
  _TreatmentSelectionPageState createState() => _TreatmentSelectionPageState();
}

class _TreatmentSelectionPageState extends State<TreatmentSelectionPage> {
  String? _selectedTreatment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a treatment'),
        backgroundColor: const Color(0xFF007BFF),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('Change of diet'),
            leading: Radio<String>(
              value: 'diet',
              groupValue: _selectedTreatment,
              onChanged: (value) {
                setState(() {
                  _selectedTreatment = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Drug intake'),
            leading: Radio<String>(
              value: 'medication',
              groupValue: _selectedTreatment,
              onChanged: (value) {
                setState(() {
                  _selectedTreatment = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Insulin injections'),
            leading: Radio<String>(
              value: 'insulin',
              groupValue: _selectedTreatment,
              onChanged: (value) {
                setState(() {
                  _selectedTreatment = value;
                });
              },
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              _navigateToSelectedTreatment(context);
            },
            backgroundColor: const Color(0xFF03DAC6),
            label: const Text('Continuar'),
            icon: const Icon(Icons.check),
            extendedPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ],
      ),
    );
  }

  void _navigateToSelectedTreatment(BuildContext context) {
    switch (_selectedTreatment) {
      case 'diet':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DietPage()),
        );
        break;
      case 'medication':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MedicationPage()),
        );
        break;
      case 'insulin':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InsulinPage()),
        );
        break;
    }
  }
}

class DietPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cambio de Dieta')),
      body: ListView(
        children: [
          ListTile(title: Text('Azúcares y dulces')),
          ListTile(title: Text('Bebidas azucaradas')),
          ListTile(title: Text('Harinas refinadas')),
          ListTile(title: Text('Fast food')),
          FloatingActionButton.extended(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            backgroundColor: const Color(0xFF03DAC6),
            label: const Text('Registrar tratamiento'),
            icon: const Icon(Icons.add),
            extendedPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          )
        ],
      ),
    );
  }
}

class MedicationPage extends StatefulWidget {
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
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
        selectedMedications.add(
            medicine); // Agregar el medicamento a la lista de seleccionados
      } else {
        selectedMedications
            .remove(medicine); // Remover el medicamento si se deselecciona
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingesta de Fármacos')),
      body: Column(
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
                      child: Text('No se encontraron medicamentos'));
                } else {
                  List<Medicine> medicinas = snapshot.data!;
                  return ListView.builder(
                    itemCount: medicinas.length,
                    itemBuilder: (context, index) {
                      Medicine medicine = medicinas[index];
                      bool isSelected = selectedMedications.contains(medicine);

                      return ListTile(
                        title: Text(medicine.tradeName),
                        subtitle: Text(medicine.genericName),
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
          ),
          Padding(
            padding: const EdgeInsets.all(
                16.0), // Agrega espacio alrededor de los botones
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Asegura que los botones ocupen todo el ancho
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String tradeName = '';
                        String genericName = '';
                        String presentation = 'Tabletas'; // Valor inicial
                        double concentration = 0;

                        return AlertDialog(
                          title: const Text('Agregar Medicamento'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextField(
                                  decoration: const InputDecoration(
                                      labelText: 'Nombre Comercial'),
                                  onChanged: (value) {
                                    tradeName = value;
                                  },
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                      labelText: 'Nombre Genérico'),
                                  onChanged: (value) {
                                    genericName = value;
                                  },
                                ),
                                DropdownButtonFormField<String>(
                                  value: presentation,
                                  decoration: const InputDecoration(
                                      labelText: 'Presentación'),
                                  onChanged: (String? newValue) {
                                    presentation = newValue!;
                                  },
                                  items: ['Tabletas', 'Jarabe', 'Inyección']
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
                                      labelText: 'Concentración (MG)'),
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
                                Navigator.of(context)
                                    .pop(); // Cierra el modal sin guardar
                              },
                              child: const Text('Cancelar'),
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
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Agregar Medicamento'),
                ),
                const SizedBox(height: 10), // Espacio entre los botones
                TextButton(
                  onPressed: () {
                    if (selectedMedications.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Medicamentos seleccionados'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: selectedMedications
                                  .map((medicine) => Text(medicine.tradeName))
                                  .toList(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Ver Selección'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InsulinPage extends StatefulWidget {
  @override
  _InsulinPageState createState() => _InsulinPageState();
}

class _InsulinPageState extends State<InsulinPage> {
  double _insulinDose = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inyecciones de Insulina')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              });
            },
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child:
                Text('Dosis de Insulina: ${_insulinDose.round().toString()}ml'),
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            backgroundColor: const Color(0xFF03DAC6),
            label: const Text('Nuevo Diagnostico'),
            icon: const Icon(Icons.add),
            extendedPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          )
        ],
      ),
    );
  }
}
