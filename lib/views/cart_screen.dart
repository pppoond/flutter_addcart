import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:appcart/models/cart_model.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "cart-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Cart"),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Cart",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Consumer<CartProvider>(
                builder: (context, value, child) => ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount:
                        value.cartList.isNotEmpty ? value.cartList.length : 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _showMyDialog(context, value.cartList[index], index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 7),
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Row(
                            children: [
                              Text(value
                                  .cartList[index].productModel.productName),
                              const Spacer(),
                              Text(
                                  'จำนวน ${value.cartList[index].amount.toString()}'),
                            ],
                          ),
                        ),
                      );
                    }),
              )),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(
      BuildContext context, CartModel cartModel, int index) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('รองเท้า'),
          content: SingleChildScrollView(child: StatefulBuilder(builder:
              (BuildContext context, void Function(void Function()) setState) {
            return ListBody(
              children: <Widget>[
                Text(cartModel.productModel.productName),
                const SizedBox(
                  height: 16,
                ),
                Text(cartModel.amount.toString()),
              ],
            );
          })),
          actions: <Widget>[
            TextButton(
              child: const Text('Remove Cart'),
              onPressed: () {
                cartProvider.removeCart(cartModel: cartModel);
                Navigator.of(context).pop();
              },
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
        );
      },
    );
  }
}
