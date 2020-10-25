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

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magiccart/models/MagicCartApp.dart';
import 'package:magiccart/models/User.dart';
import 'package:magiccart/widgets/PillShapedButton.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();
  Uint8List _photoBytes;

  var _isLoggedIn = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final app = Provider.of<MagicCartApp>(context);
    final storage = app.storage;
    final user = await storage?.getUser();

    _isLoggedIn = user != null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoggedIn ? Container() : _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ListView(
        children: <Widget>[
          Text(
            'Create a User',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff000000),
            ),
          ),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xff9b9b9b),
              ),
              hintText: 'Enter a username (there is no password)',
              hintMaxLines: 1,
            ),
          ),
          _buildPhotoRow(context),
          PillShapedButton(
            title: 'Create User',
            onPressed: () => _createUser(context),
          )
        ],
      ),
    );
  }

  Widget _buildPhotoRow(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (_photoBytes != null)
            SizedBox.fromSize(
              size: Size(30, 30),
              child: Image.memory(
                _photoBytes,
                fit: BoxFit.cover,
              ),
            ),
          Container(
            width: 8,
          ),
          Text(_photoBytes == null ? 'Select Photo' : 'Change Photo'),
        ],
      ),
      onPressed: () async {
        final bytes = await _selectPhoto(context);
        setState(() {
          _photoBytes = bytes;
        });
      },
    );
  }

  void _createUser(BuildContext context) async {
    if (_photoBytes == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Please select a photo'),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return;
    }
    final user =
        User(name: _controller.text, id: _controller.text, photo: _photoBytes);
    final app = Provider.of<MagicCartApp>(context);
    final repo = app.storage;
    await repo.saveUser(user);

    Navigator.of(context).pushReplacementNamed('/shop');
  }

  Future<Uint8List> _selectPhoto(BuildContext context) async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      return bytes;
    }

    return null;
  }
}
