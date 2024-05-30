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
          color: Colors.transparent,
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
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
            onBackButtonTap: () {
              _pageController.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear);
            },
            onDoneTap: () {
              goToNamed(context, destination: RouteNames.homePage, push: true);
            },
            onSkipTap: () {
              goToNamed(context, destination: RouteNames.homePage, push: true);
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
      buildSlide(
        screenSize: screenSize,
        title: "What is Akari ?",
        description: TextConstants.akariDescription,
        buttonText: "Play Now",
        image: ImagePaths.appLogo,
      ),
      buildSlide(
        screenSize: screenSize,
        title: "Akari Rules",
        description: "",
        buttonText: "Play Now",
        image: ImagePaths.appLogo,
        content: SingleChildScrollView(
          child: Column(
            children: [
              buildAccordion("Rule @1", TextConstants.akariRules1),
              buildAccordion("Rule @2", TextConstants.akariRules2),
              buildAccordion("Rule @3", TextConstants.akariRules3),
              buildAccordion("Rule @4", TextConstants.akariRules4),
            ],
          ),
        ),
      ),
      buildSlide(
        screenSize: screenSize,
        title: "Fun Fact 🤯",
        description: TextConstants.funFactComplexity,
        buttonText: "Play Now",
        image: ImagePaths.appLogo,
      ),
    ];
    return slideList;
  }

  Widget buildSlide({
    required Size screenSize,
    required String title,
    required String description,
    required String buttonText,
    required String image,
    Widget? content,
  }) {
    return Container(
      width: screenSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.blue1, AppColors.blue2,],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              title,
              style: GoogleFonts.aclonica(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (description.isNotEmpty)
              Text(
                description,
                style: AppFonts.introStyle.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            if (content != null) ...[
              const SizedBox(height: 24),
              Expanded(child: content),
            ],
            const SizedBox(height: 24),
            GFButton(
              color: GFColors.SUCCESS,
              onPressed: () {
                goToNamed(context, destination: RouteNames.homePage, push: true);
              },
              child: Text(
                buttonText,
                style: GoogleFonts.aclonica(color: GFColors.WHITE),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccordion(String title, String content) {
    return GFAccordion(
      showAccordion: true,
      title: title,
      content: content,
      expandedTitleBackgroundColor: AppColors.blue2,
      contentBackgroundColor: AppColors.blue1,
      collapsedTitleBackgroundColor: AppColors.blue1,
      textStyle: AppFonts.introStyle.copyWith(color: Colors.white),
    );
  }
}
