import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rp_silver_house/src/widgets/myheader.dart';

class Tablayout extends StatelessWidget {
  const Tablayout({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyHeader(),
      body: navigationShell, 

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 43, 0, 8),
          indicatorColor: const Color(0xFFE5A93B).withValues(alpha: 0.25),

          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Color(0xFFE5A93B));
            }
            return const IconThemeData(color: Colors.white);
          }),

          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Color(0xFFE5A93B),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );
            }
            return const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.shield_rounded),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.people_alt_rounded),
              label: "Contact",
            ),
            NavigationDestination(
              icon: Icon(Icons.radar_rounded),
              label: "Bank",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_suggest_rounded),
              label: "Catalog",
            ),
          ],
        ),
      ),
    );
  }
}