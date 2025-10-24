/*
    날짜 : 2025/10/23
    이름 : 강민철
    내용 : Dart 예외처리
 */

void main(){

  // 예외 처리 기본
  try {
    int result = 10 ~/ 0;
    print(result);
  }catch(e){
    print('예외발생 : $e');
  }

  // 특정 예외 처리
  try {
    String input = 'abc';
    int number = int.parse(input);
    print('number : $number');
  } on FormatException {
    print('형식 예외 발생!');
  } catch(e) {
    print('예외 : $e');
  }

  // finally
  try {
    String input = 'abc';
    int number = int.parse(input);
    print('number : $number');
  } on FormatException {
    print('형식 예외 발생!');
  } catch(e) {
    print('예외 : $e');
  } finally {
    print('작업 완료...');
  }

  // 사용자 정의 예외
  // checkAge(-10);
  // checkAge(9);
  checkAge(21);

} // main end

class MyException implements Exception {
  final String message;
  MyException(this.message);

  @override
  String toString() {
    return 'MyException : $message';
  }
}

void checkAge(int age){
  if(age < 0){
    throw MyException('나이는 음수가 될 수 없습니다.');
  }else if(age < 10){
    throw MyException('미성년자는 서비스를 이용할 수가 없습니다.');
  }
  print('나이 : $age');
}