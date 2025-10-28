/*
  날짜 : 2025.10.28.
  이름 : 강민철
  내용 : 6장 Flutter 네비게이션 기본 실습
 */

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('01.Flutter 네비게이션 기본 실습'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('First Screen', style: TextStyle(fontSize: 36),),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                // Second Screen 이동
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SecondScreen())
                );
              },
              child: const Text('Second Screen 이동')
          )
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('01.Flutter 네비게이션 기본 실습'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Second Screen', style: TextStyle(fontSize: 36),),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                // 현재 화면 위젯 스택 제거, 뒤로가기
                Navigator.pop(context);
              },
              child: const Text('First Screen 이동')
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ThirdScreen())
                );
              },
              child: const Text('Third Screen 이동')
          ),
        ],
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('01.Flutter 네비게이션 기본 실습'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Third Screen', style: TextStyle(fontSize: 36),),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                // 현재 화면 위젯 스택 제거, 뒤로가기
                Navigator.pop(context);
              },
              child: const Text('Second Screen 이동')
          )
        ],
      ),
    );
  }
}