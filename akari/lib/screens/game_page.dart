import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/functions/cell_functions.dart';
import 'package:akari/functions/grid_functions.dart';
import 'package:akari/functions/utilities.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../functions/routing.dart';

class GamePage extends StatefulWidget {
  final String level;
  final int gameNo;
  const GamePage({Key? key, required this.level, required this.gameNo})
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

  void _initializeDiffGridPropositionAndArraySize() {
    gridSize = switch (widget.level) {
      "Easy" => 8,
      "Medium" => 9,
      _ => 10,
    };
    difficulty = switch (widget.level) {
      "Easy" => 0.1,
      "Medium" => 0.2,
      _ => 0.25,
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
    print("Initial grid : ");
    afficherGrille(gridProposition, gridSize);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _seconds++;
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
                leading: const Icon(Icons.settings, color: AppColors.blue2),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  goToNamed(context, destination: RouteNames.homePage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: AppColors.blue2),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  goToNamed(context, destination: RouteNames.homePage);
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
                  child: Text(
                    _formatTime(_seconds),
                    style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white),
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
                          crossAxisSpacing: 0.5,
                          mainAxisSpacing: 0.5,
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
                              child: Center(
                                child: renderCell(
                                    gridProposition: gridProposition,
                                    row: row,
                                    col: col,
                                    cellSize: cellSize),
                              ),
                            ),
                            onTap: () {
                              if (gridProposition[row][col] == 0) {
                                ajouterLampe(
                                    gridProposition, gridSize, row, col);
                                setState(() {});
                                if (isGridCorrect(gridProposition)) {
                                    showLevelEndDialog(context);
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Handle check button press
                          print('Check button pressed');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.blue2,
                        ),
                        child: const Text('Check'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle leaderboard button press
                          print('Leaderboard button pressed');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.blue2,
                        ),
                        child: const Text('Leaderboard'),
                      ),
                    ],
                  ),
                ),
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
