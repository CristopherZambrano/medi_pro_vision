import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/Diagnosticos.dart';
import 'package:medi_pro_vision/Screems/Resultado.dart';
import 'package:medi_pro_vision/Screems/listDiagnosis.dart';
import 'package:medi_pro_vision/Screems/profile.dart';
import 'package:medi_pro_vision/Screems/tratamientos.dart';
import 'package:medi_pro_vision/Widgets/Cards.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:medi_pro_vision/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: const HomeScreem(),
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
    );
  }
}

class HomeScreem extends StatefulWidget {
  const HomeScreem({super.key});

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  User? currentUser;
  bool _isUserLoaded = false;

  Future<void> chargeUser() async {
    User user = User(
      id: 0,
      nombre: '',
      apellido: '',
      email: '',
      fechaNacimiento: '',
      password: '',
      genero: '',
      direccion: '',
      celular: '',
      documento: '',
    );

    currentUser = await user.loadSession();
    setState(() {}); // Actualiza la interfaz cuando carga el usuario
  }

  @override
  Widget build(BuildContext context) {
    if (!_isUserLoaded) {
      _isUserLoaded = true;
      chargeUser(); // Ejecuta el método solo la primera vez
    }
    return const MaterialApp(
      title: 'MediProVision',
      home: HomePage(),
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
                if (tipeUser == 1) {
                  User user =
                      parseUserString(jsonEncode(prefs.getString('User')));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListDiagnosis(idPatient: user.id)));
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
                  MaterialPageRoute(builder: (context) => Tratamientos()));
            }),
            listTab('Profile', 'Manage your personal and medical information.',
                'assets/perfil.png', onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            }),
            listTab('Log out', 'Sign out of the account', 'assets/calendar.png',
                onTap: () {
              User user = User(
                id: 0,
                nombre: '',
                apellido: '',
                email: '',
                fechaNacimiento: '',
                password: '',
                genero: '',
                direccion: '',
                celular: '',
                documento: '',
              );
              user.clearSession();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            }),
          ],
        ),
      ),
    );
  }
}
