import 'package:bukuku_sample_test/Model/product.dart';
import 'package:bukuku_sample_test/Model/summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartSummary extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartSummary({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  void _removeProduct(CartItem product) {
    setState(() {
      final existingItemIndex = widget.cartItems.indexWhere((item) => item.product.name == product.product.name);

      if (existingItemIndex != -1) {
        if(widget.cartItems[existingItemIndex].quantity>=2) {
          widget.cartItems[existingItemIndex].quantity--;
        }else{
          widget.cartItems.remove(product);
        }
      } else {
        widget.cartItems.remove(product);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var item in widget.cartItems) {
      totalPrice += item.product.price * item.quantity;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Expanded(
          child: ListView.builder(
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = widget.cartItems[index];
              return Container(
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 30,
                        child: ListTile(
                          title: Text(cartItem.product.name),
                          trailing: Text(
                              '${cartItem.quantity} x \$${cartItem.product.price.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    IconButton(onPressed:()=>_removeProduct(cartItem) , icon: Icon(Icons.remove_circle))
                  ],
                ),
              );
            },
          ),
        ),
          const Divider(),
          Text('Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () {
              // Proses checkout
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}