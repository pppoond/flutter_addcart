import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './views/home_screen.dart';
import './views/cart_screen.dart';

import './models/product_model.dart';
import './models/cart_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        title: "App Cart",
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
