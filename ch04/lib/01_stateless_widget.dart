/*
  날짜 : 2025.10.27.
  이름 : 강민철
  내용 : Stateless 정적 위젯 실습
 */
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('01.Stateless 위젯 실습'),
        ),
        body: StatelessTest(),
      ),
    );
  }
}

class StatelessTest extends StatelessWidget { // StatelessWidget은 상태(속성)가 변경 되어도 화면이 다시 갱신되지 않음
  StatelessTest({super.key});

  // 속성이 변경 되더라도 해당 속성을 참조하는 Text 위젯은 재빌드 되지 않음
  int counter = 0;

  void _increment(){
    counter++;
    print('counter : $counter');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('카운터 : $counter', style: TextStyle(fontSize: 24),),
        ElevatedButton(
            onPressed: _increment,
            child: const Text('카운트')
        )
      ],
    );
  }
}