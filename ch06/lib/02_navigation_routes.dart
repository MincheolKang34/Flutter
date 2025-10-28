/*
  날짜 : 2025.10.28.
  이름 : 강민철
  내용 : 6장 Flutter 네비게이션 Routes 실습
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
      // 앱이 처음 시작할 때 보여지는 화면 경로
      initialRoute: '/first',
      
      // 전체 화면 경로 설정 및 위젯 맵핑
      routes: {
        '/first': (context)=> const FirstScreen(),
        '/second': (context)=> const SecondScreen(),
        '/third': (context)=> const ThirdScreen(),
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('02.Flutter 네비게이션 Routes 실습'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('First Screen', style: TextStyle(fontSize: 36),),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                // Second Screen 이동, 라우터 경로 이동
                Navigator.pushNamed(context, '/second');
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
      appBar: AppBar(title: const Text('02.Flutter 네비게이션 Routes 실습'),),
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
                Navigator.pushNamed(context, '/third');
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
      appBar: AppBar(title: const Text('02.Flutter 네비게이션 Routes 실습'),),
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