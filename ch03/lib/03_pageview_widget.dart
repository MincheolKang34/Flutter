/*
  날짜 : 2025.10.27.
  이름 : 강민철
  내용 : PageView 위젯 실습하기
 */

import 'package:flutter/material.dart';

void main() {
  // runApp(PageViewTest1());
  runApp(PageViewTest2());
}

class PageViewTest1 extends StatelessWidget {
  const PageViewTest1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('03.PageView 위젯 실습'),
        ),
        body: PageView(
          children: [
            Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text('페이지 1',
              style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              color: Colors.green,
              alignment: Alignment.center,
              child: const Text('페이지 2',
              style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text('페이지 3',
              style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

// StatefulWidget 정의 클래스
class PageViewTest2 extends StatefulWidget {
  const PageViewTest2({super.key});

  @override
  State<PageViewTest2> createState() {
    // TODO: implement createState
    return _PageViewTest2State();
  }
}

class _PageViewTest2State extends State<PageViewTest2> {

  // PageView Controller 설정
  final PageController _pageController = PageController(
    initialPage:  0 // 시작 페이지 인덱스
  );

  // 상태(위젯 클래스의 속성) 선언
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('03.Stateful PageView 위젯 실습'),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index){
            // 상태 변경 함수를 호출해서 화면 다시 갱신
            setState(() {
              _currentPage = index;
            });
            print(_currentPage);
          },
          children: [
            Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: Text('페이지 1\n현재 인덱스 $_currentPage',
                style: const TextStyle(fontSize: 30),
              ),
            ),
            Container(
              color: Colors.green,
              alignment: Alignment.center,
              child: Text('페이지 2\n현재 인덱스 $_currentPage',
                style: const TextStyle(fontSize: 30),
              ),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text('페이지 3\n현재 인덱스 $_currentPage',
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

}