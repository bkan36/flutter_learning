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
import 'package:movietracker/models/Movie.dart';
import 'package:movietracker/models/MovieTrackerApp.dart';
import 'package:movietracker/widgets/MagicAppBar.dart';
import 'package:movietracker/widgets/PillShapedButton.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatelessWidget {
  final Movie item;

  const ItemDetailPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CinephileAppBar.build(context: context),
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
              'Year ${item.year}',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Watched on:' +
                DateTime.fromMillisecondsSinceEpoch(item.watchedOn).toString()),
          ),
          _buildRemoveButton(),
        ],
      ),
    );
  }

  Widget _buildRemoveButton() {
    return Builder(
      builder: (contextWithScaffold) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PillShapedButton(
              title: 'I did not watch this',
              onPressed: () => removeFromWatched(contextWithScaffold)),
        );
      },
    );
  }

  void removeFromWatched(BuildContext context) async {
    final app = Provider.of<MovieTrackerApp>(context);
    final repo = app.storage;

    await repo.removeFromWatched(item);

    app.refresh();
    Navigator.pop(context);
  }
}
