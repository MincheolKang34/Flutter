import 'package:kmarket_shopping/models/category_sub.dart';

class Category {
  final String id;
  final String name;
  final List<CategorySub> subCategories;

  Category({required this.id, required this.name, required this.subCategories});
}