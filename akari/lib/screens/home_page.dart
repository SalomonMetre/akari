import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/functions/routing.dart';
import 'package:akari/functions/utilities.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue2,
        foregroundColor: AppColors.white,
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.blue2,
                ),
                child: Text(
                  'Akari Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: AppColors.blue2),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO go to home page
                  goToNamed(context, destination: RouteNames.homePage);
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: AppColors.blue2),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO go to about page
                  goToNamed(context, destination: RouteNames.homePage);
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blue1, AppColors.blue2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'PLAY NOW',
                    textStyle: GoogleFonts.nosifer(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                onTap: () {
                  goToNamed(context, destination: RouteNames.menuPage, push: true);
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 32), child: Divider(color: AppColors.white,),)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.blue2,
        unselectedItemColor: AppColors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Quit',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.yellow,
        onTap: (index) async {
          if (index == 2) {
            final result = await showQuitDialog(context);
            if (result != null && result) {
              appExit();
            }
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
