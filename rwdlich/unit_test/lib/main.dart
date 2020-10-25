import 'package:flutter/material.dart';
import 'package:shopnbuy/UI/app_theme.dart';
import 'package:shopnbuy/UI/views/product_list_view.dart';

void main() {
  
  runApp(ShopNBuyApp());
}

class ShopNBuyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.data,
      home: ProductListView(),
    );
  }
}
