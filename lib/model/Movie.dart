import 'package:netwish/model/Genre.dart';

class Movie {
  String title;
  String overview;
  String posterPath;
  List<Genre> genres;

  Movie(this.title, this.posterPath, this.overview, this.genres);
}
