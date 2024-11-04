import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Screems/Diagnosticos.dart';
import 'package:medi_pro_vision/Screems/Resultado.dart';
import 'package:medi_pro_vision/Widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questionary extends StatelessWidget {
  const Questionary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE6F4FA)),
      home: QuestionnaireScreen(),
    );
  }
}

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int currentQuestionIndex = 0;
  int pedigree = 0;
  List<int> answer = [];
  TextEditingController numericTextController = TextEditingController();

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'How many times do you go to the bathroom daily?',
      'options': [
        {'text': 'Less than 3 times', 'value': 0},
        {'text': '3 to 5 times', 'value': 0},
        {'text': 'More than 5 times', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Have you noticed an increase in thirst in recent weeks?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Yes, mildly', 'value': 0},
        {'text': 'Yes, significantly', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'How often have you felt tired or fatigued in the past week?',
      'options': [
        {'text': 'Never', 'value': 0},
        {'text': '1 to 3 times', 'value': 0},
        {'text': 'More than 3 times', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question':
          'Have you lost weight in the last month without changing diet or exercise?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Yes, less than 2 kg', 'value': 0},
        {'text': 'Yes, more than 2 kg', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Have you experienced blurred vision recently?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Yes', 'value': 0},
      ],
      'isNumeric': false,
    },
    {
      'question': 'How long do your wounds take to heal?',
      'options': [
        {'text': 'Less than 1 week', 'value': 0},
        {'text': 'Between 1 and 2 weeks', 'value': 1},
        {'text': 'More than 2 weeks', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'How has your appetite been lately?',
      'options': [
        {'text': 'I have less appetite', 'value': 0},
        {'text': 'Normal', 'value': 0},
        {'text': 'Slightly increased', 'value': 1},
        {'text': 'Greatly increased', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Have you had any genital infections in the last six months?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Yes, once', 'value': 0},
        {'text': 'Yes, multiple times', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Have you experienced unexplained itching on your body?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Occasionally', 'value': 0},
        {'text': 'Frequently', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Have you had sudden mood swings?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Occasionally', 'value': 0},
        {'text': 'Frequently', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Do you feel tingling in your hands or feet?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Occasionally', 'value': 0},
        {'text': 'Frequently', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Have you had cramps lately?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Occasionally', 'value': 0},
        {'text': 'Frequently', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Have you noticed hair loss greater than normal?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'Yes, mildly', 'value': 0},
        {'text': 'Yes, significantly', 'value': 1},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Are either of your parents diabetic?',
      'options': [
        {'text': 'No', 'value': 0},
        {'text': 'One of my parents', 'value': 1},
        {'text': 'Both', 'value': 2},
      ],
      'isNumeric': false,
    },
    {
      'question': 'Do you have siblings diagnosed with diabetes?',
      'isNumeric': true,
    },
    {
      'question': 'Do you have children diagnosed with diabetes?',
      'isNumeric': true,
    },
    {
      'question': 'Enter your current glycemic index:',
      'isNumeric': true,
    },
    {
      'question': 'Enter your blood hemoglobin level (g/dL):',
      'isNumeric': true,
    },
  ];

  void _nextQuestion(int? resp) async {
    if (questions[currentQuestionIndex]['isNumeric'] == true) {
      final numericValue = int.tryParse(numericTextController.text) ?? 0;
      answer.add(numericValue);
      numericTextController.clear();
    } else if (resp != null) {
      answer.add(resp);
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialogAlertAndRedirection(
                context, 'Cancelar', 'Se cancelarán todos los cambios',
                onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Diagnostico()))
                    });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  questions[currentQuestionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            if (questions[currentQuestionIndex]['isNumeric'] == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                  controller: numericTextController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter the value',
                    hintText: 'Example: 1',
                  ),
                  onFieldSubmitted: (_) => _nextQuestion(null),
                ),
              )
            else
              ...List<Widget>.generate(
                questions[currentQuestionIndex]['options'].length,
                (index) {
                  final option =
                      questions[currentQuestionIndex]['options'][index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ElevatedButton(
                      onPressed: () => _nextQuestion(option['value']),
                      child: Text(option['text']),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
