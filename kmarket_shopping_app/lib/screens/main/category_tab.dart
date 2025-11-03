import 'package:flutter/material.dart';
import 'package:kmarket_shopping/models/category.dart';
import 'package:kmarket_shopping/models/category_sub.dart';
import 'package:kmarket_shopping/services/category_service.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryTabState(); // _는 private 의미
}

class _CategoryTabState extends State<CategoryTab> {
  late Future<List<Category>> _categories;
  int _selectedIndex = 0; // 선택된 1차 카테고리 인덱스

  CategoryService service = CategoryService();

  @override
  void initState() {
    super.initState();
    _categories = service.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카테고리'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
          future: _categories,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasError) { // 통신 중 에러 발생
              return Center(child: Text('카테고리 로드 실패: ${snapshot.error}'),);
            } else if (snapshot.hasData) { // 통신 성공, 데이터 존재
              final categories = snapshot.data!;

              if (categories.isEmpty) { // 빈 배열일 경우
                return const Center(child: Text('등록된 카테고리가 없습니다.'),);
              }

              return Row( // 가로로 나열
                children: <Widget>[
                  // 1차 카테고리 (좌측)
                  _buildPrimaryCategory(categories),

                  // 2차 카테고리 (우측)
                  _buildSecondaryCategory(categories[_selectedIndex].subCategories),
                ],
              );
            }
            return const Center(child: Text('카테고리 정보 없음'),);
          }
      )
    );
  }

  // 1차 카테고리 테스트
  Widget _buildPrimaryCategory(List<Category> categories) {
    return Container(
      width: 100,
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) { // index = list 인덱스
          return InkWell( // 터치 효과 & 제스처 감지
            onTap: () { // 눌렀을 경우
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0), // 대칭(symmetric) 수직(vertical) 15 padding
              decoration: BoxDecoration(
                color: _selectedIndex == index ? Colors.white : Colors.grey[200],
                border: const Border(
                  right: BorderSide(color: Colors.blueAccent, width: 2.0)
                )
              ),
              alignment: Alignment.center,
              child: Text(
                categories[index].name,
                style: TextStyle(
                  fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                  color: _selectedIndex == index ? Colors.blueAccent : Colors.black,
                ),
              ),
            ),
          );
        }),
    );
  }
  
  // 2차 카테고리 테스트
  Widget _buildSecondaryCategory(List<CategorySub> subCategories) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('2차 카테고리', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                  itemCount: subCategories.length,
                  itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text(subCategories[index].name),
                      );
                  },
                )
            )
          ],
        ),
      )
    );
  }
}