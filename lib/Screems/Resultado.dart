import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  Resultado({super.key});

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
      home: DiabetesRiskScreen(customTheme: customTheme),
    );
  }
}

class DiabetesRiskScreen extends StatelessWidget {
  final Map<String, Color> customTheme;
  DiabetesRiskScreen({required this.customTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk Assessment'),
        backgroundColor: customTheme['primaryVariant'],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Patient Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Name: John Doe'),
            Text('Age: 34'),
            Text('Pedigree: 0.26'),
            SizedBox(height: 20),
            Text(
              'Diabetes Risk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Your estimated risk is 80%'),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Validate Diagnosis'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(),
                    child: Text('Reject'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
