import 'package:flutter/foundation.dart';

import 'films.dart';

class FavesModel extends ChangeNotifier {
  final FilmsModel _films;
  final List<int> _episodeIds;

  FavesModel(this._films, FavesModel previous)
      : assert(_films != null),
        _episodeIds = previous?._episodeIds ?? [];

  List<Film> get films => _episodeIds.map((id) => _films.getById(id)).toList();

  Film getByPosition(int position) => films[position];

  void add(Film film) {
    _episodeIds.add(film.episodeId);
    notifyListeners();
  }

  void remove(Film film) {
    _episodeIds.remove(film.episodeId);
    notifyListeners();
  }

  int get length => _episodeIds.length;
}
