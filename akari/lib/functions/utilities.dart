import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool?> showYesNoDialog(BuildContext context,
    {required String confirmText, required String questionText}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(confirmText),
        content: Text(questionText),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No', style: GoogleFonts.cabin(color: Colors.white),),
          ),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.teal)),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes', style: GoogleFonts.cabin(color: Colors.white),),
          ),
        ],
      );
    },
  );
}
