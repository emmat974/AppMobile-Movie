import 'package:netwish/model/Genre.dart';
import 'package:flutter/material.dart';

class Genres with ChangeNotifier {
  List<Genre> genres = [];

  void addGenre(Genre genre) {
    genres.add(genre);
  }

  void addGenreFromJson(Map<String, dynamic> json) {
    print(json);
    List<dynamic> results = json['genres'];

    // Ici on créer des object Movie
    for (var result in results) {
      addGenre(Genre(result['id'], result['name']));
    }

    notifyListeners();
  }

  List<Genre> getGenres(List<dynamic> ids) {
    return genres.where((genre) => ids.contains(genre.id)).toList();
  }
}
