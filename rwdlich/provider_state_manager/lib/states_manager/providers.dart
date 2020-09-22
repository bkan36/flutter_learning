// ignore: top_level_function_literal_block
import 'package:flutter_riverpod/all.dart';
import 'package:trilogies/models/faves.dart';
import 'package:trilogies/models/films.dart';

// ignore: top_level_function_literal_block
final filmsProvider = StateProvider((ref) {
  return FilmsModel();
});

// // ignore: top_level_function_literal_block
// final favesProvider = StateProvider((ref) {
//   return FavesModel(ref.watch(filmsProvider).state, null);
// });

// ignore: missing_return
final faveChangeNotifierProvider = ChangeNotifierProvider<FavesModel>((ref) {
  return FavesModel(ref.watch(filmsProvider).state, null);
});
