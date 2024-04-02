import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Screems/home.dart';

class Tratamientos extends StatelessWidget {
  Tratamientos({super.key});
  Map<String, Color> customTheme = const {
    'primary': Color(0xFF6200EE),
    'primaryVariant': Color(0xFF3700B3),
    'secondary': Color(0xFF03DAC6),
    'scaffoldBackgroundColor': Color(0xFFE6E6E6),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tratamientos',
      theme: ThemeData(
        primaryColor: customTheme['primary'],
        primaryColorLight: customTheme['primaryVariant'],
        secondaryHeaderColor: customTheme['secondary'],
        scaffoldBackgroundColor: customTheme['scaffoldBackgroundColor'],
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: customTheme['secondary']!),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minimumSize: Size(double.infinity, 45), //width and height
          ),
        ),
      ),
      home: TreatmentListPage(),
    );
  }
}

class TreatmentListPage extends StatefulWidget {
  @override
  _TreatmentListPageState createState() => _TreatmentListPageState();
}

class _TreatmentListPageState extends State<TreatmentListPage> {
  final List<String> _treatments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de Tratamientos'),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          )),
      body: _treatments.isEmpty
          ? Center(
              child: Text('No hay tratamientos ingresados.'),
            )
          : ListView.builder(
              itemCount: _treatments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_treatments[index]),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () =>
                        setState(() => _treatments.removeAt(index)),
                  ),
                );
              },
            ),
    );
  }
}
