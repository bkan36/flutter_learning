import 'package:http/http.dart' as http;

import '../models/rick_morty.dart';

class RickAndMortyAPI {
  final charactersUrl = 'https://rickandmortyapi.com/api/character/';

  Future<RickAndMorty> fetchCharacters([int page = 1]) async {
    try {
      final response = await http.get('$charactersUrl/?page=$page');
      if (response.statusCode == 200) {
        return rickAndMortyFromJson(response.body);
      } else {
        throw Exception("Error occured while fetching Data");
      }
    } catch (e) {
      print("Error occured during connection");
      return null;
    }
  }
}
