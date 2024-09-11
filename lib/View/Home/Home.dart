import 'package:bukuku_sample_test/Model/product.dart';
import 'package:bukuku_sample_test/Model/summary.dart';
import 'package:bukuku_sample_test/View/Home/cart.dart';
import 'package:bukuku_sample_test/View/Home/drawer.dart';
import 'package:bukuku_sample_test/View/Home/table.dart';
import 'package:bukuku_sample_test/Widget/style.dart';
import 'package:bukuku_sample_test/core/AppHelpers.dart';
import 'package:bukuku_sample_test/global_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home>createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalState? global;
  List<ProductItem> products = [
    ProductItem(name: 'Product 1', price: 10.0),
    ProductItem(name: 'Product 2', price: 20.0),
  ];



  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) {
        String newName = '';
        double newPrice = 0.0;
        return AlertDialog(
          title: const Text('Add New Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => newName = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) => newPrice = double.tryParse(value) ?? 0.0,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  products.add(ProductItem(name: newName, price: newPrice));
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addToCart(ProductItem product) {
    setState(() {
      final existingItemIndex = global!.cartItems.indexWhere((item) => item.product.name == product.name);

      if (existingItemIndex != -1) {
        global!.cartItems[existingItemIndex].quantity++;
      } else {
        global!.cartItems.add(CartItem(product: product, quantity: 1, table: global!.tableSelected ?? 0));
      }
    });
  }
  @override
  void initState() {
    global= AppHelpers.getState<GlobalState>(listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan'),
      ),
    drawer: const Drawer(
    child: MyDrawerContent(),),
    body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Welcome Administrator', style: AppStyles.textL.bold,),
                      IconButton(
                          onPressed: _addProduct,
                          icon: Icon(Icons.add_circle, size: 45,))
                    ],
                  ),
                ),
                Divider(thickness: 1,),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GridView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Container(
                          height: 80,

                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1)
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                  child: SizedBox(
                                      height: 100,
                                      child: CachedNetworkImage(
                                        imageUrl: 'https://example.com/image.jpg',
                                        placeholder: (context, url) => const Center(
                                          child: Icon(Icons.image, size: 80,),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(product.name),
                                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                                  onTap: () => _addToCart(product),
                                ),
                              ),
                            ],
                          ),
                        );
                      }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      childAspectRatio: 3/4
                    
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            width: 20,
            thickness: 1,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                    height: 50,
                    alignment: Alignment.centerRight,
                    child: IconButton(onPressed: ()=>AppHelpers.navigation.openPageClass(TableManagement()), icon: Icon(Icons.table_bar, size: 45,))),
                Divider(),
                Expanded(child: CartSummary(cartItems: global!.cartItems)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





