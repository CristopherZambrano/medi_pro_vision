import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Widgets/botones.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';

void showDialogAlertAndRedirection(
    BuildContext context, String title, String description,
    {required VoidCallback onPressed}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: primaryTitle(title),
          content: descriptionString(description),
          actions: [
            secondaryButton(
              buttonText: 'Close',
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
            )
          ],
        );
      });
}

void showDialogAlert(BuildContext context, String title, String description) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: primaryTitle(title),
          content: descriptionString(description),
          actions: [
            secondaryButton(
              buttonText: 'Close',
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
