import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/constants/route_paths.dart';
import 'package:akari/models/sqlite_level_model_repository.dart';
import '../functions/routing.dart';

class LevelPage extends StatefulWidget {
  final String level;

  const LevelPage({Key? key, required this.level}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  List<int> unlockedGameNos = [];

  @override
  void initState() {
    super.initState();
    initializeUnlockedGameNos();
  }

  Future<void> initializeUnlockedGameNos() async {
    final levels =
        await SQLiteLevelModelRepository().getLevelsByLevel(widget.level);
    setState(() {
      unlockedGameNos = levels
          .where((level) => level.status)
          .map<int>((level) => level.gameNo)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue2,
        foregroundColor: AppColors.white,
        title: Text(
          widget.level,
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
      body: Container(
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
            final isUnlocked = unlockedGameNos.contains(gameNo) || gameNo == 1;
            return GestureDetector(
              onTap: isUnlocked
                  ? () {
                      // Launch game
                      goTo(context,
                          destination:
                              '${RoutePaths.gamePage}/${widget.level}/$gameNo/',
                          push: true);
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: isUnlocked ? AppColors.purple : AppColors.blue2,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: isUnlocked ? Text(
                    '$gameNo',
                    style: GoogleFonts.cherrySwash(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ) : const Icon(Icons.lock, color:AppColors.purple),
                ),
              ),
            );
          },
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
