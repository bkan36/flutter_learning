import '../api/rick_morty_api.dart';
import '../models/rick_morty.dart';

class RickAndMortyRepo {
  final rickMortyApi = RickAndMortyAPI();

  Future<RickAndMorty> getCharacters({int page}) =>
      rickMortyApi.fetchCharacters(page);
}
