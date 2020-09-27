import 'package:movietracker/models/Movie.dart';
import 'package:movietracker/models/MovieSearchResponse.dart';

extension DataToDomain on MovieSearchResponse {
  List<Movie> toDomain() {
    return this
        .search
        .map((result) => Movie(
              imdbId: result.imdbId,
              name: result.title,
              imageUrl: result.poster,
              year: result.year,
            ))
        .toList();
  }
}
