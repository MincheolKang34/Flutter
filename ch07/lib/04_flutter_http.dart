/*
  날짜 : 2025.10.29.
  이름 : 강민철
  내용 : Flutter HTTP 통신 실습
 */

import 'dart:convert';

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
        appBar: AppBar(title: const Text('04.Flutter HTTP 통신 실습'),),
        body: HttpScreen(),
      ),
    );
  }
}

class HttpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HttpScreenState();
}

class _HttpScreenState extends State<HttpScreen> {
  String result = '결과...';

  Future<void> fetchGet(){
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');

    // http 의존성 추가 : pub.dev 검색 > http: ^1.5.0 추가
    return http.get(url, headers: {'Content-Type': 'application/json'}).then((response){
        if(response.statusCode == 200){
          var jsonResult = jsonDecode(response.body);

          setState(() {
            result = 'Get 요청 결과 : $jsonResult';
          });
        }else {
          setState(() {
            result = 'Get 결과 코드 : ${response.statusCode}';
          });
        }
      }).catchError((err){
        setState(() {
          result = '에러발생 : $err';
        });
      }).whenComplete((){
        print('통신 완료...');
      }
    );
  }

  Future<void> fetchPost() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

    try {
      final response = await http.post(url,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({
            "userId": 1001,
            "title": "Flutter HTTP Post 테스트",
            "complete": false
          })
      );

      if(response.statusCode == 201){
        final returnedData = jsonDecode(response.body);
        setState(() {
          result = 'POST 요청 성공 : $returnedData';
        });
      }else {
        setState(() {
          result = 'POST 결과 코드 : ${response.statusCode}';
        });
      }
    }catch (err) {
      result = 'POST 요청 에러 : $err';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('요청 결과 : $result'),
          Row(
            children: [
              ElevatedButton(
                  onPressed: fetchGet,
                  child: const Text('GET 요청하기')
              ),
              ElevatedButton(
                  onPressed: fetchPost,
                  child: const Text('POST 요청하기')
              ),
            ],
          )
        ],
      ),
    );
  }
}