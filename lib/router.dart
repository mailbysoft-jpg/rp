import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rp_silver_house/src/Services/registernotifier.dart';

import 'package:rp_silver_house/registerpage.dart';
import 'package:rp_silver_house/src/tabs/contactpage.dart';
import 'package:rp_silver_house/welcomepage.dart';

import 'src/tabs/tablayout.dart';
import 'src/tabs/homepage.dart';
import 'src/tabs/bankpage.dart';
import 'src/tabs/catalog/catalogpage.dart';
import 'src/tabs/catalog/detailpage.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/home',
  refreshListenable: registerNotifier,
  redirect: (BuildContext context, GoRouterState state) {
    // Wait until SharedPreferences has finished loading
    if (!registerNotifier.isReady) return null;

    final bool hasRegistered = registerNotifier.hasRegistered;
    final String location = state.matchedLocation;
    final bool isOnboardingRoute =
        location == '/welcome' || location == '/register';

    // 1. First time user: direct them to /welcome (or /register)
    if (!hasRegistered) {
      return isOnboardingRoute ? null : '/welcome';
    }

    // 2. Already registered: block marketing/welcome screens and send straight home
    if (isOnboardingRoute) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/register',
      builder: (context, state) {
        return const RegisterPage();
      },
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) {
        return const WelcomePage();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Tablayout(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),

        // Tab 1: Contact
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/contact',
              builder: (context, state) => const ContactPage(),
            ),
          ],
        ),

        // Tab 2: Bank
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bank',
              builder: (context, state) => const Bankpage(),
            ),
          ],
        ),

        // Tab 3: Catalog
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/catalog',
              builder: (context, state) => const CatalogPage(),
            ),
            GoRoute(
              path: '/catalog/detail/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return DetailPage(productId: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
