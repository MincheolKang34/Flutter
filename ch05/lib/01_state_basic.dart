/*
  날짜 : 2025.10.28.
  이름 : 강민철
  내용 : 5장 Flutter 상태관리 실습
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
        appBar: AppBar(title: const Text('01.상태 관리 기본'),),
        body: ParentStateApp(),
      ),
    );
  }
}

class ParentStateApp extends StatefulWidget {
  const ParentStateApp({super.key});

  @override
  State<StatefulWidget> createState() => _ParentStateAppState();
}

class _ParentStateAppState extends State<ParentStateApp> {

  // 상태 속성
  int _count = 0;
  String _text = '';

  // 자식 위젯에서 사용할 상태 속성
  bool _favorited = false;
  int _favoriteCount = 0;

  void toggleFavorite(){
    setState(() {
      if (_favorited) {
        _favorited = false;
        _favoriteCount -= 1;
      }else{
        _favorited = true;
        _favoriteCount += 1;
      }
    });
  }

  void increment(){
    // 위젯 상태를 업데이트 하고 UI 재빌드(build 호출)
    setState(() {
      _count++;
    });
    print('_count : $_count');
  }

  void changeText(String newText){
    // 위젯 상태를 업데이트 하고 UI 재빌드(build 호출)
    setState(() {
      _text = newText;
    });
    print('_text : $_text');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Count : $_count'),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: increment,
                child: const Text('증가')
            ),
            Divider(),
            Text(_text),
            const SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '아무거나 입력'
              ),
              onChanged: (value){
                changeText(value);
              },
            ),
            Divider(),
            IconWidget(favorited: _favorited, toggleFunction: toggleFavorite,),
            ContentWidget(favoriteCount: _favoriteCount,)
          ],
        ),
    );
  }
}

class IconWidget extends StatelessWidget {
  final bool favorited;
  final Function toggleFunction;

  const IconWidget({super.key, this.favorited = false, required this.toggleFunction});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: (){
          toggleFunction();
        },
        icon: (favorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
        iconSize: 100,
        color: Colors.red,
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final int favoriteCount;

  const ContentWidget({super.key, required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'favoriteCount : $favoriteCount',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}