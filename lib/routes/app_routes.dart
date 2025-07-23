import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/write_screen.dart';
import '../screens/wow_moments_screen.dart';
import '../screens/daily_growth_screen.dart';
import '../screens/tech_cards_screen.dart';
import '../screens/search_screen.dart';
import '../screens/lab_screen.dart';
import '../screens/about_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String write = '/write';
  static const String wowMoments = '/wow-moments';
  static const String dailyGrowth = '/daily-growth';
  static const String techCards = '/tech-cards';
  static const String search = '/search';
  static const String lab = '/lab';
  static const String about = '/about';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
      write: (context) => const WriteScreen(),
      wowMoments: (context) => const WowMomentsScreen(),
      dailyGrowth: (context) => const DailyGrowthScreen(),
      techCards: (context) => const TechCardsScreen(),
      search: (context) => const SearchScreen(),
      lab: (context) => const LabScreen(),
      about: (context) => const AboutScreen(),
    };
  }
}