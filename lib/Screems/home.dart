import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/log_in_controller.dart';
import 'package:medi_pro_vision/Models/Global.dart';
import 'package:medi_pro_vision/Screems/Diagnosticos.dart';
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
                printData();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? tipeUser = prefs.getInt("TipeUser");
                print(tipeUser);

                if (tipeUser == 2) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                } else {
                  if (tipeUser == 1) {
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

  void printData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUser = jsonEncode(prefs.getString("User"));
    User user = parseUserString(jsonUser);
    verifyTipeUser(user.id).then((int valor) {
      prefs.setInt("TipeUser", valor);
    });
  }
}

User parseUserString(String userString) {
  List<String> parts = userString.split(', ');
  int id = int.parse(parts[0].substring(parts[0].indexOf('=') + 1));
  String nombre = parts[1].substring(parts[1].indexOf('=') + 1);
  String apellido = parts[2].substring(parts[2].indexOf('=') + 1);
  String email = parts[3].substring(parts[3].indexOf('=') + 1);
  String fechaNacimiento = parts[4].substring(parts[4].indexOf('=') + 1);
  String password = parts[5].substring(parts[5].indexOf('=') + 1);
  String genero = parts[6].substring(parts[6].indexOf('=') + 1);
  String direccion = parts[7].substring(parts[7].indexOf('=') + 1);
  String celular = parts[8].substring(parts[8].indexOf('=') + 1);
  String documento =
      parts[9].substring(parts[9].indexOf('=') + 1, parts[9].length - 1);

  return User(
    id: id,
    nombre: nombre,
    apellido: apellido,
    email: email,
    fechaNacimiento: fechaNacimiento,
    password: password,
    genero: genero,
    direccion: direccion,
    celular: celular,
    documento: documento,
  );
}
