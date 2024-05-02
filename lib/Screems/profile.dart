import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medi_pro_vision/Controllers/log_in_controller.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/Resultado.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Color> customTheme = {
      'primary': Color(0xFF2AF2F1),
      'primaryVariant': Color(0xFF1FD02D),
      'secondary': Color(0xFF000000),
      'scaffoldBackgroundColor': Color(0xFFFFFFFF),
    };

    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primaryColor: customTheme['primary'],
        primaryColorDark: customTheme['primaryVariant'],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: customTheme['secondary'],
        ),
        scaffoldBackgroundColor: customTheme['scaffoldBackgroundColor'],
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: customTheme['primary']!),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              customTheme['primary']!,
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(double.infinity, 45),
            ),
          ),
        ),
      ),
      home: ProfileScreem(),
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

  @override
  Widget build(BuildContext context) {
    chargeUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User profile'),
        backgroundColor: Color(0xFF2AF2F1),
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
            SizedBox(height: 8),
            textInmovible(lastNameController, 'Last Name'),
            SizedBox(height: 8),
            textInmovible(addressController, 'Address'),
            SizedBox(height: 8),
            textInmovible(emailController, 'Email'),
            SizedBox(height: 8),
            textInmovible(phoneController, 'Phone'),
          ],
        ),
      ),
    );
  }

  void chargeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User us = parseUserString(prefs.getString('User').toString());
    nameController.text = us.nombre.toString();
    lastNameController.text = us.apellido.toString();
    addressController.text = us.direccion.toString();
    emailController.text = us.email.toString();
    phoneController.text = us.celular.toString();
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
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  editProfile().then((value) {
                    if (value == true) {
                      showDialogAlertAndRedirection(
                          context, 'Correct', 'User changed successfully',
                          onPressed: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Profile()))
                              });
                    } else {
                      showDialogAlert(
                          context, 'Incorrect', 'Error modifying user');
                    }
                  });
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
  }

  Future<bool> editProfile() async {
    bool changed = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User us = parseUserString(prefs.getString('User').toString());
    final response = await editUser(us.id.toString(), nameNew.text,
        lastNameNew.text, addressNew.text, emailNew.text, phoneNew.text);
    if (response.code == 1) {
      changed = true;
      User user = parseUserString(jsonEncode(response.data.toString()));
      prefs.setString('User', response.data.toString());
    }
    return changed;
  }
}
