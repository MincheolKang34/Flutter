import 'package:flutter/material.dart';
import 'package:kmarket_shopping/models/cart.dart';
import 'package:kmarket_shopping/screens/config/app_config.dart';
import 'package:kmarket_shopping/screens/main/member/login_screen.dart';
import 'package:kmarket_shopping/screens/providers/auth_provider.dart';
import 'package:kmarket_shopping/services/cart_service.dart';
import 'package:provider/provider.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<StatefulWidget> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  late Future<List<Cart>> _futureListCart;

  final cartService = CartService();

  @override
  void initState() {
    super.initState();
    _futureListCart = _loadCartList();
  }

  Future<List<Cart>> _loadCartList() async {
    final jsonData = await cartService.getCarts();

    return jsonData.map((json) => Cart.fromJson(json)).toList();
  }

  // 로그인 안 했을 때 화면
  Widget _buildLoginRequired() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('장바구니는 로그인 후 이용 가능합니다.'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // 로그인 화면으로 이동
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => LoginScreen()));
            },
            child: const Text('로그인 하러 가기'),
          ),
        ],
      ),
    );
  }

  // 로그인 했을 때 화면
  Widget _buildCartList() {
    return FutureBuilder<List<Cart>>(
      future: _futureListCart,
      builder: (context, snapshot) {
        final listCart = snapshot.data ?? [];

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listCart.length,
                itemBuilder: (context, index) {
                  final cart = listCart[index];
                  final product = cart.product;

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: Image.network(
                          '${AppConfig.baseUrl}/product/image/${product.thumb120}',
                        ),
                      ),
                      title: Text('${product.productName}'),
                      subtitle: Text('상품번호: ${product.pno}\n수량: ${cart.quantity}개\n가격: ${product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () async {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('상품번호 ${product.pno} 삭제됨')),
                          // );

                          final result = await cartService.deleteCarts(cart.cartId!);

                          if(result) {
                            setState(() {
                              _futureListCart = _loadCartList();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('상품번호 ${product.pno} 삭제됨'))
                            );
                          }
                          // TODO: 실제 삭제 API 연동 필요
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            // 하단 결제 영역
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('총 결제 금액:', style: TextStyle(fontSize: 18)),
                      Text(
                        '360000원',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('주문하기 화면으로 이동합니다.')),
                        );
                      },
                      child: const Text(
                        '주문하기',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 아래 Consumer 위젯으로 처리
    // final authProvider = Provider.of<AuthProvider>(context);
    // bool isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
      appBar: AppBar(title: const Text('장바구니')),
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return provider.isLoggedIn ? _buildCartList() : _buildLoginRequired();
        },
      ),
    );
  }
}
