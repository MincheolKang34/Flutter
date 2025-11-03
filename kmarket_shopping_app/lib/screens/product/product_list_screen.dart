import 'package:flutter/material.dart';
import 'package:kmarket_shopping/models/product.dart';
import 'package:kmarket_shopping/models/product_response.dart';
import 'package:kmarket_shopping/screens/product/product_list_item.dart';
import 'package:kmarket_shopping/services/product_service.dart';

/*
  샘플 데이터 넣기
  insert into product (delivery, discount, etc, point, price, productname, stock, thumb120, thumb240, thumb750, category)
  select delivery, discount, etc, point, price, productname, stock, thumb120, thumb240, thumb750, category from product;
 */

class ProductListScreen extends StatefulWidget {
  final int categoryNum;
  final String categoryName;


  ProductListScreen({super.key, required this.categoryNum, required this.categoryName});

  @override
  State<StatefulWidget> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _productList = [];

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  final service = ProductService();

  late Future<ProductResponse> _initProductFuture;

  @override
  void initState() {
    super.initState();

    // 화면 빌드하기 전에 상품 목록 데이터 가져오기
    _initProductFuture = _loadInitialProducts();
  }

  Future<ProductResponse> _loadInitialProducts() async {
    final jsonData = await service.fetchProductList(widget.categoryNum, _page);
    final productResponse = ProductResponse.fromJson(jsonData);

    setState(() {
      _productList.addAll(productResponse.dtoList);
    });

    return productResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.categoryName}(${widget.categoryNum}) 상품 목록'),),
      body: FutureBuilder(
          future: _initProductFuture, // Future 비동기 처리 결과 참조
          builder: (builder, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }

            if (snapshot.hasError) {
              return Center(child: Text('에러 발생 : ${snapshot.error}'),);
            }

            if(_productList.isEmpty) {
              return const Center(child: Text('상품이 없습니다.'),);
            }

            return ListView.builder(
              itemCount: _productList.length,
              itemBuilder: (context, index) {
                final product = _productList[index];
                return ProductListItem(product: product);
              }
            );
          }
      )
    );
  }
}