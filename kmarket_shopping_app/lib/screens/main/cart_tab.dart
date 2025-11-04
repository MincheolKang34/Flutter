import 'package:flutter/material.dart';
import 'package:kmarket_shopping/models/cart.dart';
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

    return jsonData
        .map((json) => Cart.fromJson(json))
        .toList();
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
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
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

          return ListView.builder(
            itemCount: listCart.length,
            itemBuilder: (context, index) {

              final cart = listCart[index];

              return Card(
                child: Text('cart : ${cart.cartId}'),
              );
            }
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // 아래 Consumer 위젯으로 처리
    // final authProvider = Provider.of<AuthProvider>(context);
    // bool isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
        appBar: AppBar(title: const Text('장바구니'),),
        body: Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return provider.isLoggedIn ? _buildCartList() : _buildLoginRequired();
            }
        )
    );
  }
}