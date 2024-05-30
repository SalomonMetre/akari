import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/constants/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../functions/routing.dart';

class LevelPage extends StatefulWidget {
  final String level;
  const LevelPage({Key? key, required this.level}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  final List<int> levels = List.generate(40, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue2,
        foregroundColor: AppColors.white,
        title: Text(widget.level, style: GoogleFonts.cherrySwash(),),
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
          itemCount: levels.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // launch game
                goTo(context, destination: '${RoutePaths.gamePage}/${widget.level}/${levels[index]}/', push: true);
              },
              // onTap: null,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.purple,
                  // color: AppColors.blue2,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    '${levels[index]}',
                    style: GoogleFonts.cherrySwash(
                      // color: Colors.blue1,
                      color : AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  // child: Icon(Icons.lock, color: AppColors.purple,),
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
