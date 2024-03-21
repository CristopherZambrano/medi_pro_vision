import 'package:flutter/material.dart';

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
  final List<String> medications = ['Metformina', 'Sulfonylureas', 'Insulina'];
  final Map<String, bool> selectedMedications = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ingesta de Fármacos')),
      body: ListView(
        children: medications
            .map((medication) => CheckboxListTile(
                  title: Text(medication),
                  value: selectedMedications[medication] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedMedications[medication] = value!;
                    });
                  },
                ))
            .toList(),
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
        ],
      ),
    );
  }
}
