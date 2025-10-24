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
      home: const MyHomePage(title: '10.인디케이터 위젯 실습'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Text('원형 인디케이터'),
            SizedBox(height: 50),
            CircularProgressIndicator(),
            SizedBox(height: 50),
            CircularProgressIndicator(
              strokeWidth: 10,
              valueColor: AlwaysStoppedAnimation(Colors.red),
              value: 0.5, // 진행률(없으면 무한 회전)
            ),
            SizedBox(height: 50),
            Text('선형 인디케이터'),
            SizedBox(height: 50),
            LinearProgressIndicator(),
            SizedBox(height: 50),
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey,
              color: Colors.blue,
              minHeight: 10,
            ),

          ],
        )
    );
  }
}