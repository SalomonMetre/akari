import 'package:akari/constants/route_paths.dart';
import 'package:akari/constants/route_names.dart';
import 'package:akari/screens/home_page.dart';
import 'package:akari/screens/intro_page.dart';
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
        builder: (context, GoRouterState state) => const IntroPage(),
      ),
      GoRoute(
        path: RoutePaths.homePage,
        name: RouteNames.homePage,
        builder: (context, GoRouterState state) => const HomePage(),
      ),
    ],
  );
}
