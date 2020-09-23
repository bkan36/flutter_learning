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
import 'package:steppe_up/strings.dart';
import 'package:steppe_up/widget/vertical_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text(Strings.appTitle)),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        backgroundImage(),
        mongolianVerticalText(),
        travelMongoliaLabel(),
      ],
    );
  }

  Container backgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/steppe_night.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Align mongolianVerticalText() {
    return Align(
      alignment: Alignment(-0.7, -0.7),
      child: Container(
        height: 300,
        child: VerticalText(
          text: TextSpan(
            text: Strings.mongolianWelcomeText,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  SafeArea travelMongoliaLabel() {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(  // TODO: Start your journey here
          Strings.travelMongolia,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 5.0,
          ),
        ),
      ),
    );
  }
}
