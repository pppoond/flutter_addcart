// ignore_for_file: unrelated_type_equality_checks

import 'package:appcart/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartModel {
  ProductModel productModel;
  int amount;
  CartModel({
    required this.productModel,
    required this.amount,
  });
}

class CartProvider extends ChangeNotifier {
  Map<String, CartModel> _cartList = {};

  //--------------------------

  List<CartModel> get cartList {
    return _cartList.values.toList();
  }

  //--------------------------

  void addCart({
    required ProductModel productModel,
    required int amount,
  }) {
    if (_cartList.containsKey(productModel.productId)) {
      _cartList.update(
        productModel.productId,
        (existingCartItem) => CartModel(
          productModel: productModel,
          amount: existingCartItem.amount + amount,
        ),
      );
    } else {
      _cartList.putIfAbsent(
        productModel.productId,
        () => CartModel(
          productModel: productModel,
          amount: amount,
        ),
      );
    }
    notifyListeners();
  }

  void removeCart({required CartModel cartModel}) {
    _cartList
        .removeWhere((key, value) => key == cartModel.productModel.productId);
    notifyListeners();
  }
}
