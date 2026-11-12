import 'package:flutter/material.dart';

import 'catalogpage.dart';
 

class CatalogLayout extends StatelessWidget {
  const CatalogLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // This creates an internal stack just like Expo's Stack component
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CatalogPage(),
        );
      },
    );
  }
}