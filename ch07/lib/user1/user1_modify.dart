import 'dart:developer';

import 'package:ch07/user1/user1.dart';
import 'package:ch07/user1/user1_service.dart';
import 'package:flutter/material.dart';

// User1 목록
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class User1Modify extends StatefulWidget {
  final String userid; // 전달받은 사용자 아이디

  const User1Modify({super.key, required this.userid});

  @override
  State<StatefulWidget> createState() => _User1ModifyState();
}

class _User1ModifyState extends State<User1Modify> {
  final _formKey = GlobalKey<FormState>();
  final _useridController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _ageController = TextEditingController();

  final service = User1Service(); // 인스턴스 생성

  @override
  void initState() {
    super.initState();

    log("here...1");
    // 수정 데이터 조회하기
    _loadUser();
  }

  Future<void> _loadUser() async {
    log("here...2");
    try{
      // ⭐⭐⭐ Spring에서 ResponseEntity.status(HttpStatus.FOUND)로 되어 있어서 데이터를 못 가져옴 FOUND -> OK로 해야됨
      User1 user = await service.getUser(widget.userid);

      setState(() {
        _useridController.text = user.userid;
        _nameController.text = user.name;
        _birthController.text = user.birth;
        _ageController.text = user.age.toString();
      });
    }catch (err){
      _showDialog('조회 실패', '사용자 정보를 불러오는 중 오류가 발생했습니다.\n$err');
    }
  }

  String message = '';

  Future<void> _submitForm() async {
    log('submitForm...1');
    if (!_formKey.currentState!.validate()) return;

    log('submitForm...2');
    User1 modifyUser = User1(
        userid: _useridController.text,
        name: _nameController.text,
        birth: _birthController.text,
        age: int.tryParse(_ageController.text) ?? 0
    );

    log('submitForm...3');
    try{
      User1 modifiedUser = await service.putUser(modifyUser);
      await _showDialog('수정 성공', '사용자가 성공적으로 수정되었습니다.');
      log('submitForm...4');

      // async 이후 context 안전하게 사용하기 위한 처리, _User1ModifyState 객체가 위젯 트리에 없으면 함수 종료
      // mounted는 현재 State 객체가 위젯 트리에 “붙어 있는지(mounted)” 여부를 나타내는 읽기 전용 불리언 변수
      if(!mounted) return;

      // 목록 이동
      Navigator.pop(context, modifiedUser);
    }catch (err){
      message = '수정 실패, 에러 발생 : $err';
    }
  }

  Future<void> _showDialog(String title, String message){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectBirth() async {
    DateTime now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1900),
        lastDate: now
    );

    if (selectedDate != null) {
      setState(() {
        _birthController.text = selectedDate.toString();
        log(_birthController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User1 수정'),),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _useridController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'User ID'),
                  validator: (value) =>
                  value!.isEmpty ? 'User ID를 입력하세요' : null,
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: '이름'),
                  validator: (value) =>
                  value!.isEmpty ? '이름를 입력하세요' : null,
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _birthController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: '생년월일 (날짜 선택)'),
                  onTap: () => _selectBirth(),
                  validator: (value) =>
                  value!.isEmpty ? '생년월일를 입력하세요' : null,
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number, // 숫자 키보드 표시
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
                  ],
                  decoration: const InputDecoration(labelText: '나이 (숫자만 입력)'),
                  validator: (value) =>
                  value!.isEmpty ? '나이를 입력하세요' : null,
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('취소')
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('수정')
                    )

                  ],
                ),
                Text(message)
              ],
            )
        ),
      )
    );
  }
}