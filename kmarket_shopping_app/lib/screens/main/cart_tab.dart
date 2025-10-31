import 'package:flutter/material.dart';
import 'package:kmarket_shopping/screens/main/member/login_screen.dart';
import 'package:kmarket_shopping/screens/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<StatefulWidget> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  Widget _buildLogin() {
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

  Widget _buildLoggedIn() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider 구독
    final authProvider = Provider.of<AuthProvider>(context);
    bool isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
        appBar: AppBar(title: const Text('장바구니'),),
        body: isLoggedIn ? _buildLoggedIn() : _buildLogin()
    );
  }
}