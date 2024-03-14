import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/register_controller.dart';
import 'package:medi_pro_vision/Screems/log_in.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';

class RegisterUser extends StatelessWidget {
  const RegisterUser({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Register user',
      home: FormRegister(),
    );
  }
}

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _patientKey = GlobalKey<FormState>();
  final _doctorKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cellPhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addresController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController specialityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String message = '';

  Future<bool> regiPatient() async {
    bool register = false;
    final response = await registerPatient(
      nameController.text,
      lastNameController.text,
      emailController.text,
      passwordController.text,
      birthdayController.text,
      cellPhoneController.text,
      genderController.text,
      idNumberController.text,
      addresController.text,
    );
    if (response.code == 1) {
      register = true;
    }
    message = response.message;
    return register;
  }

  Future<bool> regiDoctor() async {
    bool register = false;
    final response = await registerDoctor(
        nameController.text,
        lastNameController.text,
        emailController.text,
        passwordController.text,
        birthdayController.text,
        cellPhoneController.text,
        genderController.text,
        idNumberController.text,
        addresController.text,
        specialityController.text,
        descriptionController.text);
    if (response.code == 1) {
      register = true;
    }
    message = response.message;
    return register;
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
            key: _patientKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: primaryTitle('Patient'),
                  ),
                  formText(
                      'Please, enter your name here',
                      'Name',
                      'Enter you name here',
                      const Icon(Icons.person),
                      nameController),
                  formText(
                      'Please, enter your last name here',
                      'Last name',
                      'Enter your last name, here',
                      const Icon(Icons.person),
                      lastNameController),
                  formNumber(
                      'Please, enter your ID here',
                      'Id card',
                      'Enter your ID, here',
                      const Icon(Icons.card_membership_rounded),
                      idNumberController),
                  formText(
                      'Please, enter your email here',
                      'E-mail',
                      'Enter your email, here',
                      const Icon(Icons.email),
                      emailController),
                  formPassword(
                      'Please, enter your password here',
                      'Password',
                      'Enter your password, here',
                      const Icon(Icons.security),
                      passwordController),
                  formDate(
                      'Please, enter your birthday here',
                      'Birthday',
                      'Enter your birthday here',
                      const Icon(Icons.calendar_today_outlined),
                      birthdayController),
                  formText(
                      'Please, enter gender',
                      'Gender',
                      'Enter your gender, here',
                      const Icon(Icons.male),
                      genderController),
                  formNumber(
                      'Please, enter your number of cellphone',
                      'Cellphone',
                      'Enter your cellphone here',
                      const Icon(Icons.phone),
                      cellPhoneController),
                  formText(
                      'Please, enter your address here',
                      'Address',
                      'Enter your address here',
                      const Icon(Icons.house_outlined),
                      addresController),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(300, 48)),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_patientKey.currentState!.validate()) {
                          regiPatient().then((value) {
                            if (value == true) {
                              showDialogAlertAndRedirection(
                                  context, 'Registered patient', message,
                                  onPressed: () => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LogIn()))
                                      });
                            } else {
                              showDialogAlert(context, 'Mistake', message);
                            }
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Form(
            key: _doctorKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: primaryTitle('Doctor'),
                  ),
                  formText(
                      'Please, enter your name here',
                      'Name',
                      'Enter you name here',
                      const Icon(Icons.person),
                      nameController),
                  formText(
                      'Please, enter your last name here',
                      'Last name',
                      'Enter your last name, here',
                      const Icon(Icons.person),
                      lastNameController),
                  formNumber(
                      'Please, enter your ID here',
                      'Id card',
                      'Enter your ID, here',
                      const Icon(Icons.card_membership_rounded),
                      idNumberController),
                  formText(
                      'Please, enter your email here',
                      'E-mail',
                      'Enter your email, here',
                      const Icon(Icons.email),
                      emailController),
                  formPassword(
                      'Please, enter your password here',
                      'Password',
                      'Enter your password, here',
                      const Icon(Icons.security),
                      passwordController),
                  formDate(
                      'Please, enter your birthday here',
                      'Birthday',
                      'Enter your birthday here',
                      const Icon(Icons.calendar_today_outlined),
                      birthdayController),
                  formText(
                      'Please, enter gender',
                      'Gender',
                      'Enter your gender, here',
                      const Icon(Icons.male),
                      genderController),
                  formNumber(
                      'Please, enter your number of cellphone',
                      'Cellphone',
                      'Enter your cellphone here',
                      const Icon(Icons.phone),
                      cellPhoneController),
                  formText(
                      'Please, enter your address here',
                      'Address',
                      'Enter your address here',
                      const Icon(Icons.house_outlined),
                      addresController),
                  formText(
                      'Please, enter your speciality here',
                      'Speciality',
                      'Enter your speciality here',
                      const Icon(Icons.medical_services),
                      specialityController),
                  formText(
                      'Please, enter description speciality here',
                      'Speciality description',
                      'Enter your description speciality here',
                      const Icon(Icons.medical_information),
                      descriptionController),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(300, 48)),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_doctorKey.currentState!.validate()) {
                          regiDoctor().then((value) {
                            if (value == true) {
                              showDialogAlertAndRedirection(
                                  context, 'Registered doctor', message,
                                  onPressed: () => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LogIn()))
                                      });
                            } else {
                              showDialogAlert(context, 'Mistake', message);
                            }
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
