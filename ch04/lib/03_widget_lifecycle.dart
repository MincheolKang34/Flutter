/*
  날짜 : 2025.10.27.
  이름 : 강민철
  내용 : State 생명주기 실습
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
          title: const Text('03.상태 생명주기 실습'),
        ),
        body: ParentWidget(),
      ),
    );
  }
}

class ParentWidget extends StatefulWidget {
  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> { // StatelessWidget은 상태(속성)가 변경 되어도 화면이 다시 갱신되지 않음

  // 상태
  int counter = 0;
  bool showChild = true;

  void _increment(){
    // 상태를 업데이트 하고, build를 재호출
    setState(() {
      counter++;
    });

    // showChild = counter % 2 == 0;
  }

  void _toggleChild(){
    setState(() {
      showChild = !showChild;
    });
  }

  @override
  Widget build(BuildContext context) {

    print('build...');
    
    return Column(
      children: [
        showChild
            ? ChildWidget(count : counter)
            : Text('ChildWidget 제거', style: TextStyle(fontSize: 26),),
        ElevatedButton(
            onPressed: _increment,
            child: const Text('ChildWidget 상태 변경')
        ),
        ElevatedButton(
            onPressed: _toggleChild,
            child: const Text('ChildWidget 생성/제거')
        )
      ],
    );
  }
}

// ChildWidget 선언 클래스
class ChildWidget extends StatefulWidget {
  ChildWidget({super.key, required this.count});

  int count;

  @override
  State<StatefulWidget> createState() {
    print('createState...');
    return _ChildWidgetState();
  }
}

// ChildWidget 구현 클래스
class _ChildWidgetState extends State<ChildWidget> {
  @override
  void initState() {
    // 위젯이 처음 트리에 삽입될 때 한 번만 호출
    print('initState...');
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies...');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.all(10),
      color: Colors.blue,
      child: Text(
        'ChildWidget count : ${widget.count}',
        style: TextStyle(fontSize: 26),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    // 부모 위젯이 새 데이터와 함께 위젯을 rebuild 할 때 호출
    print('didUpdateWidget... old=${oldWidget.count}, new=${widget.count}');
  }

  @override
  void dispose() {
    // 해당 위젯이 위젯 트리에서 제거될 때 호출
    print('dispose...');
    // 리소스 정리를 위해 super.dispose()를 호출해야 함.
    // 생명주기 함수에서는 super를 호출해주는 것이 권장됨.
    super.dispose();
  }
}