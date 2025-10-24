/*
    날짜 : 2025/10/23
    이름 : 강민철
    내용 : Dart 비동기 처리
*/

// Future는 미래에 가져오는 값을 의미하는 객체
import 'dart:async';

Future<String> fetchData(){
  return Future.delayed(Duration(seconds: 3), (){
    return 'fetchData!';
  });
}

// Stream을 반환하는 함수
Stream<int> countStream() async* {
  for(int i=1; i<=5; i++){
    await Future.delayed(Duration(seconds: 1));
    yield i; // 스트림으로 데이터는 내보내기(emit)
  }
}

void main() async{
  // 비동기 작업 수행
  print('here...1');
  
  fetchData()
      .then((data){
        print('here...2 : $data');
  })
      .catchError((err){
        print('here...3 : $err');
  })
      .whenComplete((){
        print('here...4 비동기 작업 완료');
  });
  
  print('here...5');
  
  // async/await 실행
  print('async_await...1');
  
  try {
    String data = await fetchData(); // 비동기 처리를 대기
    print('async_await...2 : $data');
  }catch(e) {
    print('async_await...3 : $e');
  }finally {
    print('async_await...4 비동기 작업 완료');
  }
  
  print('async_await...5');

  /*
    Future vs Stream
     - Future는 한 번만 비동기 값을 반환하는 비동기 처리
     - Stream은 시간이 지남에 따라 여러 데이터를 순차적으로 전달하는 비동기 처리
   */
  // Stream 직업
  final controller = StreamController<String>();

  // Stream 리스너 등록
  controller
      .stream.listen((data){
        print('stream...1 : $data');
  })
      .onError((err){
        print('stream error');
  });

  // 스트림 데이터 전송
  controller.sink.add('hello');
  controller.sink.add('welcome');
  controller.sink.add('greeting');

  // Stream 함수 호출
  Stream<int> stream = countStream();

  await for(int number in stream){
    print('스트림 데이터 수신 : $number');
  }
}