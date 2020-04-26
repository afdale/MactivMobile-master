
import 'package:flutter/material.dart';

void showDialogSingleButtonWithAction(BuildContext context, String title, String message, String buttonLabel,Function onPressed) {
  // flutter defined function
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return WillPopScope(
        onWillPop: ()async=>false,
        child: AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(buttonLabel),
              onPressed: onPressed,
            ),
          ],
        )
      );
    },
  );
}