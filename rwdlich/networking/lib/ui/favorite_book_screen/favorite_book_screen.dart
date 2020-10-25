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

import '../addscreen/add_book_screen.dart';

class FavoriteBooksScreen extends StatefulWidget {
  @override
  _FavoriteBooksScreenState createState() => _FavoriteBooksScreenState();
}

class _FavoriteBooksScreenState extends State<FavoriteBooksScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Books"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getBooks(),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                Library bookCollection = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: bookCollection.books.length,
                    itemBuilder: (context, index) {
                      return bookListItem(index, bookCollection, context);
                    });
              } else if (snapshot.data is ErrorState) {
                String errorMessage = (snapshot.data as ErrorState).msg;
                return Text(errorMessage);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Dismissible bookListItem(
      int index, Library bookCollection, BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
        Result result = await _apiResponse.deleteBook(index);
        if (result is SuccessState) {
          setState(() {
            bookCollection.books.removeAt(index);
          });
        }
      },
      background: Container(
        color: Colors.red,
      ),
      key: Key(bookCollection.books[index].name),
      child: ListTile(
        leading: Image.asset("images/book.png"),
        title: Text(bookCollection.books[index].name),
        subtitle: Text(
          bookCollection.books[index].description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        ),
        isThreeLine: true,
        trailing: Text(
          bookCollection.books[index].author,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
