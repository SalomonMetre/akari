// ignore_for_file: use_build_context_synchronously, use_super_parameters, unused_local_variable, library_private_types_in_public_api, must_be_immutable

import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/functions/cell_functions.dart';
import 'package:akari/functions/grid_functions.dart';
import 'package:akari/functions/utilities.dart';
import 'package:akari/multiplayer/client.dart';
import 'package:akari/multiplayer/server.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../functions/routing.dart';

class MultiPlayerGamePage extends StatefulWidget {
  Server? server;
  Client? client;
  final String difficulty;
  // final int gameNo;
  MultiPlayerGamePage({Key? key, required this.difficulty, this.server, this.client})
      : super(key: key);

  @override
  _MultiPlayerGamePageState createState() => _MultiPlayerGamePageState();
}

class _MultiPlayerGamePageState extends State<MultiPlayerGamePage> {
  late Timer _timer;
  int _seconds = 0;
  int gridSize = 0;
  List<List<int>> gridProposition = [];
  double difficulty = 0.0;
  bool hasGameEnded = false;

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
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.blue2,
                ),
                child: Text(
                  'Akari Game',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cabin(
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
