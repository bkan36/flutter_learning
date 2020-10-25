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

import 'package:book_app/model/library.dart';
import 'package:book_app/model/result.dart';
import 'package:book_app/network/remote_data_source.dart';
import 'package:flutter/material.dart';
import '../common_widget/progress_dialog.dart';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  //variables to hold values that is provided in the TextFields
  String _name, _author, _description;

  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  void initState() {
    super.initState();
    _apiResponse.init();
    hasBookAddedListener();
  }

  void hasBookAddedListener() {
    _apiResponse.hasBookAdded().listen((Result result) {
      if (result is LoadingState) {
        showProgressDialog();
      } else if (result is SuccessState) {
        Navigator.pop(context); //close the progress dialog
        Navigator.pop(context); //navigate back to Favorite Book screen
      } else {
        SnackBar(
          content: Text("Unable to add book"),
          duration: Duration(seconds: 2),
        );
      }
    });
  }

  showProgressDialog() => showDialog(context: context, builder: (BuildContext context) => ProgressDialog());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Book"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            bookTitleTextField(),
            SizedBox(
              height: 10.0,
            ),
            bookAuthorTextField(),
            SizedBox(
              height: 10.0,
            ),
            bookDescriptionTextField(),
            SizedBox(
              height: 10.0,
            ),
            submitButton(),
          ],
        ),
      ),
    );
  }

  TextField bookTitleTextField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Book Title",
        labelText: "Title",
      ),
      onChanged: (value) {
        _name = value;
      },
    );
  }

  TextField bookAuthorTextField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Book Author",
        labelText: "Author",
      ),
      onChanged: (value) {
        _author = value;
      },
    );
  }

  TextField bookDescriptionTextField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Book Description",
        labelText: "Description",
      ),
      onChanged: (value) {
        _description = value;
      },
    );
  }

  RaisedButton submitButton() {
    return RaisedButton(
      onPressed: () {
        final book = Book(
            name: _name, author: _author, description: _description);
        _apiResponse.addBook(book);
      },
      child: Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
    );
  }
}
