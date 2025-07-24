import 'package:flutter/material.dart';
import '../animations/page_transitions.dart';
import '../routes/app_routes.dart';
import '../screens/home_screen.dart';
import '../screens/write_screen.dart';
import '../screens/wow_moments_screen.dart';
import '../screens/daily_growth_screen.dart';
import '../screens/tech_cards_screen.dart';
import '../screens/search_screen.dart';
import '../screens/lab_screen.dart';
import '../screens/about_screen.dart';
import '../widgets/main_layout.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    String routeName = settings.name ?? AppRoutes.home;
    
    switch (routeName) {
      case AppRoutes.home:
        page = const HomeScreen();
        break;
      case AppRoutes.write:
        page = const WriteScreen();
        break;
      case AppRoutes.wowMoments:
        page = const WowMomentsScreen();
        break;
      case AppRoutes.dailyGrowth:
        page = const DailyGrowthScreen();
        break;
      case AppRoutes.techCards:
        page = const TechCardsScreen();
        break;
      case AppRoutes.search:
        page = const SearchScreen();
        break;
      case AppRoutes.lab:
        page = const LabScreen();
        break;
      case AppRoutes.about:
        page = const AboutScreen();
        break;
      default:
        page = Center(child: Text('页面未找到 $routeName'));
        routeName = AppRoutes.home;
    }

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => MainLayout(
        currentRoute: routeName,
        child: page,
      ),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  static void navigateWithAnimation(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}

enum PageTransitionType {
  fade,
  slideIn,
  blurZoom,
  starSweep,
}
