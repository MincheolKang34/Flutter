/*
  날짜 : 2025.10.27.
  이름 : 강민철
  내용 : Dialog 위젯 실습하기
 */

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('05.Dialog 위젯 실습'),),
        body: DialogTest(),
      ),
    );
  }
}

class DialogTest extends StatelessWidget {
  const DialogTest({super.key});

  // 기본 대화상자
  void _showAlertDialog(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false, // 배경 영역을 터치했을 때 대화상자 닫기 불가
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('기본 대화상자'),
            content: const Text('내용입니다.'),
            actions: [
              TextButton(
                  onPressed: (){
                    // 대화상자 위젯을 네비게이션 스택에서 제거
                    Navigator.of(context).pop();
                  },
                  child: const Text('취소')
              ),
              TextButton(
                  onPressed: (){
                    // 대화상자 위젯을 네비게이션 스택에서 제거
                    Navigator.of(context).pop();

                    // 스낵바에 확인 출력
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: const Text('확인 클릭'))
                    );
                  },
                  child: const Text('확인')
              ),
            ],
          );
        }
    );
  }

  // 달력 대화상자
  void _showDateDialog(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2200)
                            );

    print(selectedDate);
    // 스낵바에 확인 출력
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${selectedDate?.toString()}'))
    );
  }

  // 사용자 정의 대화상자
  void _showCustomDialog(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false, // 배경 영역을 터치했을 때 대화상자 닫기 불가
        builder: (BuildContext context){
          return Dialog(
            child: Container(
              height: 400,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('사용자 정의 대화상자'),
                  SizedBox(height: 10,),
                  Text('사용자 정의 대화상자 내용입니다.'),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text('닫기')
                  )
                ],
              ),
            )
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: (){
                _showAlertDialog(context);
              },
              child: const Text('기본 대화상자 출력')
          ),
          ElevatedButton(
              onPressed: (){
                _showDateDialog(context);
              },
              child: const Text('달력 대화상자 출력')
          ),
          ElevatedButton(
              onPressed: (){
                _showCustomDialog(context);
              },
              child: const Text('사용자 정의 대화상자 출력')
          ),
        ],
      ),
    );
  }
}