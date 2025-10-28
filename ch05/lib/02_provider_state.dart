/*
  날짜 : 2025.10.28.
  이름 : 강민철
  내용 : 5장 Flutter Provider 상태관리 실습
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider 정의(앱 공용 상태 저장소)
class CounterProvider extends ChangeNotifier {
  // 상태 선언
  int _count = 0;

  // 상태 값에 접근할 수 있는 Getter
  int get count => _count;

  void increment(){
    _count++;
    notifyListeners(); // 상태 변경 알림
  }

  void decrement(){
    _count--;
    notifyListeners(); // 상태 변경 알림
  }
}

void main() {
  runApp(
    // provider 의존성 설정 : pubspec.yaml > flutter: provider: ^6.1.5+1 추가(provider는 pub.dev에서 검색)
    ChangeNotifierProvider(
      create: (_) => CounterProvider(), // _ 매개변수는 context가 들어오지만 우리는 이 함수에서 사용하지 않겠다는 선언
      child: MyApp(), // MyApp 하위 위젯 트리에서 CounterProvider 접근
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('02.Provider 상태 관리 실습'),),
        body: ParentWidget(),
      ),
    );
  }
}

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  @override
  Widget build(BuildContext context) {
    // provider 모델 가져오기
    final countProvider = context.watch<CounterProvider>();

    return Column(
      children: [
        Text('Parent Provider count : ${countProvider._count}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  countProvider.increment();
                },
                child: const Text('증가')
            ),
            ElevatedButton(
                onPressed: (){
                  countProvider.decrement();
                },
                child: const Text('감소')
            ),
          ],
        )
      ],
    );
  }
}