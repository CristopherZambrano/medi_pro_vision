import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/log_in_controller.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Log In",
      home: LogInScreem(),
    );
  }
}

class LogInScreem extends StatefulWidget {
  const LogInScreem({super.key});

  @override
  State<LogInScreem> createState() => _LogInScreemState();
}

class _LogInScreemState extends State<LogInScreem> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = '';
  late bool _isButtonDisabled;
  String _textButton = 'Get into';

  @override
  void initState() {
    _isButtonDisabled = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/log.png')),
            Center(
              child: primaryTitle('Log in'),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Center(
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Enter your email',
                    icon: Icon(Icons.person),
                    hintText: 'Enter your email here'),
                keyboardType: TextInputType.emailAddress,
                controller: userController,
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Center(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter your password',
                  icon: Icon(Icons.lock),
                  hintText: 'Enter your password here',
                ),
                obscureText: true,
                controller: passwordController,
              ),
            ),
            const Padding(padding: EdgeInsets.all(9)),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(300, 48)),
                onPressed: _isButtonDisabled
                    ? () => {
                          setState(() {
                            _isButtonDisabled = false;
                            _textButton = 'Please wait';
                          }),
                          initSession(context),
                          setState(() {
                            _isButtonDisabled = true;
                            _textButton = 'Get into';
                          }),
                        }
                    : null,
                child: Text(
                  _textButton,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
    );
  }

  void initSession(BuildContext context) {
    checkUser().then((checkUserResult) {
      if (checkUserResult == true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        showDialogAlert(context, 'Wrong', message);
      }
    }).catchError((error) {
      showDialogAlert(context, 'Wrong', error.toString());
    });
  }

  Future<bool> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAuth = false;
    final response =
        await checkCredencials(userController.text, passwordController.text);
    if (response.code == 1) {
      isAuth = true;
      message = response.message;
      User user = parseUserString(jsonEncode(response.data.toString()));
      verifyTipeUser(user.id).then((int valor) {
        prefs.setString('User', response.data.toString());
        prefs.setInt("TipeUser", valor);
      });
    }
    if (response.code == 2) {
      isAuth = false;
    }
    return isAuth;
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
}
