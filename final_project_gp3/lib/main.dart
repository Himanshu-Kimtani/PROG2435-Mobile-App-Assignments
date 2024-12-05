import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'ListScreen.dart';
import 'DetailScreen.dart';
import 'MapScreen.dart';
import 'AboutScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Management App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/list': (context) => const ListScreen(),
        '/detail': (context) => const DetailScreen(),
        '/map': (context) => const MapScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
