import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'footer.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String currentRoute;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomNavigationBar(currentRoute: currentRoute),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: SingleChildScrollView(
                key: ValueKey(currentRoute),
                child: Column(
                  children: [
                    child,
                    const CustomFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}