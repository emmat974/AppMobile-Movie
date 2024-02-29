import 'package:netwish/model/Movie.dart';
import 'package:flutter/material.dart';

class Movies with ChangeNotifier {
  List<Movie> movies = [];

  void addMovie(Movie movie) {
    movies.add(movie);
  }

  void cleanMovie() {
    movies.clear();
  }

  void addMoviesFromJson(Map<String, dynamic> json) {
    List<dynamic> results = json['results'];
    cleanMovie();
    for (var result in results) {
      addMovie(Movie(
        result['title'] ?? 'No Title',
        result['poster_path'] ?? '',
        result['overview'] ?? 'No Overview',
      ));
    }

    notifyListeners();
  }
}
