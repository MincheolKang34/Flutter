/*
  날짜 : 2025.10.27.
  이름 : 강민철
  내용 : TabBar 위젯 실습하기
 */

import 'package:flutter/material.dart';

void main(){
  // runApp(TabBarTest());
  runApp(BottomTabBarTest());
}

class TabBarTest extends StatelessWidget {
  const TabBarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3, // 탭 갯수
          child: Scaffold(
            appBar: AppBar(
              title: const Text('04.TabBar 위젯 실습'),
              bottom: TabBar(tabs: [
                    Tab(icon: Icon(Icons.home), text: '홈',),
                    Tab(icon: Icon(Icons.star), text: '즐겨찾기',),
                    Tab(icon: Icon(Icons.person), text: '프로필',),
                  ]
              ),
            ),
            body: TabBarView(
                children: [
                  Center(child: Text('홈 화면', style: TextStyle(fontSize: 20),),),
                  Center(child: Text('즐겨찾기 화면', style: TextStyle(fontSize: 20),),),
                  Center(child: Text('프로필 화면', style: TextStyle(fontSize: 20),),),
                ]
            ),
          ),
      )
    );
  }
}

class BottomTabBarTest extends StatefulWidget {
  const BottomTabBarTest({super.key});

  @override
  State<BottomTabBarTest> createState() => _BottomTabBarTestState();
}

class _BottomTabBarTestState extends State<BottomTabBarTest> {
  int _selectedIndex = 0;

  // 탭 화면 리스트
  List<Widget> _widgetList = [
    Center(child: Text('홈 화면', style: TextStyle(fontSize: 20),),),
    Center(child: Text('즐겨찾기 화면', style: TextStyle(fontSize: 20),),),
    Center(child: Text('프로필 화면', style: TextStyle(fontSize: 20),),),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('04.Bottom TabBar 실습'),
        ),
        body: _widgetList.elementAt(_selectedIndex),

        // 탭바를 아래에 위치
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: '즐겨찾기'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
            ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: (index){
              setState(() {
                _selectedIndex = index;
              });
          },
        ),
      ),
    );
  }
}