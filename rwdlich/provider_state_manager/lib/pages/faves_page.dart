//
// Copyright (c) 2019 Razeware LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trilogies/states_manager/providers.dart';
import 'package:trilogies/widgets/film_item.dart';

class FavesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final faves = watch(faveChangeNotifierProvider);
    var favesCount = faves.length;

    if (favesCount == 0) {
      var style = Theme.of(context).textTheme.headline6;
      return Center(
        child: Text(
          'Faves',
          style: style,
        ),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          _FavesSize(),
          Divider(height: 4, color: Colors.black),
          Expanded(
            child: ListView.builder(
                itemCount: favesCount,
                itemBuilder: (BuildContext context, int position) {
                  return FilmItem(faves.getByPosition(position).episodeId);
                }),
          ),
        ],
      ),
    );
  }
}

class _FavesSize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white);

    return Container(
      color: Theme.of(context).accentColor,
      child: SizedBox(
        height: 40,
        child: Center(child: Text('Faves Size', style: textStyle)),
      ),
    );
  }
}
