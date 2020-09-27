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

import 'package:magiccart/demo/Demo.dart';

import 'Item.dart';
import 'Store.dart';

class Cart implements MapConvertible {
  Map<String, int> _itemCounts = Map();
  final Store _store = Demo.store;

  Map<String, int> get itemCounts => _itemCounts;

  Cart() {
    _itemCounts = Map();
  }

  double get totalPrice =>
      _itemCounts.entries
          ?.map((entry) =>
              _store.itemForId(int.parse(entry.key)).price * (entry.value ?? 0))
          ?.fold(0, (value, element) => value + element) ??
      0;

  Item itemAtIndex(int index) {
    final id = _itemCounts.keys.toList()[index];
    return _store.itemForId(int.parse(id));
  }

  int countAtIndex(int index) {
    return _itemCounts.values.toList()[index];
  }

  void add(Item item, [int quantity = 1]) {
    var count = _itemCounts[item.id.toString()];

    if (count != null) {
      count += quantity;
    } else {
      count = quantity;
    }

    _itemCounts[item.id.toString()] = count;
  }

  void setCount(Item item, int quantity) {
    _itemCounts[item.id.toString()] = quantity;
  }

  void increment(Item item) {
    var count = _itemCounts[item.id.toString()];

    if (count != null) {
      count += 1;
    }

    _itemCounts[item.id.toString()] = count;
  }

  int decrement(Item item) {
    var count = _itemCounts[item.id.toString()];

    if (count != null) {
      count -= 1;
    }

    _itemCounts[item.id.toString()] = count;

    return count;
  }

  void remove(Item item) {
    _itemCounts.remove(item.id.toString());
  }

  @override
  Map<dynamic, dynamic> toMap() {
    return _itemCounts;
  }

  @override
  Cart fromMap(Map<dynamic, dynamic> map) {
    final cart = Cart();
    cart._itemCounts = map;
    return cart;
  }
}
