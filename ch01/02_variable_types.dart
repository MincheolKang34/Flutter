/*
    날짜 : 2025/10/23
    이름 : 강민철
    내용 : Dart 변수와 타입
 */

// Dart
void main(){

  // 변수와 기본 타입
  String name = '홍길동';
  int age = 23;
  double height = 177.2;
  bool isStudent = true; // Dart만 bool
  num score = 100;       // 숫자형(int, double 포함하는 상위 타입)
  var address = '부산시'; // 자동 추론 타입(컴파일 시점, 최초 한 번 타입이 정해지면 변경 불가)
  dynamic etc = '기타';   // 자동 동적 타입(런타임 시점, 최초 한 번 타입이 정해져도 변경 가능)

  print('이름 : ${name}\n나이: ${age}\n키: ${height}\n학생 여부: ${isStudent}\n주소: ${address}');

  // Nullable 타입, Dart의 기본 변수는 모두 Non-Nullable, null 취급 하기 위해서 타입 뒤에 ? 표기
  String? value1 = null;
  int? value2;

  print('value1 : ${value1}, value2 : ${value2}');

  // 타입 확인
  print('name 타입 : ${name.runtimeType}');
  print('age 타입 : ${age.runtimeType}');
  print('height 타입 : ${height.runtimeType}');
  print('isStudent 타입 : ${isStudent.runtimeType}');
  print('score 타입 : ${score.runtimeType}');
  print('address 타입 : ${address.runtimeType}');
  print('etc 타입 : ${etc.runtimeType}');
  print('value1 타입 : ${value1.runtimeType}');
  print('value2 타입 : ${value2.runtimeType}');

  // 타입 변환

  String strNum = '2025';
  int intNum = int.parse(strNum);
  print('intNum : ${intNum}');

  double price = 19.9;
  int intPrice = price.toInt();
  print('intPrice : ${intPrice}');

  int count = 122;
  String strCount = count.toString();
  print('strCount : ${strCount}');

  // 상수
  final num1 = 100; // 런타임 상수, 실행 시간에 결정
  const num2 = 200; // 컴파일 타임 상수, 클래스 멤버로 사용

  final today = DateTime.now();
  print('today : ${today}');

  // 문자열
  String hello = "Hello Dart!";

  // 문자열 - 멀티 라인 문자열 ''' '''
  String welcome = '''
  Welcome Dart!
  Welcome World!
  Welcome Flutter!
  ''';

  print(hello);
  print(welcome);

  String escape = "나는 생각한다. 고로 \"존재\"한다.";
  print(escape);

  String rawStr = r'C:\users\flutter\bin';
  print(rawStr);

  String fName = '길동';
  String lName = '홍';
  String fullName = lName + fName;
  print('이름 : ' + fullName);
  print('이름 : $lName$fName'); // 문자열 보간

  String word = 'Flutter';
  print('문자열 길이 : ${word.length}');
  print('첫 번째 문자 : ${word[0]}');

  String text = '    Dart Language    ';
  print('원본 : [$text]');
  print('소문자 : ${text.toLowerCase()}');
  print('대문자 : ${text.toUpperCase()}');
  print('공백 제거 : [${text.trim()}]');
  print('문자 포함 여부 :  ${text.contains('Dart')}');
  print('문자열 교체 : ${text.replaceAll('Dart', 'Flutter')}');

  String sentence = '서울,대전,대구,부산,광주';
  var cities = sentence.split(',');
  print('나눈 결과: $cities');
  print('다시 합치기: ${cities.join('/')}');

}
