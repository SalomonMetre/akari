import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/asset_names.dart';
import 'package:akari/constants/fonts.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/constants/texts.dart';
import 'package:akari/functions/routing.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Main page
/// Contains the main game menu
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GFImageOverlay(
          image: const AssetImage(ImagePaths.appLogo),
          colorFilter: ColorFilter.mode(
              AppColors.logoBgColor.withOpacity(0.95), BlendMode.lighten),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('PLAY NOW', textStyle: GoogleFonts.nosifer(fontSize: 25, color: Colors.teal),),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                  const Divider(color: Colors.teal,),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: HomePageTxtConstants.homeTabLabel,
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: HomePageTxtConstants.settingsTabLabel,
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: HomePageTxtConstants.quitTabLabel,
            icon: Icon(Icons.exit_to_app),
          ),
        ],
        currentIndex: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        onTap: (index) {
          switch (index) {
            case 0:
              goTo(context, destination: RouteNames.homePage);
              break;
            case 1:
              goTo(context, destination: RouteNames.homePage);
              break;
            case 2:
              goTo(context, destination: RouteNames.homePage);
          }
        },
      ),
    );
  }
}
