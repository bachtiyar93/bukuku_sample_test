import 'package:bukuku_sample_test/Model/summary.dart';

class TableData {
  int number;
  TableStatus status;
  List<CartItem>? pesanan;

  TableData({required this.number, required this.status, this.pesanan});
}

enum TableStatus { available, occupied }