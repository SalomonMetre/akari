import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/functions/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

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
            style: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppColors.white), backgroundColor: WidgetStatePropertyAll( AppColors.green)),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
          TextButton(
            style: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppColors.white), backgroundColor: WidgetStatePropertyAll( AppColors.red)),
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
          child: Text(
            textAlign: TextAlign.center,
            'Congratulations!',
            style: GoogleFonts.cabin(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.blue1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,  // This line is added
          children: [
            const Icon(Ionicons.trophy, size: 20, color: AppColors.yellow),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Congrats !",
                style: GoogleFonts.cabin(fontSize: 12),
                children: <TextSpan>[
                  TextSpan(text: "\nYOU WON !", style: GoogleFonts.cabin(fontSize: 20, shadows: <Shadow>[
                    Shadow(blurRadius: 10, offset: Offset.fromDirection(1, 5)),Shadow(blurRadius: 10, offset: Offset.fromDirection(2, 5)),
                  ])),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,  // This line is added
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                    minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 50)),
                  ),
                  onPressed: () {
                    // TODO: Implement next level functionality
                    goToNamed(context, destination: RouteNames.levelPage);
                  },
                  child: Text(
                    'Next Level',
                    style: GoogleFonts.cabin(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 50)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: GoogleFonts.cabin(fontSize: 16, color: Colors.white),
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

