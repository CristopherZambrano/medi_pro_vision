import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/register_controller.dart';
import 'package:medi_pro_vision/Screems/log_in.dart';
import 'package:medi_pro_vision/Widgets/textBox.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';
import 'package:medi_pro_vision/Widgets/dialogs.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';

class RegisterUser extends StatelessWidget {
  const RegisterUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      title: 'Register user',
      home: const FormRegister(),
    );
  }
}

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _patientFormKey = GlobalKey<FormState>();
  final _doctorFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cellPhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();

  TextEditingController specialityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String message = '';

  Future<bool> register(bool isDoctor) async {
    bool registerSuccess = false;
    final response = isDoctor
        ? await registerDoctor(
            nameController.text,
            lastNameController.text,
            emailController.text,
            passwordController.text,
            birthdayController.text,
            cellPhoneController.text,
            genderController.text,
            idNumberController.text,
            addressController.text,
            specialityController.text,
            descriptionController.text)
        : await registerPatient(
            nameController.text,
            lastNameController.text,
            emailController.text,
            passwordController.text,
            birthdayController.text,
            cellPhoneController.text,
            genderController.text,
            idNumberController.text,
            addressController.text);

    if (response.code == 1) {
      registerSuccess = true;
    }
    message = response.message;
    return registerSuccess;
  }

  Widget buildFormFields({bool isDoctor = false}) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          formText(
              messageError: 'Please, enter your name here',
              labelText: 'Name',
              control: nameController,
              icono: const Icon(Icons.person),
              hintText: 'Enter your name here'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          formText(
              messageError: 'Please, enter your last name here',
              labelText: 'Last name',
              hintText: 'Enter your last name, here',
              icono: const Icon(Icons.person),
              control: lastNameController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          formNumber(
              'Please, enter your ID here',
              'ID card',
              'Enter your ID here',
              const Icon(Icons.card_membership_rounded),
              idNumberController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          formText(
              messageError: 'Please, enter your email here',
              labelText: 'E-mail',
              hintText: 'Enter your email, here',
              icono: const Icon(Icons.email),
              control: emailController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          formPassword(
              'Please, enter your password here',
              'Password',
              'Enter your password, here',
              const Icon(Icons.security),
              passwordController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          formDate(
              'Please, enter your birthday here',
              'Birthday',
              'Enter your birthday here',
              const Icon(Icons.calendar_today_outlined),
              birthdayController,
              context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          selectFormText(
              messageError: 'Please, select one gender',
              labelText: 'Gender',
              control: genderController,
              options: ['Male', 'Female'],
              icono: const Icon(Icons.male)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          formNumber(
              'Please, enter your number of cellphone',
              'Cellphone',
              'Enter your cellphone here',
              const Icon(Icons.phone),
              cellPhoneController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          formText(
              messageError: 'Please, enter your address here',
              labelText: 'Address',
              hintText: 'Enter your address here',
              icono: const Icon(Icons.house_outlined),
              control: addressController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          if (isDoctor)
            formText(
                messageError: 'Please, enter your speciality here',
                labelText: 'Speciality',
                hintText: 'Enter your speciality here',
                icono: const Icon(Icons.medical_services),
                control: specialityController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          if (isDoctor)
            formText(
                messageError: 'Please, enter your speciality description here',
                labelText: 'Speciality description',
                hintText: 'Enter your description here',
                icono: const Icon(Icons.medical_information),
                control: descriptionController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.sick_outlined),
                text: 'Patient',
              ),
              Tab(
                icon: Icon(Icons.medication_outlined),
                text: 'Doctor',
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          Form(
            key: _patientFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: primaryTitle('Patient')),
                  buildFormFields(isDoctor: false),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: FractionallySizedBox(
                        widthFactor: 0.75,
                        child: primaryButton(
                          buttonText: "Register",
                          onPressed: () {
                            if (_patientFormKey.currentState!.validate()) {
                              register(false).then((value) {
                                if (value == true) {
                                  showDialogAlertAndRedirection(
                                      context, 'Registered patient', message,
                                      onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogIn()));
                                  });
                                } else {
                                  showDialogAlert(context, 'Error', message);
                                }
                              });
                            }
                          },
                        ),
                      ))
                ],
              ),
            ),
          ),
          Form(
            key: _doctorFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: primaryTitle('Doctor')),
                  buildFormFields(isDoctor: true),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: FractionallySizedBox(
                        widthFactor: 0.75,
                        child: primaryButton(
                          buttonText: "Register",
                          onPressed: () {
                            if (_doctorFormKey.currentState!.validate()) {
                              register(true).then((value) {
                                if (value == true) {
                                  showDialogAlertAndRedirection(
                                      context, 'Registered doctor', message,
                                      onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogIn()));
                                  });
                                } else {
                                  showDialogAlert(context, 'Error', message);
                                }
                              });
                            }
                          },
                        ),
                      ))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
