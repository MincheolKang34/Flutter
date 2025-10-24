/*
  날짜 : 2025/10/23
  이름 : 강민철
  내용 : Dart 제네릭 컬렉션
*/

class Box<T> {

  T item;

  Box(this.item);

  T getItem(){
    return item;
  }
}


void main(){

  // 제네릭 객체 생성
  Box stringBox = Box<String>('hello');
  String text = stringBox.getItem();
  print('text : $text');

  Box intBox = Box<int>(100);
  int num = intBox.getItem();
  print('num : $num');

  ///////////////////////////
  // List
  ///////////////////////////
  // List 생성
  List<String> fruits = ['Apple', 'Banana', 'Cherry'];
  print('fruits : $fruits');

  // 원소 추가
  fruits.add('Durian');
  print('fruits : $fruits');

  // 원소 참조
  print('첫번째 과일 : ${fruits[0]}');
  print('첫번째 과일 : ${fruits.first}');
  print('마지막 과일 : ${fruits.last}');

  // 원소 수정
  fruits[1] = 'Berry';
  print('fruits : $fruits');

  // 원소 제거
  String removedFruit = fruits.removeAt(0);
  print('removed : $removedFruit');
  print('fruits : $fruits');

  // 리스트 크기
  print('과일 갯수 : ${fruits.length}');

  // 리스트 반복문
  for(String fruit in fruits){
    print('과일 : $fruit');
  }

  // 리스트 필터링
  List<int> numbers = [1, 2, 3, 4, 5];
  var evenNumers = numbers.where((n) => n % 2 == 0);
  print('짝수 : $evenNumers');

  // 변환
  var doubledList = numbers.map((n) => n * 2).toList();
  print('doubleList : $doubledList');

  // 정렬
  numbers.sort();
  print('오름차순 : $numbers');

  numbers.sort((a, b) => b.compareTo(a));
  print('내림차순 : $numbers');

  // 반복처리
  numbers.forEach((n) => print('n값 : $n'));


  ///////////////////////////
  // Set, 중복 제거 자료구조
  ///////////////////////////

  Set<String> colors = {'red', 'green', 'blue'};
  print('colors : $colors');

  // 원소 추가
  colors.add('orange');
  colors.add('red'); // 중복 안됨
  print('colors : $colors');

  // 집합 연산(합집합)
  var set1 = {1, 2, 3, 4};
  var set2 = {3, 4, 5, 6};

  Set<int> unionSet = set1.union(set2);
  print('합집합 : $unionSet');

  // 교집합
  Set<int> intersectSet = set1.intersection(set2);
  print('교집합 : $intersectSet');

  // 차집합
  Set<int> differenceSet = set1.difference(set2);
  print('차집합 : $differenceSet');


  ///////////////////////////
  // Map
  ///////////////////////////

  // Map 생성
  Map<String, String> user = {
    'id': 'a101',
    'name': '홍길동',
    'address': '부산',
  };

  print('user : $user');

  // Map 키 참조
  print('이름 : ${user['name']}');
  print('주소 : ${user['address']}');

  // 키 존재 여부
  print('age 키 존재 여부 : ${user.containsKey('age')}');

  // 모든 키, 값을 리스트 생성
  print('모든 키 목록 : ${user.keys.toList()}');
  print('모든 값 목록 : ${user.values.toList()}');
}