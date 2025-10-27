/*
  날짜 : 2025.10.27.
  이름 : 강민철
  내용 : Widget Key 실습
 */

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('04.위젯키 실습'),),
        body: WidgetKeyTest(),
      ),
    );
  }
}

class WidgetKeyTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WidgetKeyTestState();
}

class _WidgetKeyTestState extends State<WidgetKeyTest> {
  bool _swap = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: (){
              setState(() {
                _swap = !_swap;
              });
            },
            child: const Text('순서 바꾸기')
        ),
        Row(
          children: _swap
          ? [
            CounterBox(key: ValueKey(101), color: Colors.red),
            CounterBox(key: ValueKey(201), color: Colors.blue)
          ]
          : [
            CounterBox(key: ValueKey(201), color: Colors.blue),
            CounterBox(key: ValueKey(101), color: Colors.red)
          ],
        )
      ],
    );
  }
}


class CounterBox extends StatefulWidget {
  final Color color;

  const CounterBox({super.key, required this.color});

  @override
  State<StatefulWidget> createState() => _CounterBoxState();
}

class _CounterBoxState extends State<CounterBox> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _count++;
        });
      },
      child: Container(
        width: 200,
        height: 200,
        color: widget.color,
        child: Center(
          child: Text(
            '_count : $_count',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

}