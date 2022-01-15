import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

import '../utils/custom_page_route.dart';

import '../models/product_model.dart';
import '../models/cart_model.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "home-screen";

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          builder: (BuildContext context) {
                            return CartScreen();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Consumer<CartProvider>(
                  builder: (context, value, child) {
                    if (value.cartList.isNotEmpty) {
                      return Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(value.cartList.length.toString()),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    child: const Text(
                      "Products",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 7, mainAxisSpacing: 7),
                itemCount: productProvider.productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      _showMyDialog(
                          context, productProvider.productList[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productProvider.productList[index].productName,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 21, 89, 167)),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Expanded(
                              child: Image(
                                image: NetworkImage(productProvider
                                    .productList[index].productImage),
                                alignment: Alignment.center,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                                'ราคา ${productProvider.productList[index].productPrice}'),
                          ]),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog(
      BuildContext context, ProductModel productModel) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    int _amount = 0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                  title: const Text('รองเท้า'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(productModel.productName),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        if (_amount > 0) {
                                          _amount--;
                                        } else {}
                                      },
                                    );
                                  }),
                            ),
                            Container(
                              margin: const EdgeInsets.all(16),
                              child: Text(
                                _amount.toString(),
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _amount++;
                                      },
                                    );
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Add Cart'),
                      onPressed: _amount > 0
                          ? () {
                              cartProvider.addCart(
                                  productModel: productModel, amount: _amount);
                              Navigator.of(context).pop();
                            }
                          : null,
                    ),
                    TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      },
    );
  }
}
