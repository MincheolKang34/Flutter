import 'package:flutter/material.dart';
import 'package:kmarket_shopping/screens/main/member/login_screen.dart';
import 'package:kmarket_shopping/screens/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MyTab extends StatefulWidget {
  const MyTab({super.key});

  @override
  State<StatefulWidget> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  // 로그인 화면 디자인 함수
  Widget _buildLogin() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('로그인이 필요합니다.'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => LoginScreen())
              );
            },
            child: const Text('로그인 이동'),
          ),
        ],
      ),
    );
  }


  // 로그인 후 사용자 정보 화면 디자인 함수
  Widget _buildLoggedIn() {
    return SingleChildScrollView( // 자식 위젯이 화면 크기를 초과할 경우 스크롤 가능한 위젯
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('환영합니다, 고객님!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('현재 포인트: 1000P', style: const TextStyle(fontSize: 18, color: Colors.blue)),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // 로그아웃 처리
                    context.read<AuthProvider>().logout();
                  },
                  child: const Text('로그아웃'),
                )
              ],
            ),

            const Divider(height: 30),
            _buildInfoTile('주문내역', '총 0건'),
            _buildInfoTile('배송내역', '총 0건'),
            _buildInfoTile('관심상품', '15개'),
            const Divider(height: 30),

          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value),
      onTap: () {
        // 해당 내역 화면으로 이동 로직
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider 구독
    final authProvider = Provider.of<AuthProvider>(context);
    bool isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
        appBar: AppBar(title: const Text('마이페이지'),),
        body: isLoggedIn ? _buildLoggedIn() : _buildLogin()
    );
  }
}