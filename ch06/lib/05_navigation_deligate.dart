import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// 라우트 경로 상태를 나타내는 클래스
// 라우트 정보(path, 선택적 id)를 담는 불변(immutable) 객체
class AppRoutePath {
  final String path;
  final int? id;

  AppRoutePath(this.path, {this.id});
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // RouterDelegate: 라우트 경로 상태를 바탕으로 위젯 트리를 구성
  final MyRouterDelegate _routerDelegate = MyRouterDelegate();
  // RouteInformationParser: 시스템 라우트 정보(URL 등)를 AppRoutePath로 변환
  final MyRouteInformationParser _routeInformationParser = MyRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router: Navigator 2.0을 사용하여 앱을 구성
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

// RouteInformationParser 구현:
// RouteInformation을 AppRoutePath 객체로 변환
class MyRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    // 현재는 모든 시스템 라우트 정보를 '/home' 경로로 설정
    // 실제 앱에서는 routeInformation.location을 파싱하여 동적으로 경로를 결정
    return AppRoutePath('/home');
  }
}

// RouterDelegate 구현:
// 앱의 현재 상태(_currentPath)를 관리하고, 이 상태에 따라 Navigator의 pages 리스트를 구성
class MyRouterDelegate extends RouterDelegate<AppRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  // Navigator 위젯의 key를 저장 PopNavigatorRouterDelegateMixin에 필요
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 현재 라우트 경로 상태를 저장 초기값은 '/home'입니다.
  AppRoutePath _currentPath = AppRoutePath('/home');

  @override
  Widget build(BuildContext context) {
    // 현재 _currentPath 상태에 따라 Navigator의 pages 리스트를 선언적으로 구성
    // 여기서는 단일 페이지 라우팅 모델(페이지 스택이 아닌 단일 페이지 전환)로 동작하도록 구현
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_currentPath.path == '/home')
          MaterialPage(child: HomeScreen())
        else if (_currentPath.path == '/detail')
        // Detail 페이지의 경우 AppRoutePath에 담긴 id를 전달
          MaterialPage(child: DetailScreen(id: _currentPath.id))
        else if (_currentPath.path == '/about')
            MaterialPage(child: AboutScreen()),
      ],
      // Pop 처리는 PopNavigatorRouterDelegateMixin이 처리
      // 최신 API: onDidRemovePage 사용
      onDidRemovePage: (route) {
        // 뒤로가기 시 홈 경로로 돌아가기
        _currentPath = AppRoutePath('/home');
        notifyListeners();
      },
    );
  }

  // RouterDelegate의 현재 경로 상태를 반환
  @override
  AppRoutePath get currentConfiguration => _currentPath;

  @override
  // 시스템 라우트 정보(ex: 브라우저 주소 변경)에 의해 새로운 경로가 들어올 때 호출
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _currentPath = configuration;
    // 상태 변경을 알리지 않아도, Navigator 2.0은 RouteInformationParser와 연동되어 내부적으로 build가 다시 호출
  }

  // 009. 앱 내부에서 페이지 이동을 요청하는 커스텀 메서드 (push/replace 역할).
  // 상태(_currentPath)를 변경하고 notifyListeners()를 호출하여 RouterDelegate의 build 메서드를 다시 실행
  void pushPath(AppRoutePath path) {
    _currentPath = path;
    notifyListeners(); // 상태 변경을 알려 UI를 업데이트
  }
}

// 010. HomeScreen (라우팅 테스트를 위한 위젯)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Router.of(context).routerDelegate를 사용하여 MyRouterDelegate 인스턴스에 접근
    final delegate = Router.of(context).routerDelegate as MyRouterDelegate;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Go to Detail (id: 1)'),
              onPressed: () {
                // 커스텀 delegate를 사용하여 Detail 페이지로 이동을 요청
                delegate.pushPath(AppRoutePath('/detail', id: 1));
              },
            ),
            ElevatedButton(
              child: const Text('Go to About Page'),
              onPressed: () {
                // 커스텀 delegate를 사용하여 About 페이지로 이동을 요청
                delegate.pushPath(AppRoutePath('/about'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 011. DetailScreen (라우팅 테스트를 위한 위젯)
class DetailScreen extends StatelessWidget {
  final int? id;
  const DetailScreen({this.id});

  @override
  Widget build(BuildContext context) {
    final delegate = Router.of(context).routerDelegate as MyRouterDelegate;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detail Page (id: $id)'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go Back'),
              // 단일 페이지 모델이므로, 'Go Back'은 명시적으로 'Home' 경로로 상태를 변경하는 것으로 처리
              onPressed: () => delegate.pushPath(AppRoutePath('/home')),
            ),
          ],
        ),
      ),
    );
  }
}

// 012. AboutScreen (라우팅 테스트를 위한 위젯)
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final delegate = Router.of(context).routerDelegate as MyRouterDelegate;
    return Scaffold(
      appBar: AppBar(title: const Text('About Page')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go Back'),
          // 단일 페이지 모델이므로, 'Go Back'은 명시적으로 'Home' 경로로 상태를 변경하는 것으로 처리
          onPressed: () => delegate.pushPath(AppRoutePath('/home')),
        ),
      ),
    );
  }
}