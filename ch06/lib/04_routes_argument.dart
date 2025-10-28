/*
  날짜 : 2045.10.28.
  이름 : 강민철
  내용 : 6장 네비게이션 Routes 실습
 */

import 'package:flutter/material.dart';

class User {
  String userid;
  String name;
  int age;

  User({required this.userid, required this.name, required this.age});

  @override
  String toString() {
    return 'User{userid: $userid, name: $name, age: $age}';
  }
}

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
        '/first': (context)=> FirstScreen(),
        '/second': (context)=> const SecondScreen(),
      },
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _useridController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String savedUser = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('04.Routes Argument 실습'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('First Screen', style: TextStyle(fontSize: 36),),
          TextField(
            controller: _useridController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '아이디 입력'
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이름 입력'
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: _ageController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '나이 입력'
            ),
          ),
          const SizedBox(height: 10,),
          Text('savedUser : $savedUser'),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () async {
                String userid = _useridController.text;
                String name = _nameController.text;
                int age = int.tryParse(_ageController.text) ?? 0;

                final user = User(
                  userid: userid,
                  name: name,
                  age: age
                );

                // Second Screen 이동, 라우터 경로 이동
                final returnedUser = await Navigator.pushNamed(context, '/second', arguments: {'user': user});
                setState(() {
                  savedUser = returnedUser.toString();
                });
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

    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final User receivedUser = arguments['user'] as User;

    return Scaffold(
      appBar: AppBar(title: const Text('04.Routes Argument실습'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Second Screen', style: TextStyle(fontSize: 36),),
          const SizedBox(height: 10,),
          Text('아이디: ${receivedUser.userid}, 이름: ${receivedUser.name}, 나이 : ${receivedUser.age}', style: TextStyle(fontSize: 26),),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                // 현재 화면 위젯 스택 제거, 뒤로가기
                Navigator.pop(context, receivedUser);
              },
              child: const Text('First Screen 이동')
          ),
        ],
      ),
    );
  }
}