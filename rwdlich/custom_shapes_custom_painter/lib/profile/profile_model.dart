/* 
 * Copyright (c) 2020 Razeware LLC
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
 * This project and source code may use libraries or frameworks that are
 * released under various Open-Source licenses. Use of those libraries and
 * frameworks are governed by their own individual licenses.
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

class ProfileModel {
  ProfileModel(
      {@required this.name,
      @required this.title,
      @required this.photo,
      @required this.born,
      @required this.died,
      @required this.about,
      @required this.profileColor});

  final String name;
  final String title;
  final String photo;
  final String born;
  final String died;
  final String about;
  final Color profileColor;
}

final profileData = ProfileModel(
  name: 'Al-Khwarizmi',
  title: 'Mathematician and Astronomer',
  photo: 'al-khwarizmi.jpg',
  born: 'c. 780',
  died: 'c. 850',
  about:
      'Muhammad ibn Musa al-Khwarizmi was a Persian mathematician, astronomer, astrologer geographer and a scholar in the House of Wisdom in Baghdad. He was born in Persia of that time around 780. Al-Khwarizmi was one of the learned men who worked in the House of Wisdom.\n\nAl-Khwarizmi developed the concept of the algorithm in mathematics (which is a reason for his being called the grandfather of computer science by some people).\n\nAl-Khwarizmi’s algebra is regarded as the foundation and cornerstone of the sciences. To al-Khwarizmi we owe the world “algebra,” from the title of his greatest mathematical work, Hisab al-Jabr wa-al-Muqabala. The book, which was twice translated into Latin, by both Gerard of Cremona and Robert of Chester in the 12th century, works out several hundred simple quadratic equations by analysis as well as by geometrical example. It also has substantial sections on methods of dividing up inheritances and surveying plots of land. It is largely concerned with methods for solving practical computational problems rather than algebra as the term is now understood.',
  profileColor: Color(0xFF1f6fff),
);

final profileColors = [
  Color(0xFF1f6fff),
  Colors.purple,
  Colors.green,
  Colors.brown,
];
