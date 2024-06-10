// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:akari/models/auth_model.dart';
import 'package:akari/models/db_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/constants/route_paths.dart';
import '../functions/routing.dart'; // Import your DbModel

class LevelPage extends StatefulWidget {
  final String difficulty;

  const LevelPage({Key? key, required this.difficulty}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  List<int> unlockedGameNos = [];

  @override
  void initState() {
    super.initState();
    fetchUnlockedGames(); // Call method to fetch unlocked games
  }


  Future<void> fetchUnlockedGames() async {
    // Retrieve current user's email (replace this with your actual implementation)
    String userEmail = Auth().firebaseAuthInstance.currentUser!.email!;

    try {
      // Query Firestore for unlocked games
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await DbModel.instance.getAllDataWhereConditions(
        collectionName: "unlocked_games",
        conditions: {"user_email": userEmail, "difficulty": widget.difficulty},
      );

      // Extract unlocked game numbers from snapshot
      List<int> unlockedGames =
          snapshot.docs.map((doc) => doc["game_no"] as int).toList();
      print(unlockedGames);

      // Update state with unlocked games
      setState(() {
        unlockedGameNos = unlockedGames;
      });
    } catch (e) {
      print("Error fetching unlocked games: $e");
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue2,
        foregroundColor: AppColors.white,
        title: Text(
          widget.difficulty,
          style: GoogleFonts.cherrySwash(),
        ),
        centerTitle: true,
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
      
      body: RefreshIndicator(
        onRefresh: () async {
          // Call fetchUnlockedGames to refresh the unlocked games list
          await fetchUnlockedGames();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
          color: AppColors.blue1,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: 40,
            itemBuilder: (BuildContext context, int index) {
              final gameNo = index + 1;
              final isUnlocked =
                  unlockedGameNos.contains(gameNo) || gameNo == 1;
              return GestureDetector(
                onTap: isUnlocked
                    ? () {
                        // Launch game
                        goTo(context,
                            destination:
                                '${RoutePaths.gamePage}/${widget.difficulty}/$gameNo/',
                            push: true);
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: isUnlocked ? AppColors.purple : AppColors.blue2,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: isUnlocked
                        ? Text(
                            '$gameNo',
                            style: GoogleFonts.cherrySwash(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          )
                        : const Icon(Icons.lock, color: AppColors.purple),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.blue2,
        unselectedItemColor: Colors.white,
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
        currentIndex: 0,
        selectedItemColor: AppColors.yellow,
        onTap: (index) {
          print('Tapped index $index');
        },
      ),
    );
  }
}
