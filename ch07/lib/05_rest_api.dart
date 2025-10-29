/*
  날짜 : 2025.10.29.
  이름 : 강민철
  내용 : Flutter REST API 실습
*/

import 'package:ch07/user1/user1_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('05.Flutter REST API 실습'),),
        body: RestApiScreen(),
      ),
    );
  }
}

class RestApiScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestApiScreenState();
}

class _RestApiScreenState extends State<RestApiScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          const Text('User1 Rest API 실습'),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => User1List()));
              },
              child: const Text('User1 목록')
          )
        ],
      ),
    );
  }
}