import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';

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
  TextEditingController birthdayController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            textInmovible(birthdayController, 'Birthdate'),
            SizedBox(height: 8),
            textInmovible(addressController, 'Address'),
            SizedBox(height: 8),
            textInmovible(idCardController, 'Id Card'),
            SizedBox(height: 8),
            textInmovible(emailController, 'Email'),
            SizedBox(height: 8),
            textInmovible(phoneController, 'Phone'),
          ],
        ),
      ),
    );
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
              textField("Date of Birth", birthdayController),
              SizedBox(height: 10),
              textField("Address", addressController),
              SizedBox(height: 10),
              textField("ID", idCardController),
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
              // Implement save functionality
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
