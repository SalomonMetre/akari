// ignore_for_file: use_build_context_synchronously, use_super_parameters, unused_local_variable, library_private_types_in_public_api

import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/functions/cell_functions.dart';
import 'package:akari/functions/grid_functions.dart';
import 'package:akari/functions/utilities.dart';
import 'package:akari/models/auth_model.dart';
import 'package:akari/models/db_model.dart';
import 'package:akari/screens/leaderboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:async';
import '../functions/routing.dart';

class GamePage extends StatefulWidget {
  final String difficulty;
  final int gameNo;
  const GamePage({Key? key, required this.difficulty, required this.gameNo})
      : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Timer _timer;
  int _seconds = 0;
  int gridSize = 0;
  List<List<int>> gridProposition = [];
  double difficulty = 0.0;
  bool hasGameEnded = false;
  int oldScore = 0, bestScore = 0;

  Future<void> fetchLeaderboardData() async {
    String userEmail = Auth().firebaseAuthInstance.currentUser!.email!;

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await DbModel.instance.getAllDataWhereConditions(
        collectionName: "unlocked_games",
        conditions: {
          "difficulty": widget.difficulty,
          "game_no": widget.gameNo,
        },
      );

      if (snapshot.size > 0) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> leaderboard =
            snapshot.docs;
        showLeaderboardDialog(leaderboard);
      } else {
        print('No leaderboard data found.');
      }
    } catch (e) {
      print("Error fetching leaderboard data: $e");
    }
  }

  void showLeaderboardDialog(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> leaderboard) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Leaderboard'),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Players' scores:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: leaderboard.length,
                  itemBuilder: (context, index) {
                    final entry = leaderboard[index];
                    return ListTile(
                      title: Text(
                        'Email: ${entry['user_email']}',
                        style: const TextStyle(color: AppColors.white),
                      ),
                      subtitle: Text(
                        'Score: ${entry['score']}',
                        style: const TextStyle(color: AppColors.yellow),
                      ),
                      tileColor: entry['user_email'] ==
                              Auth().firebaseAuthInstance.currentUser!.email!
                          ? AppColors.blue3
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> unlockNextGameForCurrentDifficulty(
      String email, String difficulty, int gameNo) async {
    try {
      // Unlock the next game for the current difficulty level
      await DbModel.instance.save(
        // documentId: email,
        collectionName: "unlocked_games",
        data: {
          "user_email": email,
          "difficulty": difficulty,
          "game_no": gameNo,
        },
      );
    } catch (e) {
      print("Error unlocking next game for $difficulty difficulty: $e");
    }
  }

  Future<void> _fetchBestScore() async {
    String userEmail = Auth().firebaseAuthInstance.currentUser!.email!;
    try {
      final snapshot = await DbModel.instance.getAllDataWhereConditions(
        collectionName: "unlocked_games",
        conditions: {
          "user_email": userEmail,
          "difficulty": widget.difficulty,
          "game_no": widget.gameNo,
        },
      );
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          // Update bestScore if score exists and is less than current bestScore
          bestScore = snapshot.docs.first["score"] ?? 0;
          oldScore = bestScore;
        });
      }
    } catch (e) {
      print("Error fetching best score: $e");
    }
  }

  void _initializeDiffGridPropositionAndArraySize() {
    gridSize = switch (widget.difficulty) {
      "Easy" => 8,
      "Medium" => 9,
      _ => 10,
    };
    difficulty = switch (widget.difficulty) {
      "Easy" => 0.1,
      "Medium" => 0.2,
      _ => 0.3,
    };
    gridProposition = genererGrilleProposition(
        genererGrilleSolution(
            genererGrilleVide(gridSize), gridSize, difficulty),
        gridSize);
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    _initializeDiffGridPropositionAndArraySize();
    _fetchBestScore();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _seconds = !hasGameEnded ? _seconds + 1 : _seconds;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
      
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double maxWidth =
              constraints.maxWidth - 40; // Container padding
          final double maxHeight = constraints.maxHeight -
              220; // Time padding, container padding, bottom nav

          final int crossAxisCount = gridSize; // Number of cells in a row
          final double cellWidth =
              (maxWidth - (crossAxisCount - 1) * 5) / crossAxisCount;
          final double cellHeight =
              (maxHeight - (crossAxisCount - 1) * 5) / crossAxisCount;
          final double cellSize =
              cellWidth < cellHeight ? cellWidth : cellHeight;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.blue1, AppColors.blue2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: AppColors.blue2,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Ionicons.flag,
                                  color: AppColors.green,
                                ),
                                Text(
                                  "Give Up !",
                                  style: GoogleFonts.cabin(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          textAlign: TextAlign.center,
                          _formatTime(_seconds),
                          style: GoogleFonts.cabin(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          // _formatTime(_seconds),
                          "Current \nBest Score : $bestScore",
                          style: GoogleFonts.cabin(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            AppColors.blue3,
                            AppColors.blue2,
                            AppColors.blue3
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 0.3,
                          mainAxisSpacing: 0.3,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: gridSize * gridSize,
                        itemBuilder: (BuildContext context, int index) {
                          final int row = index ~/ gridSize;
                          final int col = index % gridSize;
                          return GestureDetector(
                            child: SizedBox(
                              width: cellSize,
                              height: cellSize,
                              child: renderCell(
                                  gridProposition: gridProposition,
                                  row: row,
                                  col: col,
                                  cellSize: cellSize),
                            ),
                            onTap: () async {
                              if (gridProposition[row][col] == 0) {
                                ajouterLampe(
                                    gridProposition, gridSize, row, col);
                                setState(() {});
                                if (isGridCorrect(gridProposition)) {
                                  showLevelEndDialog(context);
                                  hasGameEnded = true;
                                  await unlockNextGameForCurrentDifficulty(
                                      Auth()
                                          .firebaseAuthInstance
                                          .currentUser!
                                          .email!,
                                      widget.difficulty,
                                      widget.gameNo + 1);
                                  setState(() {});
                                }
                              } else if (gridProposition[row][col] == 10) {
                                retirerLampe(
                                    gridProposition, gridSize, row, col);
                                setState(() {});
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.blue1,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (hasGameEnded) {
                            bestScore = _seconds;
                            if (bestScore < oldScore || oldScore == 0) {
                              DbModel.instance.save(
                                  collectionName: "unlocked_games",
                                  data: {
                                    "user_email": Auth()
                                        .firebaseAuthInstance
                                        .currentUser!
                                        .email!,
                                    "difficulty": widget.difficulty,
                                    "game_no": widget.gameNo,
                                    "score": bestScore,
                                  });
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(AppColors.blue3),
                            foregroundColor:
                                WidgetStateProperty.all(AppColors.white)),
                        child: Text(
                          "Save Score",
                          style: GoogleFonts.cabin(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LeaderboardPage(
                                difficulty: widget.difficulty,
                                gameNo: widget.gameNo,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(AppColors.blue3),
                            foregroundColor:
                                WidgetStateProperty.all(AppColors.white)),
                        child: Text(
                          "Leaderboard",
                          style: GoogleFonts.cabin(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
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
            final result = await showQuitDialog(context);
            if (result != null && result) {
              appExit();
            }
          }
        },
      ),
    );
  }
}
