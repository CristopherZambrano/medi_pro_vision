import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/log_in_controller.dart';
import 'package:medi_pro_vision/Screems/Diagnosticos.dart';
import 'package:medi_pro_vision/Screems/HistorialPatient.dart';
import 'package:medi_pro_vision/Screems/profile.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Home',
      home: HomeScreem(),
    );
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
            listTab(
              'Diagnosis',
              'Performs a new diagnosis.',
              'assets/diagnostico.png',
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? tipeUser = prefs.getInt("TipeUser");
                print(tipeUser);
                if (tipeUser == 1) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => History()));
                } else {
                  if (tipeUser == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Diagnostico()));
                  }
                }
              },
            ),
            listTab(
                'Treatment',
                'Monitor the progress of your medical treatment.',
                'assets/seguimiento.png', onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            }),
            listTab('Quotes', 'Check your pending appointments.',
                'assets/calendar.png', onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            }),
            listTab('Profile', 'Manage your personal and medical information.',
                'assets/perfil.png', onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            })
          ],
        ),
      ),
    );
  }
}
