import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void appExit(){
  SystemNavigator.pop();
}

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

Future<bool?> showQuitDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quit Game?'),
          content: const Text('Are you sure you want to quit the game?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }