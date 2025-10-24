/*
    날짜 : 2025/10/23
    이름 : 강민철
    내용 : Dart 함수
 */

void hello(){
  print("hello dart!");
}

int add(int a, int b){
  return a + b;
}

var greet = (String name){
  return 'Greeting ${name}!';
};

int plus( a,  b) => a + b;
int minus( a,  b) => a - b;

int calc(int x, int y, int Function(int, int) operation){
  return operation(x, y);
}

Function createHello(String name){
  return () => "Hello, ${name}";
}

// 이름이 있는 매개변수 함수(Named Parameter, {중괄호} 매개변수)
void person1({String hello = 'hello', String? name}){
  print('person1 : $hello $name');
}
void person2(String name, {String? hello}){
  print('person2 : $hello, $name');
}
void person3(String name, {String? hello, required int age}){
  print('person3 : $hello, $name, $age');
}
// 선택적 위치 매개변수 함수
void user1(String name, [int age = 0]){
  print('user1 $name, $age');
}

void user2(String name, [int? age, String? address]){
  print('user2 $name, $age, $address');
}

void user3(String name, [int age = 0, String address = 'Unknown', String? job]){
  print('user3 $name, $age, $address, $job');
}

void main(){

  // 기본 함수
  hello();

  // 매개변수와 반환값이 있는 함수
  print(add(1, 2));
  print(add(2, 3));

  print('result1 : ${add(1, 2)}');
  print('result2 : ${add(2, 3)}');
  // 익명 함수
  print(greet("김유신"));
  print(greet("김춘추"));

  // 화살표 함수(람다식)
  int rs1 = plus(2, 3);
  int rs2 = minus(2, 3);

  print('rs1 : ${rs1}');
  print('rs2 : ${rs2}');

  // 고차 함수(함수를 매개변수로 전달받거나 반환하는 함수)
  int result = calc(10, 5, minus);
  print('result : ${result}');

  var greeting = createHello("홍길동");
  print(greeting());

  // 이름이 있는 매개변수(Named Parameter, {중괄호} 매개변수)
  person1();
  person1(name : '홍길동');
  person2('김유신');
  person2('김춘추', hello: '안녕하세요.');
  person3(age: 21, '장보고', hello: '반갑습니다.');

  // 선택적 위치 매개변수(Optional Positional Parameter, [대괄호] 매개변수)
  user1('김유신');
  user1('김춘추', 21);
  user2('장보고');
  user2('강감찬', 23);
  user2('이순신', 31, '서울');
  user3('정약용');
  user3('정약용', 44, '부산', '엔지니어');

}