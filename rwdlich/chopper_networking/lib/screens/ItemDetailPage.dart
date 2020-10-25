/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:magiccart/models/Item.dart';
import 'package:magiccart/models/MagicCartApp.dart';
import 'package:magiccart/widgets/MagicAppBar.dart';
import 'package:magiccart/widgets/PillShapedButton.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatelessWidget {
  final Item item;

  const ItemDetailPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MagicAppBar.build(context: context),
      body: ListView(
        children: <Widget>[
          Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$ ${item.price}',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item.description),
          ),
          _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Builder(
      builder: (contextWithScaffold) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PillShapedButton(
              title: 'Add to Cart',
              onPressed: () => addToCart(contextWithScaffold)),
        );
      },
    );
  }

  void addToCart(BuildContext context) {
    final app = Provider.of<MagicCartApp>(context);
    final repo = app.storage;

    repo.addToCart(item);
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('Added to cart!'),
      ),
    );
  }
}
