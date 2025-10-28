/*
  날짜 : 2025.10.28.
  이름 : 강민철
  내용 : 5장 MultiProvider 상태관리 실습
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1.날짜시간 프로바이더
class ClockProvider extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;

  ClockProvider(){
    Timer.periodic(const Duration(seconds: 1), (timer){
      _dateTime = DateTime.now();
      notifyListeners();
    });
  }
}

// 2.카운터 프로바이더
class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment(){
    _count++;
    notifyListeners();
  }
}

// 3.장바구니 프로바이더
class CartProvider extends ChangeNotifier {
  List<String> _products = [];

  List<String> get products => _products;
  int get productCount => _products.length;

  void add(String product){
    _products.add(product);
    notifyListeners();
  }

  void remove(String product){
    _products.remove(product);
    notifyListeners();
  }

  void clear(){
    _products.clear();
    notifyListeners();
  }
}

void main() {
  runApp(
    // 하나 이상의 프로바이더 등록 설정
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClockProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('03.MultiProvider 상태 관리 실습'),),
        body: ParentWidget(),
      ),
    );
  }
}

class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 프로바이더 구독
    final clockProvider = context.watch<ClockProvider>();
    final counterProvider = Provider.of<CounterProvider>(context, listen: true);
    final cartProvider = context.watch<CartProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('현재시간'),
        Text('${clockProvider.dateTime.hour}:${clockProvider.dateTime.minute}:${clockProvider.dateTime.second}'),
        const Divider(),
        const Text('카운트'),
        Text('CounterProvider count : ${counterProvider.count}'),
        ElevatedButton(
            onPressed: counterProvider.increment,
            child: const Text('증가')
        ),
        const Divider(),
        const Text('장바구니 상품 갯수'),
        Text('장바구니 상품 갯수: ${cartProvider.productCount}'),
        Text('장바구니 상품 목록: ${cartProvider.products}'),
        Row(
          children: [
            ElevatedButton(
                onPressed: (){
                  cartProvider.add('상품-${cartProvider.productCount + 1}');
                },
                child: const Text('상품 추가')
            ),
            ElevatedButton(
                onPressed: (){
                  cartProvider.remove('상품-${cartProvider.productCount}');
                },
                child: const Text('상품 제거')
            ),
            ElevatedButton(
                onPressed: (){
                  cartProvider.clear();
                },
                child: const Text('상품 삭제')
            ),
          ],
        )
      ],
    );
  }
}