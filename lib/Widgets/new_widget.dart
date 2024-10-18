import 'package:flutter/material.dart';

Widget primaryTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28.0,
      fontFamily: "Roboto",
      fontStyle: FontStyle.italic,
      color: Color(0xFF333333),
    ),
  );
}

Widget verPorcentaje(double porcentaje) {
  return Container(
    width: 300,
    height: 300,
    child: Stack(
      children: [
        Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: porcentaje / 100,
              backgroundColor: Colors.grey.shade200,
              color: Colors.blue,
              strokeWidth: 10,
            ),
          ),
        ),
        Center(
          child: Text(
            '${porcentaje.toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

Widget listTab(String title, String description, String iconTab,
    {required VoidCallback onTap}) {
  return Container(
    height: 110,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 6),
        ]),
    child: GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                primaryTitle(title),
                Text(
                  description,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(iconTab),
                fit: BoxFit.contain,
                height: 60,
                width: 60,
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        onTap();
      },
    ),
  );
}

Widget textInmovible(TextEditingController controller, String fintText) {
  return TextFormField(
    controller: controller,
    enabled: false,
    decoration: InputDecoration(labelText: fintText),
  );
}

Widget textField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
    ),
  );
}

void showDialogAlert(BuildContext context, String title, String description) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      });
}

void showDialogAlertAndRedirection(
    BuildContext context, String title, String description,
    {required VoidCallback onPressed}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      });
}

Widget diagnosisTab(String doctor, String diagnosis, String dateDiagnosis) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diagnosis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    doctor,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateDiagnosis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ))
        ],
      ),
    ),
  );
}
