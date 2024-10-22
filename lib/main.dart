import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Screems/log_in.dart';
import 'package:medi_pro_vision/Screems/profile.dart';
import 'package:medi_pro_vision/Screems/register_user.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? userData = prefs.getString('user');
  runApp(MyApp(user: userData));
}

class MyApp extends StatelessWidget {
  final String? user;
  const MyApp({this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      title: "MediProVision",
      home: user != null ? const Home() : const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/log.png')),
          FractionallySizedBox(
            widthFactor: 0.6,
            child: primaryButton(
                buttonText: "Log In",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogIn(),
                      ));
                }),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          FractionallySizedBox(
            widthFactor: 0.55,
            child: secondaryButton(
                buttonText: "Register",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterUser(),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
