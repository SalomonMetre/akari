import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/constants/route_paths.dart';
import 'package:akari/functions/routing.dart';
import 'package:akari/functions/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Future<bool?> _showQuitDialog(BuildContext context) async {
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
                leading: const Icon(Icons.account_box, color: AppColors.blue2),
                title: const Text('Sign In'),
                onTap: () {
                  Navigator.pop(context);
                  // Replace 'RouteNames.signInPage' with the actual route name for your sign-in page
                  goToNamed(context, destination: RouteNames.signInPage, push: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: AppColors.blue2),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO go to home page
                  goToNamed(context, destination: RouteNames.homePage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: AppColors.blue2),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO go to about page
                  goToNamed(context, destination: RouteNames.homePage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: AppColors.blue2),
                title: const Text('Sign Out'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement sign-out logic
                  // Example: call a sign-out method from your authentication service
                  // Once signed out, you may navigate to a different page or update UI accordingly
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle easy level tap
                    goTo(context, destination: '${RoutePaths.levelPage}/Easy', push: true);
                  },
                  child: Expanded(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.blue3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Easy',
                        style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Handle medium level tap
                    goTo(context, destination: '${RoutePaths.levelPage}/Medium', push: true);
                  },
                  child: Expanded(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Medium',
                        style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Handle infernal level tap
                    goTo(context, destination: '${RoutePaths.levelPage}/Infernal', push: true);
                  },
                  child: Expanded(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Infernal',
                        style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Handle multiplayer level tap
                    goToNamed(context, destination: RouteNames.multiPlayerPage, push: true);
                  },
                  child: Expanded(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '👥 Multiplayer',
                        style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.blue2,
        unselectedItemColor: AppColors.white,
        selectedItemColor: AppColors.yellow,
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
        onTap: (index) async {
          if (index == 2) {
            final result = await _showQuitDialog(context);
            if (result != null && result) {
              appExit();
            }
          }
        },
      ),
    );
  }
}
