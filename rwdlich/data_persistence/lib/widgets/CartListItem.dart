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
import 'package:provider/provider.dart';

import 'StoreListItem.dart';

class CartListItem extends StatefulWidget {
  final Item item;
  final int count;

  const CartListItem({Key key, this.item, this.count}) : super(key: key);

  @override
  _CartListItemState createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<MagicCartApp>(context);
    final repo = app.storage;

    return Row(
      children: <Widget>[
        Expanded(
          child: StoreListItem(item: widget.item),
        ),
        MaterialButton(
          minWidth: 0,
          padding: EdgeInsets.zero,
          child: Icon(Icons.add),
          onPressed: () {
            repo.incrementInCart(widget.item);
            app.refresh();
          },
        ),
        SizedBox.fromSize(
          size: Size(20, 20),
          child: Text('${widget.count}'),
        ),
        MaterialButton(
          minWidth: 0,
          padding: EdgeInsets.zero,
          child: Icon(Icons.remove),
          onPressed: () {
            repo.decrementInCart(widget.item);
            app.refresh();
          },
        ),
      ],
    );
  }
}
