import 'package:flutter/material.dart';
import 'package:kmarket_shopping/screens/main/member/terms_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인'),),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              const SizedBox(height: 20,),
              const Text('쇼핑몰 로그인', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              TextField(decoration: InputDecoration(
                  labelText: '아이디 입력',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호 입력',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){},
                    child: const Text('로그인', style: TextStyle(fontSize: 20, color: Colors.black),)
                ),
              ),
              const SizedBox(height: 20,),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => TermsScreen())
                    );
                  },
                  child: const Text('회원가입', style: TextStyle(fontSize: 20, color: Colors.black),)
              )
            ],
          ),
        ),
      ),
    );
  }
}