import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'router.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://alkomflkcldxbzqomdot.supabase.co',
    publishableKey: 'sb_publishable_j7t_dBx5QOq63iRn2IPauQ_KnbQfGgM',
  );

  runApp(
    const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF2B0008),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'rp_silver_house',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
