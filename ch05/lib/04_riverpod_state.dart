/*
  날짜 : 2025.10.28.
  이름 : 강민철
  내용 : 5장 MultiProvider 상태관리 실습
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/*
  Riverpod 의존성 설정
  - pubspec.yaml > flutter_riverpod: ^2.6.1 이면 legacy.dart 안 써도 됨.
  - flutter_riverpod: ^3.x.x 부터 legacy.dart 필요
  - flutter_riverpod.dart는 무조건 사용
 */

// 상태관리 모델 클래스 정의
class CounterNotifier extends StateNotifier<int> {
  // 상태 초기화
  CounterNotifier() : super(0);
   void increment() => state++;
   void decrement() => state--;
}

// 상태관리 모델 클래스 프로바이더 등록
final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier()
);

final checkProvider = StateProvider((ref) => false);

void main() {
  runApp(ProviderScope( // revierpod 프로바이더를 사용하기 위해 ProviderScope 처리
    child: MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('04.Riverpod 상태 관리 실습'),),
        body: ParentWidget(),
      ),
    );
  }
}

// Riverpod 프로바이더 제공을 위한 ConsumerWidget 상속
class ParentWidget extends ConsumerWidget {
  const ParentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // ref : Riverpod 상태모델 접근을 위한 참조객체
    // 상태 구독
    final counter = ref.watch(counterProvider);
    final check = ref.watch(checkProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Riverpod counter : $counter'),
        const Divider(),
        Row(
          children: [
            ElevatedButton(
                onPressed: (){
                  ref.read(counterProvider.notifier).increment();
                },
                child: const Text('증가')
            ),
            ElevatedButton(
                onPressed: (){
                  ref.read(counterProvider.notifier).decrement();
                },
                child: const Text('감소')
            ),
          ],
        ),
        const Divider(),
        Text(check ? '동의하셨습니다.' : '동의하셔야 합니다.'),
        CheckboxListTile(
          title: const Text('동의합니다.'),
          value: check,
          onChanged: (value){
            ref.read(checkProvider.notifier).state = value ?? false;
          }
        )
      ],
    );
  }
}