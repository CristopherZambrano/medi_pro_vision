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
      theme: ThemeData(
        primaryColor: const Color(0xFF6200EE),
        scaffoldBackgroundColor: const Color(0xFFF0F0F0),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(45),
          ),
        ),
      ),
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
        title: Text('Seleccione su Tratamiento'),
        backgroundColor: const Color(0xFF6200EE),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text('Cambio de Dieta'),
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
            title: Text('Ingesta de Fármacos'),
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
            title: Text('Inyecciones de Insulina'),
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
      body: FutureBuilder<List<Medicine>>(
        future: medications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron medicamentos'));
          } else {
            List<Medicine> medicinas = snapshot.data!;
            return ListView.builder(
              itemCount: medicinas.length,
              itemBuilder: (context, index) {
                Medicine medicine = medicinas[index];
                bool isSelected = selectedMedications
                    .contains(medicine); // Verifica si está seleccionado

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí puedes manejar los medicamentos seleccionados
          if (selectedMedications.isNotEmpty) {
            // Por ejemplo, mostrar un diálogo con los medicamentos seleccionados
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Medicamentos seleccionados'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectedMedications
                        .map((medicine) => Text(medicine.tradeName))
                        .toList(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cerrar'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.check),
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
