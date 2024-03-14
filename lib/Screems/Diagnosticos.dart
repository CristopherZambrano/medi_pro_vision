import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';

class diagnostico extends StatelessWidget {
  const diagnostico({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Diagnostico',
      home: DiagnosticoScreem(),
    );
  }
}

class DiagnosticoScreem extends StatefulWidget {
  const DiagnosticoScreem({super.key});

  @override
  State<DiagnosticoScreem> createState() => _DiagnosticoScreemState();
}

class _DiagnosticoScreemState extends State<DiagnosticoScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: primaryTitle('Diagnosticos'),
      ),
    );
  }
}
