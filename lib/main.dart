import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Screems/log_in.dart';
import 'package:medi_pro_vision/Screems/profile.dart';
import 'package:medi_pro_vision/Screems/register_user.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      title: "MediProVision",
      home: const StartPage(),
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
