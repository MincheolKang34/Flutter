import 'package:kmarket_shopping/models/product.dart';

class Cart {
  final int? cartId;
  final String? userid;
  final Product product;
  final int quantity;

  Cart({required this.cartId, required this.userid, required this.product, required this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>;
    return Cart(
        cartId: json['cartId'],
        userid: json['userid'],
        product: Product.fromJson(product),
        quantity: json['quantity']
    );
  }
}