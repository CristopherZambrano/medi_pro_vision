import 'package:flutter/material.dart';

Widget primaryTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: Color(0xFF333333),
    ),
  );
}

Widget descriptionString(String description) {
  return Text(
    description,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Color(0xFF388E3C),
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
