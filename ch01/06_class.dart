/*
    날짜 : 2025/10/23
    이름 : 강민철
    내용 : Dart 객체지향 프로그래밍
 */

class Person {
  String? name;
  int? age;

  void introduce(){
    print('name : ${name}, age : ${age}');
  }
}

class User {
  // 속성명 앞에 _ 표기로 private 선언
  String _name;
  String _birth;
  int? _age;

  // 클래스 속성
  static int total = 0;

  // 지연 초기화 속성, 속성을 생성자에서 초기화하지 않고, 객체를 생성 후 특정 메서드에서 초기화
  late String _email;

  // 기본 생성자
  User(this._name, this._birth);

  // 명명된 생성자(Named Constructor), 초기화 목록 생성자
  User.withAge(String name, String birth, int age) : this._name = name, this._birth = birth, this._age = age {
    // 객체 생성 후 필요한 로직 처리
    total++;
    print('User.withAge 호출...');
  }

  User.guest(this._name) : this._birth = 'Unknown', this._age = 0;

  // factory 생성자 (객체를 캐싱하는 생성자)
  static final Map<String, User> _cache = {}; // User 객체 캐싱 저장소

  factory User.createUser(String name, String birth) {
    if(_cache.containsKey(name)){
      return _cache[name]!; // 캐시에서 객체 반환
    }else{
      var newUser = User(name, birth);
      _cache[name] = newUser; // 캐시 저장
      return newUser;
    }
  }

  // Getter/Setter
  String get name => _name;
  String get birth => _birth;
  int? get age => _age;

  set name(String name){
    _name = name;
  }

  set birth(String birth){
    _birth = birth;
  }

  set age(int age){
    _age = age;
  }

  // 메서드
  void hello(){
    print('name : $_name, birth : $_birth, age : $_age, email : $_email');
  }

  // late 속성을 초기화 하는 메서드
  void initEmail(String value){
    if(value.contains('@')){
      _email = value;
    }else{
      print('이메일 형식이 아닙니다.');
    }
  }

  @override
  String toString() {
    return 'User{_name: $_name, _birth: $_birth, _age: $_age}';
  }
}


void main(){

  // 객체 생성
  Person person1 = Person();
  person1.name = '김유신';
  person1.age = 23;
  person1.introduce();

  // 객체 생성(Cascade 연산자 초기화)
  Person person2 = Person()
    ..name = '김춘추'
    ..age = 21
    ..introduce();

  // User 객체 생성
  var user1 = User('홍길동', '1990-09-02');
  user1.initEmail('hong@gmail.com'); // late 속성을 초기화
  user1.hello();

  // 속성 참조(Getter 사용)
  print('이름 : ${user1.name}'); // _name 직접 접근 안됨, name Getter 호출
  print('나이 : ${user1.age}'); // _age 직접 접근 안됨, age Getter 호출

  // Setter 사용, toString 출력
  user1.age = 30;
  print(user1);

  var user2 = User.withAge('김유신', '1999-02-03', 23);
  user2.initEmail('kim@naver.com');
  user2.hello();

  var user3 = User.guest('김춘추');
  user3.initEmail('chun@naver.com');
  user3.hello();

  var user4 = User.withAge('장보고', '1999-02-03', 23);
  user4.initEmail('jang@naver.com');
  user4.hello();

  // 클래스 속성
  print('전체 인원 : ${User.total}');
}