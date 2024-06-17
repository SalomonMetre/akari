import 'package:akari/constants/route_paths.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/screens/game_page.dart';
import 'package:akari/screens/home_page.dart';
import 'package:akari/screens/intro_page.dart';
import 'package:akari/screens/level_page.dart';
import 'package:akari/screens/menu_page.dart';
// import 'package:akari/screens/multiplayer_page.dart';
import 'package:akari/screens/signin_page.dart';
import 'package:akari/screens/signup_page.dart';
import 'package:akari/screens/start_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutePaths.startPage,
    routes: <RouteBase>[
      GoRoute(
          path: RoutePaths.startPage,
          name: RouteNames.startPage,
          builder: (context, state) => const StartPage(),
      ),
      GoRoute(
        path: RoutePaths.introPage,
        name: RouteNames.introPage,
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        path: RoutePaths.homePage,
        name: RouteNames.homePage,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RoutePaths.signInPage,
        name: RouteNames.signInPage,
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        path: RoutePaths.signUpPage,
        name: RouteNames.signUpPage,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: RoutePaths.menuPage,
        name: RouteNames.menuPage,
        builder: (context, state) => const MenuPage(),
      ),
      // GoRoute(
      //   path: RoutePaths.multiPlayerPage,
      //   name: RouteNames.multiPlayerPage,
      //   builder: (context, state) => MultiplayerPage(),
      // ),
      GoRoute(
        path: '${RoutePaths.levelPage}/:level',
        builder: (context, state) {
          final level = state.pathParameters['level']!;
          return LevelPage(difficulty: level);
        },
      ),
      GoRoute(
        path: '${RoutePaths.gamePage}/:level/:gameNo',
        name: RouteNames.gamePage,
        builder: (context, state){
          final level = state.pathParameters["level"]!;
          final gameNo = int.tryParse(state.pathParameters["gameNo"]!)!;
          return GamePage(difficulty: level, gameNo : gameNo);
        }
      )

    ],
  );
}
