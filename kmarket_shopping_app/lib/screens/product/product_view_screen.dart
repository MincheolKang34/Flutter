import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kmarket_shopping/models/cart.dart';
import 'package:kmarket_shopping/models/product.dart';
import 'package:kmarket_shopping/screens/config/app_config.dart';
import 'package:kmarket_shopping/screens/main/member/login_screen.dart';
import 'package:kmarket_shopping/screens/providers/auth_provider.dart';
import 'package:kmarket_shopping/services/cart_service.dart';
import 'package:provider/provider.dart';

class ProductViewScreen extends StatefulWidget {
  final Product product;

  const ProductViewScreen({super.key, required this.product});

  @override
  State<StatefulWidget> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  // 수량 상태
  int _quantity = 1;

  final cartService = CartService();

  // 장바구니 추가
  Future<void> _addCart() async {
    int pno = widget.product.pno;

    Map<String, dynamic> jsonData = await cartService.addCart(pno, _quantity);
    log('savedCart : $jsonData');
    // Cart savedCart = Cart.fromJson(jsonData);

    if(jsonData.isNotEmpty) {
      showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: const Text('장바구니 등록 성공!'),
            content: const Text('상품이 장바구니에 담겼습니다.'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: const Text('확인')
              )
            ],
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoggedIn = authProvider.isLoggedIn; // 로그인 상태 가져오기

    // ProductViewScreen 속성 product 참조
    final product = widget.product;

    final finalPrice = product.price * (1 - product.discount / 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRect(
              child: Image.network(
                width: double.infinity,
                '${AppConfig.baseUrl}/product/image/${product.thumb240}',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 13,),
            Text(product.productName, style: TextStyle(fontSize: 24),),
            const SizedBox(height: 13,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('원가 : ${product.price}원', style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough // 취소선
                    ),),
                    Text('할인율 : ${product.discount}%', style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                    ),),
                  ],
                ),
                Text(
                  '${finalPrice.toInt()}원',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Text(
                  '수량 선택 : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                  value: _quantity,
                  items: List.generate(10, (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1}개'),
                    )
                  ),
                  onChanged: (value) {
                    setState(() {
                      _quantity = value!;
                    });
                  }
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (isLoggedIn) {
                        _addCart();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('로그인이 필요합니다.'),
                              content: const Text('장바구니에 상품을 담으려면 로그인이 필요합니다. 로그인 화면으로 이동하시겠습니까?'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context), // 닫기
                                    child: const Text('취소')
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // 닫기
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginScreen()
                                          )
                                      );
                                    },
                                  child: const Text('로그인으로 이동')
                                ),
                              ],
                            )
                        );
                      }
                    },
                    label: const Text('장바구니'),
                    icon: Icon(Icons.shopping_cart),
                  )
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text('구매하기'),
                    icon: Icon(Icons.payment),
                  )
                ),
              ],
            ),
            const Text(
                '상품 상세 설명',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10,),
            Image.network('${AppConfig.baseUrl}/product/image/${product.thumb750}')
          ],
        ),
      )
    );
  }
}