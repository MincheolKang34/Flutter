import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입'),),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('기본 정보 입력'),
                  const SizedBox(height: 20,),
                  _buildInputField(title: '아이디 입력'),
                  const SizedBox(height: 10,),
                  _buildInputField(title: '비밀번호 입력'),
                  const SizedBox(height: 10,),
                  _buildInputField(title: '비밀번호 확인'),
                  const SizedBox(height: 10,),
                  _buildInputField(title: '이메일 입력'),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: const Text('취소')
                        ),
                        const SizedBox(width: 10,),
                        ElevatedButton(
                            onPressed: (){},
                            child: const Text('가입')
                        ),
                      ],
                    ),
                  )
                ],
              )
          )
        ),
      ),
    );
  }

  // 입력 필드 디자인 함수
  Widget _buildInputField({
    // required TextEditingController controller,
    required String title
  }){
    return TextFormField(
      controller: null,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 15)
      ),
    );
  }
}