import 'dart:convert';
import 'dart:developer';

import 'package:ch07/user1/user1.dart';
import 'package:http/http.dart' as http;

class User1Service {
  // Flutter 에뮬레이터에서 localhost는 자기자신이기 때문에 에뮬레이터 외부 아이피 주소 사용
  static const String baseUrl = 'http://10.0.2.2:8080/ch08';

  Future<List<User1>> getUsers() async {
    try{
      log('getUsers...1');
      final response = await http.get(Uri.parse('$baseUrl/user1'));
      log('getUsers...2 : $response');

      if(response.statusCode == 200){
        List<dynamic> jsonList = jsonDecode(response.body);
        log('getUsers...3 : $jsonList');

        return jsonList.map((json)=> User1.fromJson(json)).toList();
      }else {
        throw Exception('에러 발생 코드 : ${response.statusCode}');
      }
    }catch (err){
      throw Exception('예외 발생 : $err');
    }
  }

  Future<User1> getUser(String userid) async {
    try{
      final response = await http.get(Uri.parse('$baseUrl/user1/$userid'));
      if(response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        return User1.fromJson(json);
      }else {
        throw Exception('에러 발생 코드 : ${response.statusCode}');
      }
    }catch (err){
      throw Exception('예외 발생 : $err');
    }
  }

  Future<User1> postUser(User1 user) async {
    log('post start.');
    try{
      log('posting...');
      final response = await http.post(
        Uri.parse('$baseUrl/user1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson())
      );

      log('post success check');
      if(response.statusCode == 201){
        return User1.fromJson(jsonDecode(response.body));
      }else {
        throw Exception('에러 발생 코드 : ${response.statusCode}');
      }
    }catch (err){
      throw Exception('에러발생 : $err');
    }
  }

  Future<User1> putUser(User1 user) async {
      try{
        log('getUsers...1');
        final response = await http.put(Uri.parse('$baseUrl/user1'),
        headers: {'Content-Type': 'application/json'},
          body: json.encode(user.toJson()),
        );
        log('getUsers...2 : ${response.statusCode}');

        if(response.statusCode == 200){
          dynamic json = jsonDecode(response.body);
          log('getUsers...3 : $json');

          return User1.fromJson(json);
        }else {
          throw Exception('에러 발생 코드 : ${response.statusCode}');
        }
      }catch (err){
        throw Exception('예외 발생 : $err');
      }
  }

  Future<void> deleteUser(String userid) async {
    try{
      final response = await http.delete(Uri.parse('$baseUrl/user1/$userid'));

      if(response.statusCode != 200){
        throw Exception('사용자 삭제에 실패했습니다.');
      }
    }catch (err){
      throw Exception('네트워크 에러 : $err');
    }
  }
}