import 'package:flutter/material.dart';
import 'package:kmarket_shopping/screens/main/main_tab_screen.dart';
import 'package:kmarket_shopping/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen()
      //   home: MainTabScreen()
    );
  }
}