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
 *
 */

import 'dart:convert';

import 'package:cat_app/api/cat_api.dart';
import 'package:cat_app/models/cats.dart';
import 'package:flutter/material.dart';

class CatInfo extends StatefulWidget {
  final String catBreed;
  final String catId;

  CatInfo({this.catBreed, this.catId});

  @override
  _CatInfoState createState() => _CatInfoState();
}

class _CatInfoState extends State<CatInfo> {
  CatList catList = CatList();

  void getCatData() async {
    var catJson = await CatAPI().getCatBreed(widget.catId);
    print(catJson);

    var catMap = json.decode(catJson);
    print(catMap);
    setState(() {
      catList = CatList.fromJson(catMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getCatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.catBreed),
        ),
        body: getCat());
  }

  Widget getCat() {
    var mediaSize = MediaQuery.of(context).size;
    if (catList == null ||
        catList.breeds == null ||
        catList.breeds.length == 0) {
      return Container();
    } else {
      return Center(
        child: Container(
            width: mediaSize.width,
            height: mediaSize.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(catList.breeds[0].url),
                fit: BoxFit.contain,
              ),
            )),
      );
    }
  }
}
