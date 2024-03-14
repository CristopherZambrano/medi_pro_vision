import 'package:flutter/material.dart';

Widget primaryTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28.0,
      fontFamily: "Roboto",
      fontStyle: FontStyle.italic,
      color: Colors.black,
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

Widget formText(String messageError, String labelText, String hintText,
    Icon icono, TextEditingController control) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return messageError;
      }
      return null;
    },
    decoration:
        InputDecoration(labelText: labelText, icon: icono, hintText: hintText),
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
    decoration:
        InputDecoration(labelText: labelText, icon: icono, hintText: hintText),
    keyboardType: TextInputType.visiblePassword,
    controller: control,
  );
}

Widget formDate(String messageError, String labelText, String hintText,
    Icon icono, TextEditingController control) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return messageError;
      }
      return null;
    },
    decoration:
        InputDecoration(labelText: labelText, icon: icono, hintText: hintText),
    keyboardType: TextInputType.datetime,
    controller: control,
  );
}

Widget formNumber(String messageError, String labelText, String hintText,
    Icon icono, TextEditingController control) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return messageError;
      }
      return null;
    },
    decoration:
        InputDecoration(labelText: labelText, icon: icono, hintText: hintText),
    keyboardType: TextInputType.phone,
    controller: control,
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
