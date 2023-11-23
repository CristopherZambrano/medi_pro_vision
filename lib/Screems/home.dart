import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreem();
  }
}

class HomeScreem extends StatefulWidget {
  const HomeScreem({super.key});

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediProVision',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child: primaryTitle('Home')),
            listTab('Diagnosis', 'Performs a new diagnosis.',
                'assets/diagnostico.png'),
            listTab(
                'Treatment',
                'Monitor the progress of your medical treatment.',
                'assets/seguimiento.png'),
            listTab('Quotes', 'Check your pending appointments.',
                'assets/calendar.png'),
            listTab('Profile', 'Manage your personal and medical information.',
                'assets/perfil.png')
          ],
        ),
      ),
    );
  }
}
