import 'package:bukuku_sample_test/Model/product.dart';

class CartItem {
  final ProductItem product;
  int quantity;
  int table;

  CartItem({
    required this.product,
    required this.quantity,
    required this.table,
  });
}