import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Controllers/DiagnosticoController.dart';
import 'package:medi_pro_vision/Models/user1.dart';
import 'package:medi_pro_vision/Screems/home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Tratamientos extends StatelessWidget {
  const Tratamientos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Treatments',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      home: const TreatmentListPage(),
    );
  }
}

class TreatmentListPage extends StatefulWidget {
  const TreatmentListPage({super.key});

  @override
  _TreatmentListPageState createState() => _TreatmentListPageState();
}

class _TreatmentListPageState extends State<TreatmentListPage> {
  Map<String, dynamic>? treatmentData;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchTreatment();
  }

  Future<void> fetchTreatment() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? us = prefs.getString("user");
      if (us != null) {
        Map<String, dynamic> userMap = jsonDecode(us);
        User user = User.fromJson(userMap);
        treatmentsDetails(user.id.toString()).then((value) => {
              if (value.isNotEmpty)
                {
                  setState(
                    () {
                      treatmentData = value;
                      isLoading = false;
                    },
                  )
                }
              else
                {
                  setState(() {
                    hasError = true;
                    isLoading = false;
                  })
                }
            });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatment'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text('Error loading treatment data'))
              : treatmentData == null
                  ? const Center(child: Text('There are no active treatments'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Treatment ID: ${treatmentData!['treatment']['id']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Diagnosis ID: ${treatmentData!['treatment']['diagnosis']}',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start Date: ${treatmentData!['treatment']['startDate']}',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'End Date: ${treatmentData!['treatment']['endDate']}',
                          ),
                          const SizedBox(height: 16),

                          // Mostrar medicinas
                          const Text(
                            'Medicines:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  (treatmentData!['medicines'] as List).length,
                              itemBuilder: (context, index) {
                                final medicine =
                                    treatmentData!['medicines'][index];
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      medicine['medicine']['tradeName'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Generic Name: ${medicine['medicine']['genericName']}'),
                                        Text(
                                            'Presentation: ${medicine['medicine']['presentation']}'),
                                        Text('Dose: ${medicine['dose']}'),
                                        Text(
                                            'Frequency: ${medicine['frequency']}'),
                                        Text(
                                            'Start Date: ${medicine['startDate']}'),
                                        Text(
                                            'End Date: ${medicine['endDate']}'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
