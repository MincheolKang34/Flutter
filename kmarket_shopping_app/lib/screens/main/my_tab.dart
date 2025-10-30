import 'package:flutter/material.dart';

class MyTab extends StatefulWidget {
  const MyTab({super.key});

  @override
  State<StatefulWidget> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지'),),
      body: Column(
        children: [
          Text('마이페이지 메인')
        ],
      ),
    );
  }
}