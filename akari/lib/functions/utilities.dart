import 'package:akari/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void appExit() {
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
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red)),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'No',
              style: GoogleFonts.cabin(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.teal)),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Yes',
              style: GoogleFonts.cabin(color: Colors.white),
            ),
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

void showLevelEndDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            textAlign: TextAlign.center,
            'Congratulations!',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.blue1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: const Text(
          textAlign: TextAlign.right,
          'You have solved the puzzle!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.blue3),
                      minimumSize: WidgetStateProperty.all(
                          const Size(double.infinity, 50)),
                    ),
                    onPressed: () {
                      // TODO: Implement save my score functionality
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save Score',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                      minimumSize: WidgetStateProperty.all(
                          const Size(double.infinity, 50)),
                    ),
                    onPressed: () {
                      // TODO: Implement next level functionality
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Next Level',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                      minimumSize: WidgetStateProperty.all(
                          const Size(double.infinity, 50)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
