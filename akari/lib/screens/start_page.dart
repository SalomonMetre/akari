import 'package:akari/constants/asset_names.dart';
import 'package:akari/constants/numericals.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/functions/routing.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:animate_do/animate_do.dart';

/// Start page :
/// It contains the main animation that leads to the IntroPage
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: FlutterSplashScreen.fadeIn(
              animationCurve: Curves.slowMiddle,
              backgroundImage: Image.asset(
                ImagePaths.appLogo,
              ),
              duration: const Duration(seconds: Numericals.splashScreenDuration),
              onAnimationEnd: () {
                GFToast.showToast(
                  "Welcome to AKARI!",
                  context,
                  toastDuration: 5,
                  toastPosition: GFToastPosition.BOTTOM,
                  trailing: const Icon(
                    Icons.info,
                    color: GFColors.SUCCESS,
                  ),
                );
                goToNamed(context, destination: RouteNames.introPage, push: true);
              },
              childWidget: Center(
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: FadeIn(
                    duration: const Duration(seconds: 2),
                    child: Image.asset(
                      ImagePaths.appLogo,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
