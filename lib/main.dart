import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/blog_model.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'data/sample_data.dart';
import 'utils/route_manager.dart';

void main() {
  runApp(const PersonalBlogApp());
}

class PersonalBlogApp extends StatelessWidget {
  const PersonalBlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final blogModel = BlogModel();
          SampleData.loadSampleData(blogModel);
          return blogModel;
        }),
      ],
      child: MaterialApp(
        title: '重拾 · 小宇宙',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: RouteManager.generateRoute,
        initialRoute: AppRoutes.home,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
