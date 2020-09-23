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

import 'profile/profile_model.dart';

class LifeTime extends StatelessWidget {
  LifeTime({@required this.born, @required this.died});

  final String born;
  final String died;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Info(title: 'Born', subtitle: born),
        Info(title: 'Died', subtitle: died),
      ],
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    @required this.title,
    @required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Colors.grey.shade600)),
        Text(subtitle, style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LifeTime(
          born: profileData.born,
          died: profileData.died,
        ),
        Divider(
          height: 40,
          thickness: 1,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('About', style: Theme.of(context).textTheme.headline6)),
        SizedBox(height: 8),
        Text(
          profileData.about,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class ColorPickerMenu extends StatelessWidget {
  ColorPickerMenu(this.onColorSelected);

  final void Function(Color color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: PopupMenuButton<Color>(
        onSelected: onColorSelected,
        icon: Icon(
          Icons.edit,
        ),
        itemBuilder: (BuildContext context) {
          return profileColors.map((Color color) {
            return PopupMenuItem<Color>(
              value: color,
              child: Container(
                decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                height: 10,
              ),
            );
          }).toList();
        },
      ),
      onPressed: () {},
    );
  }
}
