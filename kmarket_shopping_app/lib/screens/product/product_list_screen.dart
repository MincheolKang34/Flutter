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

  // 무한 스크롤 상태변수
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  
  final ScrollController _scrollController = ScrollController();

  final service = ProductService();

  late Future<ProductResponse> _initProductFuture;

  @override
  void initState() {
    super.initState();

    // 화면 빌드하기 전에 상품 목록 데이터 가져오기
    _initProductFuture = _loadInitialProducts();
    
    // 스크롤 위치 감지 리스너 등록
    _scrollController.addListener((){
      // 현재 스크롤 위치가 최대 스크롤 범위에 가까워졌을 때
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
        if (!_isLoading && _hasMore) {
          // 다음 상품 목록 불러오기
          _loadMoreProducts();
        }
      }
    });
  }

  Future<ProductResponse> _loadInitialProducts() async {
    final jsonData = await service.fetchProductList(widget.categoryNum, _page);
    final productResponse = ProductResponse.fromJson(jsonData);

    setState(() {
      _productList.addAll(productResponse.dtoList);
      // 다음 상품 페이지 번호
      _page = 2;

      // 현재 상품 갯수와 총 상품 갯수를 비교해서 총 상품 갯수 보다 크면 더 이상 가져올 데이터 없음
      if(_productList.length >= productResponse.total) {
        _hasMore = false;
      }
    });

    return productResponse;
  }

  Future<void> _loadMoreProducts() async {
    // 상품 로드 시작
    setState(() {
      _isLoading = true;
    });

    final jsonData = await service.fetchProductList(widget.categoryNum, _page);
    final productResponse = ProductResponse.fromJson(jsonData);

    if(productResponse.dtoList.isNotEmpty) {
      setState(() {
        // 리스트뷰 상품 목록 추가
        _productList.addAll(productResponse.dtoList);

        // 다음 상품 페이지
        _page++;

        // 현재 상품 갯수와 총 상품 갯수를 비교해서 총 상품 갯수 보다 크면 더 이상 가져올 데이터 없음
        if(_productList.length >= productResponse.total) {
          _hasMore = false;
        }
      });
    } else {
      // 빈목록이 들어오면 더 이상 상품 없음
      setState(() {
        _hasMore = false;
      });
    }

    // 상품 불러오기 끝
    setState(() {
      _isLoading = false;
    });
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
              controller: _scrollController, // 리스트뷰 스크롤 컨트롤러
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