class Product {
  final int pno;
  final String productName;
  final String category;
  final int price;
  final int point;
  final int discount;
  final int delivery;
  final int stock;
  final String? etc; // etc 값이 null

  final String thumb120;
  final String thumb240;
  final String thumb750;

  Product({
    required this.pno,
    required this.productName,
    required this.category,
    required this.price,
    required this.point,
    required this.discount,
    required this.delivery,
    required this.stock,
    this.etc, // nullable은 required 해제
    required this.thumb120,
    required this.thumb240,
    required this.thumb750
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        pno: json['pno'],
        productName: json['productName'],
        category: json['category'],
        price: json['price'],
        point: json['point'],
        discount: json['discount'],
        delivery: json['delivery'],
        stock: json['stock'],
        etc: json['etc'],
        thumb120: json['thumb120'],
        thumb240: json['thumb240'],
        thumb750: json['thumb750']
    );
  }
}