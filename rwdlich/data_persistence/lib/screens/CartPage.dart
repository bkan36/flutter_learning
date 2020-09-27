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
import 'package:magiccart/models/Cart.dart';
import 'package:magiccart/models/MagicCartApp.dart';
import 'package:magiccart/models/User.dart';
import 'package:magiccart/widgets/CartListItem.dart';
import 'package:magiccart/widgets/MagicAppBar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<MagicCartApp>(context);
    final repository = app.storage;
    final user = app.user;
    final cart = repository.getCart(user);

    return Scaffold(
      appBar: MagicAppBar.build(context: context, onCartPressed: () => null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            _buildUserRow(user),
            _buildList(cart),
            Text(
              'Total Price: \$ ${cart.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            Container(height: 20),
            MaterialButton(
                child: Text('Logout'),
                onPressed: () async {
                  await app.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (_) => false);
                })
          ],
        ),
      ),
    );
  }

  Widget _buildList(Cart cart) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cart.itemCounts.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, int index) {
        final item = cart.itemAtIndex(index);
        final count = cart.countAtIndex(index);
        return CartListItem(item: item, count: count);
      },
    );
  }

  Widget _buildUserRow(User user) {
    return Row(
      children: <Widget>[
        if (user.photo != null)
          SizedBox.fromSize(
            size: Size(40, 40),
            child: Image.memory(
              user.photo,
              fit: BoxFit.cover,
            ),
          ),
        Container(
          width: 8,
        ),
        Text('Hi, ${user.name}! Your cart contains the following:'),
      ],
    );
  }
}
