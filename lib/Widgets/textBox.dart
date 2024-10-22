import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget formText(
    {required String messageError,
    required String labelText,
    String? hintText,
    Icon? icono,
    required TextEditingController control,
    bool autofocus = false}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return messageError;
      }
      return null;
    },
    autocorrect: true,
    autofocus: autofocus,
    decoration: InputDecoration(
        labelText: labelText,
        icon: icono,
        hintText: hintText,
        fillColor: const Color(0xFFF1F8FE),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFB3D4E6), // Borde de la caja de texto
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF007BFF), // Borde cuando está enfocada
          ),
        )),
    keyboardType: TextInputType.text,
    controller: control,
  );
}

Widget formPassword(String messageError, String labelText, String hintText,
    Icon icono, TextEditingController control) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return messageError;
      }
      return null;
    },
    decoration: InputDecoration(
        labelText: labelText,
        icon: icono,
        hintText: hintText,
        fillColor: const Color(0xFFF1F8FE),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFB3D4E6), // Borde de la caja de texto
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF007BFF), // Borde cuando está enfocada
          ),
        )),
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    controller: control,
  );
}

Widget formDate(String messageError, String labelText, String hintText,
    Icon icono, TextEditingController control, BuildContext context) {
  return TextFormField(
    controller: control,
    decoration: InputDecoration(
        labelText: labelText,
        icon: icono,
        hintText: hintText,
        fillColor: const Color(0xFFF1F8FE),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFB3D4E6), // Borde de la caja de texto
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF007BFF), // Borde cuando está enfocada
          ),
        )),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return messageError;
      }
      return null;
    },
    keyboardType: TextInputType.none, // Desactiva el teclado
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context, // Utiliza el contexto proporcionado al método
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        control.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      }
    },
  );
}

Widget formNumber(String messageError, String labelText, String hintText,
    Icon icono, TextEditingController control) {
  return TextFormField(
    controller: control,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
        labelText: labelText,
        icon: icono,
        hintText: hintText,
        fillColor: const Color(0xFFF1F8FE),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFB3D4E6), // Borde de la caja de texto
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF007BFF), // Borde cuando está enfocada
          ),
        )),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return messageError;
      }
      // Verifica si el valor contiene solo números
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return 'Por favor, ingrese solo números.';
      }
      return null;
    },
  );
}

Widget selectFormText(
    {required String messageError,
    required String labelText,
    String? hintText,
    Icon? icono,
    required TextEditingController control,
    required List<String> options,
    bool autofocus = false}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: labelText,
      icon: icono,
      hintText: hintText,
      fillColor: const Color(0xFFF1F8FE),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFFB3D4E6), // Borde de la caja de texto
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF007BFF), // Borde cuando está enfocada
        ),
      ),
    ),
    items: options.map((String option) {
      return DropdownMenuItem<String>(
        value: option,
        child: Text(option),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) {
        control.text =
            value; // Actualiza el controlador con el valor seleccionado
      }
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return messageError;
      }
      return null;
    },
  );
}
