import 'package:flutter/material.dart';
import 'package:kmarket_shopping/screens/providers/auth_provider.dart';
import 'package:kmarket_shopping/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    // 최초 앱을 실행할 때 AuthProvider로 로그인 여부 체크
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    )
  );
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