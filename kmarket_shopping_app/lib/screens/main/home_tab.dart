import 'package:flutter/material.dart';
import 'package:kmarket_shopping/screens/main/member/login_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _buildAppBar(context),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildSlideBanner(context),
            _buildProductSection(context, '베스트 상품'),
            _buildProductSection(context, '히트 상품'),
            _buildProductSection(context, '추천 상품'),
            _buildProductSection(context, '최신 상품'),
            _buildProductSection(context, '할인 상품'),
            _builderFooter(context),
          ],
        ),
      )
    );
  }

  // 상단 앱바 디자인 함수
  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('images/logo.png', width: 140,),
        IconButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => LoginScreen())
              );
            },
            icon: Icon(Icons.login, size: 30,)
        )
      ],
    );
  }

  // 검색바 디자인 함수
  Widget _buildSearchBar(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(6),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: '상품 검색',
          border: null,
        ),
      ),
    );
  }

  // 슬라이드 디자인 함수
  Widget _buildSlideBanner(BuildContext context){
    final List<String> bannerImages = [
      'images/slider_item1.jpg',
      'images/slider_item2.jpg',
      'images/slider_item3.jpg',
      'images/slider_item4.jpg',
      'images/slider_item5.jpg',
    ];

    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: bannerImages.length,
        itemBuilder: (context, index){
            final pathImage = bannerImages[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              child: Image.asset(pathImage),
            );
          }
      ),
    );
  }
  
  // 상품 섹션 디자인 함수
  Widget _buildProductSection(BuildContext context, String text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index){
              return Container(
                width: 150,
                height: 150,
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      color: Colors.grey,
                      child: Image.asset('images/sample_thumb.jpg'),
                    ),
                    Text('가을 티셔츠'),
                    Text('16,000원')
                  ],
                ),
              );
            }
          ),
        )
      ],
    );
  }

  // 하단 푸터 디자인 함수
  Widget _builderFooter(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.grey[200],
      child: Column(
        children: [
          Text('회사 정보 및 약관'),
          Text('고객센터 : 000-000-0000', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          Text('ⓒKmarket Shopping App. All right reserved.', style: TextStyle(fontSize: 10),),
        ],
      ),
    );
  }
}