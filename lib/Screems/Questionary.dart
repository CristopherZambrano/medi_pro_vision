import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Screems/Diagnosticos.dart';
import 'package:medi_pro_vision/Screems/Resultado.dart';
import 'package:medi_pro_vision/Widgets/dialogs.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questionary extends StatelessWidget {
  Map<String, Color> customTheme = {
    'primary': const Color(0xFF205ACF),
    'primaryVariant': const Color(0xFF2DA537),
    'secondary': const Color(0xFF000000),
    'scaffoldBackgroundColor': const Color(0xFFFFFFFF),
  };

  Questionary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: customTheme['primary'],
        primaryColorDark: customTheme['primaryVariant'],
        scaffoldBackgroundColor: customTheme['scaffoldBackgroundColor'],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromHeight(45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: customTheme['secondary']!),
          ),
        ),
      ),
      home: QuestionnaireScreen(),
    );
  }
}

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  TextEditingController numericText = TextEditingController();
  int currentQuestionIndex = 0;
  int pedigree = 0;
  List<int> answer = [];
  final List<String> questions = [
    'Have you had an increase in thirst lately?', // Yes or No
    'Do you go to the bathroom more frequently?',
    'Have you ever felt tired or fatigued?',
    'Have you lost weight lately?',
    'Have you ever seen blurry?',
    'Do your wounds take time to heal?',
    'Has your appetite increased lately?',
    'Have you had genital infections in the last semester?',
    'Have you felt an inexplicable body itch?',
    'Have you had sudden mood changes?',
    'Have you felt tingling in your extremities?',
    'Have you had cramps lately?',
    'Have you noticed your hair falling out?',
    'Are your parents diabetic?',
    'Do you have siblings with diabetes?',
    'Do you have children with diabetes?'
  ];

  void _nextQuestion(int? resp) async {
    if (currentQuestionIndex >= 13) {
      pedigree = pedigree + (resp ?? 0);
    } else {
      if (resp != null) {
        answer.add(resp);
      }
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("pedigree", pedigree);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Resultado(
                    answer: answer,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Questionnaire'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              showDialogAlertAndRedirection(
                  context, 'Cancelar', 'Se cancelaran todos los cambios',
                  onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Diagnostico()))
                      });
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  questions[currentQuestionIndex],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (currentQuestionIndex < 13)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _nextQuestion(1),
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () => _nextQuestion(0),
                    child: const Text('No'),
                  ),
                ],
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                  controller: numericText,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) =>
                      _nextQuestion(int.tryParse(numericText.text)),
                  decoration: const InputDecoration(
                    labelText: 'Enter value',
                    hintText: 'Numeric value',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
