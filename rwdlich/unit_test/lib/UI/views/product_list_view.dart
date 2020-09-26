import 'package:flutter/material.dart';
import 'package:shopnbuy/UI/views/base_view.dart';
import 'package:shopnbuy/core/viewmodels/cart_model.dart';
import 'package:shopnbuy/core/viewmodels/product_list_model.dart';
import 'package:shopnbuy/helpers/constants.dart';

class ProductListView extends StatelessWidget {
  Widget _buildCartButton(BuildContext context, CartModel cartModel) {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.shopping_cart),
            splashColor: Colors.blue,
            onPressed: () {
              // TODO 21: Navigate to Cart Summary
            }),
        // TODO 16: Call Get CartSize
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO 14: Wrap Widget with Cart Model
    return BaseView<ProductListModel>(
      // TODO 5: Call Get Products
      onModelReady: (model) => {},
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: Text(ViewTitle.ProductList),
            actions: <Widget>[_buildCartButton(context, null)],
          ),
          // TODO 9: Check Model State and pass products data
          body: Container()),
    );
  }
}
