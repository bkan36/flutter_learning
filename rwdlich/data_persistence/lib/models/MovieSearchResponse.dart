/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the 'Software'), to deal
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
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'dart:convert';

MovieSearchResponse movieSearchResponseFromJson(String str) =>
    MovieSearchResponse.fromJson(json.decode(str));

String movieSearchResponseToJson(MovieSearchResponse data) =>
    json.encode(data.toJson());

class MovieSearchResponse {
  List<Search> search;
  String totalResults;
  String response;
  String error;

  MovieSearchResponse({
    this.search,
    this.totalResults,
    this.response,
    this.error,
  });

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) =>
      MovieSearchResponse(
        search: List<Search>.from(
            (json['Search'] ?? []).map((x) => Search.fromJson(x))),
        totalResults: json['totalResults'],
        response: json['Response'],
        error: json['Error'],
      );

  Map<String, dynamic> toJson() => {
        'Search': List<dynamic>.from(search.map((x) => x.toJson())),
        'totalResults': totalResults,
        'Response': response,
        'Error': error,
      };
}

class Search {
  String title;
  String year;
  String imdbId;
  Type type;
  String poster;

  Search({
    this.title,
    this.year,
    this.imdbId,
    this.type,
    this.poster,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        title: json['Title'],
        year: json['Year'],
        imdbId: json['imdbID'],
        type: typeValues.map[json['Type']],
        poster: json['Poster'],
      );

  Map<String, dynamic> toJson() => {
        'Title': title,
        'Year': year,
        'imdbID': imdbId,
        'Type': typeValues.reverse[type],
        'Poster': poster,
      };
}

enum Type { MOVIE, GAME }

final typeValues = EnumValues({'game': Type.GAME, 'movie': Type.MOVIE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
