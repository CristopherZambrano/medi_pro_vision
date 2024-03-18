import 'package:flutter/material.dart';

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
  int currentQuestionIndex = 0;
  final List<String> questions = [
    'Do you like Flutter?', // Yes or No
    'How many hours do you code daily?', // Numeric
    // Add more questions as per your requirements here...
    // Ensure that there are 15 questions as specified
  ];

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Logic when all questions are answered
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire'),
      ),
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
            if (currentQuestionIndex % 2 == 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('No'),
                  ),
                ],
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) => _nextQuestion(),
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
