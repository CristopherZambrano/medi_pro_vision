import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/log_in_controller.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';
import 'package:medi_pro_vision/Widgets/dialogs.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:medi_pro_vision/Widgets/textBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      home: const ProfileScreem(),
    );
  }
}

class ProfileScreem extends StatefulWidget {
  const ProfileScreem({super.key});

  @override
  State<ProfileScreem> createState() => _ProfileScreemState();
}

class _ProfileScreemState extends State<ProfileScreem> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameNew = TextEditingController();
  TextEditingController lastNameNew = TextEditingController();
  TextEditingController addressNew = TextEditingController();
  TextEditingController emailNew = TextEditingController();
  TextEditingController phoneNew = TextEditingController();
  TextEditingController passwordOldController = TextEditingController();
  TextEditingController passwordNewController = TextEditingController();
  TextEditingController passwordNewOk = TextEditingController();
  User userTime = User(
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

  @override
  Widget build(BuildContext context) {
    chargeUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User profile'),
        backgroundColor: const Color(0xFF007BFF),
        actions: [
          IconButton(
              onPressed: () async {
                await showEditDialog(context);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            textInmovible(nameController, 'Name'),
            const SizedBox(height: 8),
            textInmovible(lastNameController, 'Last Name'),
            const SizedBox(height: 8),
            textInmovible(addressController, 'Address'),
            const SizedBox(height: 8),
            textInmovible(emailController, 'Email'),
            const SizedBox(height: 8),
            textInmovible(phoneController, 'Phone'),
            const SizedBox(height: 8),
            FractionallySizedBox(
              widthFactor: 0.75,
              child: primaryButton(
                  buttonText: "Change password",
                  onPressed: () async {
                    await showEditPassword(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  void chargeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataUser;
    User? us;
    dataUser = prefs.getString('user');
    if (dataUser != null) {
      Map<String, dynamic> userMap = jsonDecode(dataUser);
      us = User.fromJson(userMap);
    }
    if (us != null) {
      nameController.text = us.nombre.toString();
      lastNameController.text = us.apellido.toString();
      addressController.text = us.direccion.toString();
      emailController.text = us.email.toString();
      phoneController.text = us.celular.toString();
    }
  }

  showEditDialog(BuildContext context) async {
    nameNew.text = nameController.text;
    lastNameNew.text = lastNameController.text;
    addressNew.text = addressController.text;
    emailNew.text = emailController.text;
    phoneNew.text = phoneController.text;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Profile"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textField("Name", nameNew),
                  const SizedBox(height: 10),
                  textField("Last Name", lastNameNew),
                  const SizedBox(height: 10),
                  textField("Address", addressNew),
                  const SizedBox(height: 10),
                  textField("Email", emailNew),
                  const SizedBox(height: 10),
                  textField("Phone", phoneNew),
                  const SizedBox(height: 10),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Column(children: [
                      primaryButton(
                          buttonText: "Save",
                          onPressed: () {
                            editProfile().then((value) {
                              if (value == true) {
                                showDialogAlertAndRedirection(context,
                                    'Correct', 'User changed successfully',
                                    onPressed: () => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Profile()))
                                        });
                              } else {
                                showDialogAlert(context, 'Incorrect',
                                    'Error modifying user');
                              }
                            });
                          }),
                      const SizedBox(height: 10),
                      secondaryButton(
                          buttonText: "Cancel",
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ]),
                  )
                ],
              ),
            ),
          );
        });
  }

  showEditPassword(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Change Password"),
            content: SingleChildScrollView(
                child: Column(
              children: [
                formPassword(
                    "Please enter a valid password",
                    "Old password",
                    "Enter Your password",
                    const Icon(Icons.key_rounded),
                    passwordOldController),
                const SizedBox(height: 10),
                formPassword(
                    "Please enter a valid password",
                    "New Password",
                    "Enter the new password",
                    const Icon(Icons.key_rounded),
                    passwordNewController),
                const SizedBox(height: 10),
                formPassword(
                    "Please enter a valid password",
                    "Validate new password",
                    "Enter the new password",
                    const Icon(Icons.key_rounded),
                    passwordNewOk),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Column(
                    children: [
                      primaryButton(
                        buttonText: "Save",
                        onPressed: () {
                          modifiedPassword().then((value) {
                            if (value == "Succesfully") {
                              showDialogAlertAndRedirection(context, 'Correct',
                                  'Password changed successfully',
                                  onPressed: () => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Profile()))
                                      });
                            } else {
                              showDialogAlert(context, 'Incorrect', value);
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      secondaryButton(
                        buttonText: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
              ],
            )),
          );
        });
  }

  Future<bool> editProfile() async {
    bool changed = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User us = userTime.parseUserString(prefs.getString('user').toString());
    final response = await editUser(us.id.toString(), nameNew.text,
        lastNameNew.text, addressNew.text, emailNew.text, phoneNew.text);
    if (response.code == 1) {
      changed = true;
      us.nombre = nameNew.text;
      us.apellido = lastNameNew.text;
      us.direccion = addressNew.text;
      us.email = emailNew.text;
      us.celular = phoneNew.text;
      prefs.setString('user', us.toString());
    }
    return changed;
  }

  Future<String> modifiedPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User us = userTime.parseUserString(prefs.getString('user').toString());
    if (passwordNewController.text == passwordNewOk) {
      return "Password no valida";
    } else {
      if (passwordNewController.text == passwordOldController) {
        return "New password cannot be the same as the previous one";
      } else {
        if (passwordOldController.text == us.password) {
          final response = await changePassword(
              us.id.toString(), passwordNewController.text);
          return response;
        } else {
          return "Old password does not match";
        }
      }
    }
  }
}
