import 'package:flutter/cupertino.dart';

class ProductModel {
  String productId;
  String productName;
  double productPrice;
  String productImage;
  ProductModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });
}

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _productList = [
    ProductModel(
      productId: "1",
      productName: "Nike Air Force",
      productPrice: 3500.0,
      productImage:
          "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/ebad848a-13b1-46d5-a85e-49b4b6a4953c/%E0%B8%A3%E0%B8%AD%E0%B8%87%E0%B9%80%E0%B8%97%E0%B9%89%E0%B8%B2-air-force-1-le-TDGHCN.png",
    ),
    ProductModel(
      productId: "2",
      productName: "Air Jordan",
      productPrice: 5200.0,
      productImage:
          "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/76976120-1c43-4b97-8e7e-251f0b9684e8/air-force-1-shadow-womens-shoes-kTgn9J.png",
    ),
    ProductModel(
      productId: "3",
      productName: "Nike Court",
      productPrice: 2900.0,
      productImage:
          "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/a47b2ef9-8239-4e82-99fd-e6159c0df489/air-max-97-mens-shoes-SD3ZmW.png",
    ),
  ];

  //------------------Getter Setter
  List<ProductModel> get productList {
    return _productList;
  }
}
