import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: '02.Image Widget 실습'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*
            이미지 에셋 등록 설정 ⭐⭐⭐
             - pubspec.yaml > flutter 하위에 assets 주석 제거후 이미지 경로 입력
          */
            Image.asset('images/flower1.jpg'),
            Image.asset(
              'images/flower2.jpg',
              width: 200,
              height: 200,
            ),
            Image.asset(
              'images/flower3.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
              repeat: ImageRepeat.noRepeat,
            ),
            Image.network(
              'https://picsum.photos/id/237/200/300',
              width: 100,
              height: 100,
            ),
            Image.network(
              'https://picsum.photos/id/238/200/300',
              width: 100,
              height: 100,
            )

          ],
        )

    );
  }
}
