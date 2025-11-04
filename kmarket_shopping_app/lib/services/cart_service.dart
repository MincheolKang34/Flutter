import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:kmarket_shopping/screens/config/app_config.dart';
import 'package:kmarket_shopping/services/token_storage_service.dart';

class CartService {
  final _tokenStorageService = TokenStorageService();

  Future<Map<String, dynamic>> addCart(int pno, int quantity) async {

    try {
      // JWT 가져오기
      final jwt = await _tokenStorageService.readToken();
      log('jwt : $jwt');

      // 전송 데이터 생성
      final jsonData = {
        "pno": pno,
        "quantity": quantity,
      };

      final response = await post(
        Uri.parse('${AppConfig.baseUrl}/cart'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        },
        body: jsonEncode(jsonData)
      );

      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(response.statusCode);
      }
    } catch(err) {
      throw Exception(err);
    }
  }

  Future<List<dynamic>> getCarts() async {
    try {
      // JWT 가져오기
      final jwt = await _tokenStorageService.readToken();
      log('jwt : $jwt');

      final response = await get(
          Uri.parse('${AppConfig.baseUrl}/cart'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $jwt"
          }
      );

      if(response.statusCode == 200) {
        // jsonDecode의 반환타입은 JSON 문자열이 [] 이면 List<dynamic>, {} 이면 Map<String, dynamic>으로 선언
        return jsonDecode(response.body);
      } else {
        throw Exception(response.statusCode);
      }
    } catch(err) {
      throw Exception(err);
    }
  }
}