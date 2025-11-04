import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = "http://10.0.2.2:8080/ch09";

  Future<Map<String, dynamic>> fetchProductList(int category, int pg) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product?category=$category&page=$pg'));

      log('페이지 : $pg');
      if(response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        throw Exception(response.statusCode);
      }
    } catch(err) {
      throw Exception(err);
    }
  }
}