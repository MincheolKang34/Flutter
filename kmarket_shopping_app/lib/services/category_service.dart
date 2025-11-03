import 'package:kmarket_shopping/models/category.dart';
import 'package:kmarket_shopping/models/category_sub.dart';

class CategoryService {


  // 임시 시뮬레이션 함수(나중에 통신 처리)
  Future<List<Category>> fetchCategories() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 로딩 시뮬레이션 (선택)
    return [
      Category(id: 'C01', name: '의류', subCategories: [
        CategorySub(id: 10, name: "상의"),
        CategorySub(id: 11, name: "하의"),
        CategorySub(id: 12, name: "아우터"),
      ]),
      Category(id: 'C02', name: '식품', subCategories: [
        CategorySub(id: 20, name: '과일'),
        CategorySub(id: 21, name: '채소'),
        CategorySub(id: 22, name: '정육'),
      ]),
      Category(id: 'C03', name: '가전', subCategories: [
        CategorySub(id: 30, name: 'TV'),
        CategorySub(id: 31, name: '냉장고'),
        CategorySub(id: 32, name: '세탁기'),
      ]),
      Category(id: 'C04', name: '뷰티', subCategories: [
        CategorySub(id: 40, name: '화장품'),
        CategorySub(id: 41, name: '향수'),
        CategorySub(id: 42, name: '스킨케어'),
      ]),
    ];
  }
}