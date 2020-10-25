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

import 'dart:async';

import 'package:book_app/network/book_client.dart';
import 'package:http/http.dart';

import '../model/library.dart';
import '../model/network_response.dart';
import '../model/result.dart';
import '../util/request_type.dart';

class RemoteDataSource {
  //Creating Singleton
  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _apiResponse = RemoteDataSource._privateConstructor();
  factory RemoteDataSource() => _apiResponse;

  BookClient client = BookClient(Client());

  StreamController<Result> _addBookStream;
  Stream<Result> hasBookAdded() => _addBookStream.stream;

  void init() => _addBookStream = StreamController();

  Future<Result> getBooks() async {
    try {
      final response = await client.request(requestType: RequestType.GET, path: "books");
      if (response.statusCode == 200) {
        return Result<Library>.success(Library.fromRawJson(response.body));
      } else {
        return Result.error("Book list not available");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  void addBook(Book book) async {
    _addBookStream.sink.add(Result<String>.loading("Loading"));
    try {
      final response = await client.request(
          requestType: RequestType.POST, path: "addBook", parameter: book);
      if (response.statusCode == 200) {
        _addBookStream.sink.add(Result<NetworkResponse>.success(
            NetworkResponse.fromRawJson(response.body)));
      } else {
        _addBookStream.sink.add(Result.error("Something went wrong"));
      }
    } catch (error) {
      _addBookStream.sink.add(Result.error("Something went wrong!"));
    }
  }

  Future<Result> deleteBook(int index) async {
    try {
      final response = await client.request(
          requestType: RequestType.DELETE, path: "deleteBook/$index");
      if (response.statusCode == 200) {
        return Result<NetworkResponse>.success(
            NetworkResponse.fromRawJson(response.body));
      } else {
        return Result<NetworkResponse>.error(
            NetworkResponse.fromRawJson(response.body));
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  void dispose() => _addBookStream.close();
}
