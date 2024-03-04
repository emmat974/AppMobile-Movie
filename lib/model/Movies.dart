import 'package:netwish/model/Genre.dart';
import 'package:netwish/model/Genres.dart';
import 'package:netwish/model/Movie.dart';
import 'package:flutter/material.dart';

class Movies with ChangeNotifier {
  List<Movie> movies = [];
  int pagesTotal = 1;
  int resultsTotal = 1;

  void addMovie(Movie movie) {
    movies.add(movie);
  }

  void cleanMovie() {
    movies.clear();
  }

  // Ici on hydrate nos données
  void addMoviesFromJson(Map<String, dynamic> json, Genres genres) {
    List<dynamic> results = json['results'];

    cleanMovie();
    pagesTotal = int.parse(json['total_pages'].toString());
    resultsTotal = int.parse(json['total_results'].toString());

    // Ici on créer des object Movie
    for (var result in results) {
      List<Genre> movieGenres = [];
      List<dynamic> genreIds = result['genre_ids'];
      movieGenres = genres.getGenres(genreIds);

      addMovie(Movie(result['title'] ?? 'No Title', result['poster_path'] ?? '',
          result['overview'] ?? 'No Overview', movieGenres));
    }

    notifyListeners();
  }
}
