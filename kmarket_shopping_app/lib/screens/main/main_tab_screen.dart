import 'package:flutter/material.dart';
import 'package:kmarket_shopping/screens/main/cart_tab.dart';
import 'package:kmarket_shopping/screens/main/category_tab.dart';
import 'package:kmarket_shopping/screens/main/home_tab.dart';
import 'package:kmarket_shopping/screens/main/my_tab.dart';
import 'package:kmarket_shopping/screens/main/search_tab.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>{

  int _selectedIndex = 0;

  void _onTabHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 5개 탭 화면 리스트
  late final List<Widget> _widgetList = [
    HomeTab(onTabSwitch: _onTabHandler,),
    CategoryTab(),
    SearchTab(),
    MyTab(),
    CartTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kmarket 메인'),),
      body: Center(
          child: _widgetList.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: '카테고리'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '장바구니'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabHandler,
      ),
    );
  }
}