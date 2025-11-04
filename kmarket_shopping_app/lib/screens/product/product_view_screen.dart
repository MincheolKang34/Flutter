import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kmarket_shopping/models/cart.dart';
import 'package:kmarket_shopping/models/product.dart';
import 'package:kmarket_shopping/screens/config/app_config.dart';
import 'package:kmarket_shopping/services/cart_service.dart';

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

  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: _addCart,
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