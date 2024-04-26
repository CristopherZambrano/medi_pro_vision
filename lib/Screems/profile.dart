import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    chargeUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User profile'),
        backgroundColor: Color(0xFF2AF2F1),
        actions: [
          IconButton(
              onPressed: () => showEditDialog(context),
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

  showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Profile"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              textField("Name", nameController),
              SizedBox(height: 10),
              textField("Last Name", lastNameController),
              SizedBox(height: 10),
              textField("Address", addressController),
              SizedBox(height: 10),
              textField("Email", emailController),
              SizedBox(height: 10),
              textField("Phone", phoneController),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
