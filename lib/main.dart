import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Screems/log_in.dart';
import 'package:medi_pro_vision/Screems/profile.dart';
import 'package:medi_pro_vision/Screems/register_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "MediProVision",
      home: StartPage(),
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
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(300, 48)),
              child: const Text(
                "Log in",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ))
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(228, 230, 207, 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(300, 48)),
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterUser(),
                    ))
              },
            ),
          ),
        ],
      ),
    );
  }
}
