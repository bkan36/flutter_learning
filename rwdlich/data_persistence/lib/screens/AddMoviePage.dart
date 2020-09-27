import 'package:flutter/material.dart';
import 'package:movietracker/models/Movie.dart';
import 'package:movietracker/models/MovieTrackerApp.dart';
import 'package:movietracker/widgets/DebouncedTextField.dart';
import 'package:movietracker/widgets/MovieListItem.dart';
import 'package:provider/provider.dart';
import 'package:movietracker/domain/MovieSearchResponse+DataToDomain.dart';

class AddMoviePage extends StatefulWidget {
  @override
  _AddMoviePageState createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  final controller = TextEditingController();
  List<Movie> _results = [];

  @override
  Widget build(BuildContext context) {
    final MovieTrackerApp app = Provider.of<MovieTrackerApp>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DebouncedTextField(
              debounceDuration: Duration(milliseconds: 500),
              decoration:
                  InputDecoration(hintText: 'Add a movie you have seen before'),
              controller: controller,
              onChanged: (v) async {
                final results = await app.movieRepository.findMovies(v);

                setState(() {
                  _results = results.toDomain();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final item = _results[index];
                return GestureDetector(
                  onTap: () => _markAsWatched(item),
                  child: MovieListItem(item: item),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _markAsWatched(Movie movie, [DateTime dateWatched]) async {
    final MovieTrackerApp app = Provider.of<MovieTrackerApp>(context);

    final date = dateWatched ?? DateTime.now();
    movie.watchedOn = date.millisecondsSinceEpoch;
    await app.storage.addToWatched(movie);

    Navigator.pop(context);
  }
}
