import 'package:database_db_app/appDatabase/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff575DFB)),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.SIGNIN_PAGE,
      routes: AppRoutes.routesMap(),
    );
  }
}
