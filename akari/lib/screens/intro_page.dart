import 'package:akari/constants/app_colors.dart';
import 'package:akari/constants/asset_names.dart';
import 'package:akari/constants/fonts.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/constants/texts.dart';
import 'package:akari/functions/routing.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

/// Initial page :
/// contains game instructions, leads to HomePage
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  late List<Widget> slideList;
  late int initialPage;
  int initialIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: GFIntroScreen(
          color: AppColors.logoBgColor,
          slides: slides(screenSize: screenSize),
          pageController: _pageController,
          currentIndex: initialIndex,
          pageCount: 3,
          introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
            pageController: _pageController,
            pageCount: slideList.length,
            currentIndex: initialPage,
            onForwardButtonTap: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInCirc,
              );
            },
            onBackButtonTap: () {
              _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            onDoneTap: () {
              goTo(context, destination: RouteNames.homePage, push: true);
            },
            onSkipTap: () {
              goTo(context, destination: RouteNames.homePage, push: true);
            },
            dotShape: const CircleBorder(side: BorderSide.none),
            navigationBarColor: AppColors.logoBgColor,
            showDivider: false,
            activeColor: GFColors.SUCCESS,
          ),
        ),
      ),
    );
  }

  List<Widget> slides({required Size screenSize}) {
    slideList = [
      GFImageOverlay(
        height: 200,
        width: 300,
        image: const AssetImage(ImagePaths.appLogo),
        colorFilter: ColorFilter.mode(
            AppColors.logoBgColor.withOpacity(0.95), BlendMode.lighten),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Text(
                  "What is Akari ?",
                  style: GoogleFonts.aclonica(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Container(
                color: Colors.transparent,
                child: Text(
                  TextConstants.akariDescription,
                  style: AppFonts.introStyle,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GFButton(
                    color: GFColors.SUCCESS,
                    onPressed: null,
                    child: Text(
                      "Play Now",
                      style: GoogleFonts.aclonica(color: GFColors.WHITE),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      GFImageOverlay(
        height: 200,
        width: 300,
        image: const AssetImage(ImagePaths.appLogo),
        colorFilter: ColorFilter.mode(
            AppColors.logoBgColor.withOpacity(0.95), BlendMode.lighten),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 96.0, horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Akari Rules",
                  style: GoogleFonts.aclonica(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                GFAccordion(
                  title: "Rule @1",
                  content: TextConstants.akariRules1,
                  contentBackgroundColor: Colors.transparent,
                  collapsedTitleBackgroundColor: GFColors.TRANSPARENT,
                  textStyle: AppFonts.introStyle,
                ),
                GFAccordion(
                  title: "Rule @2",
                  content: TextConstants.akariRules2,
                  contentBackgroundColor: GFColors.TRANSPARENT,
                  collapsedTitleBackgroundColor: GFColors.TRANSPARENT,
                  textStyle: AppFonts.introStyle,
                ),
                GFAccordion(
                  title: "Rule @3",
                  content: TextConstants.akariRules3,
                  contentBackgroundColor: Colors.transparent,
                  collapsedTitleBackgroundColor: GFColors.TRANSPARENT,
                  textStyle: AppFonts.introStyle,
                ),
                GFAccordion(
                  title: "Rule @4",
                  content: TextConstants.akariRules4,
                  contentBackgroundColor: Colors.transparent,
                  collapsedTitleBackgroundColor: GFColors.TRANSPARENT,
                  textStyle: AppFonts.introStyle,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GFButton(
                      color: GFColors.SUCCESS,
                      onPressed: null,
                      child: Text(
                        "Play Now",
                        style: GoogleFonts.aclonica(color: GFColors.WHITE),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      GFImageOverlay(
        height: 200,
        width: 300,
        image: const AssetImage(ImagePaths.appLogo),
        colorFilter: ColorFilter.mode(
            AppColors.logoBgColor.withOpacity(0.95), BlendMode.lighten),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Text(
                  "Fun Fact 🤯 ",
                  style: GoogleFonts.aclonica(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Container(
                color: Colors.transparent,
                child: Text(
                  TextConstants.funFactComplexity,
                  style: AppFonts.introStyle,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GFButton(
                    color: GFColors.SUCCESS,
                    onPressed: null,
                    child: Text(
                      "Play Now",
                      style: GoogleFonts.aclonica(color: GFColors.WHITE),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ];
    return slideList;
  }
}
