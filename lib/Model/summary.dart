import 'package:bukuku_sample_test/Model/product.dart';
import 'package:bukuku_sample_test/Model/table.dart';

class CartItem {
  final ProductItem product;
  int quantity;
  TableData table;

  CartItem({
    required this.product,
    required this.quantity,
    required this.table,
  });
}