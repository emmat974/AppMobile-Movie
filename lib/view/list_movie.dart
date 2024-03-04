import 'package:flutter/material.dart';
import 'package:netwish/model/Genre.dart';
import 'package:netwish/model/Movie.dart';
import 'package:netwish/model/Movies.dart';
import 'package:netwish/view/detail_movie.dart';
import 'package:provider/provider.dart';

class ListMovie extends StatefulWidget {
  ListMovie({super.key, required this.selectedGenre});
  List<Genre> selectedGenre;

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  @override
  Widget build(BuildContext context) {
    final Movies moviesProvider = context.watch<Movies>();

    final List<Movie> filteredMovies = widget.selectedGenre.isEmpty
        ? moviesProvider.movies
        : moviesProvider.movies.where((movie) {
            return movie.genres
                .any((genre) => widget.selectedGenre.contains(genre));
          }).toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Affiche 3 éléments par ligne
      ),
      itemCount: filteredMovies.length,
      itemBuilder: (context, index) {
        final movie = filteredMovies[index];
        // On affiche la liste des films et on créer action pour basculé vers un film
        return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailMovie(movie: movie),
                ),
              );
            },
            child: GridTile(
              child: Image.network(
                  (movie.posterPath == ""
                      ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFMajTZbAQY6npCl8mKCCgtcpHrDjFFwTOqtCd_TzlRY_ombudyD5Y_jxWFOiGJz-hzO4&usqp=CAU"
                      : "https://image.tmdb.org/t/p/w200${movie.posterPath}"),
                  fit: BoxFit.cover),
              footer: GridTileBar(
                backgroundColor: Colors.black12,
                title: Text(movie.title,
                    style: const TextStyle(color: Colors.white)),
              ),
            ));
      },
    );
  }
}
