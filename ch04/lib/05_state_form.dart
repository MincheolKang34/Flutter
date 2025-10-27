/*
  날짜 : 2025.10.27.
  이름 : 강민철
  내용 : Widget Form 실습
 */

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('05.폼 위젯 실습'),),
        body: FormPage(),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _formPageState();
}

class _formPageState extends State<FormPage> {
  // 폼을 식별하고 상태를 관리하는 전역키 생성
  final _formKey = GlobalKey<FormState>();

  // 컨트롤러 생성
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // 상태 변수
  String _email = '';
  bool _isCheck = false;
  String _gender = 'M';
  bool _isSwiched = false;
  String _submitResult = '';

  // 폼 취소 함수
  void _cancelForm(){
    _formKey.currentState!.reset();

    _idController.clear();
    _pwController.clear();
    _nameController.clear();

    _isCheck = false;
    _isSwiched = false;
    
    _submitResult = '';

    // 화면 재빌드
    setState(() {});
  }

  // 폼 제출 함수
  void _submitForm() {
    // 폼 유효성 검사
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

      String idValue = _idController.text;
      String pwValue = _pwController.text;
      String nameValue = _nameController.text;

      setState(() {
        _submitResult = '입력 성공!\n'
            '아이디 : $idValue\n'
            '비밀번호 : $pwValue\n'
            '이름 : $nameValue\n'
            '이메일 : $_email\n'
            '가입동의 : $_isCheck\n'
            '성별 : $_gender\n'
            '푸시 알림 허용 : $_isSwiched';
      });
    }else {
      setState(() {
        _submitResult = '입력 실패! 입력 항목을 확인하세요.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder()
                ),
                validator: (value){
                  if (value == null || value.isEmpty)
                    return '아이디를 입력하세요.';
                  if (value.length < 4)
                    return '아이디는 4자 이상이어야 합니다.';

                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _pwController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder()
                ),
                validator: (value){
                  if (value == null || value.isEmpty)
                    return '비밀번호를 입력하세요.';
                  if (value.length < 6)
                    return '비밀번호는 6자 이상이어야 합니다.';

                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                  border: OutlineInputBorder()
                ),
                validator: (value){
                  if (value == null || value.isEmpty)
                    return '이름를 입력하세요.';

                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if (value == null || value.isEmpty)
                    return '이메일를 입력하세요.';
                  if (!value.contains('@'))
                    return '유효한 이메일이 아닙니다.';
                  return null;
                },
                onSaved: (value){
                  _email = value!;
                },
              ),

              const SizedBox(height: 10,),
              CheckboxListTile(
                  title: const Text('회원 가입에 동의합니다.'),
                  value: _isCheck,
                  onChanged: (value){
                    setState(() {
                      _isCheck = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
              ),

              const SizedBox(height: 10,),
              const Text('성별 선택', style: TextStyle(fontSize: 16),),
              RadioGroup<String>(
                  onChanged: (value){
                    setState(() {
                      _gender = value ?? '';
                    });
                  },
                  groupValue: _gender,
                  child: Row(
                    children: [
                      Expanded(
                          child: RadioListTile<String>(
                              value: 'M',
                              title: const Text('남자'),
                          )
                      ),
                      Expanded(
                          child: RadioListTile<String>(
                              value: 'W',
                              title: const Text('여자'),
                          )
                      ),
                    ],
                  )
              ),
              
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text('푸시 알림 허용'),
                  const Spacer(),
                  Switch(
                      value: _isSwiched,
                      onChanged: (value){
                        setState(() {
                          _isSwiched = value;
                        });
                      }
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _cancelForm,
                      child: const Text('취소')
                  ),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('제출')
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Text(_submitResult)
            ],
          )
      ),
    );
  }
}