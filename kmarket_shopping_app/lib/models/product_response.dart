import 'package:kmarket_shopping/models/product.dart';

class ProductResponse {
  final List<Product> dtoList;
  final String category;
  final int total;

  ProductResponse({required this.dtoList, required this.category, required this.total});

  factory ProductResponse.fromJson(Map<String, dynamic> json){
    // Json 문자열을 Product List로 변환
    final dtoList = json['dtoList'] as List;
    List<Product> productList = dtoList.map((product) =>
        Product.fromJson(product)).toList();

    return ProductResponse(
      dtoList: productList,
      category: json['category'],
      total: json['total'],
    );
  }
}