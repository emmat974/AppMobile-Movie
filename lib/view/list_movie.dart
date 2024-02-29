import 'package:flutter/material.dart';
import 'package:netwish/model/Movies.dart';
import 'package:netwish/view/detail_movie.dart';
import 'package:provider/provider.dart';

class ListMovie extends StatefulWidget {
  const ListMovie({super.key});

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = context.watch<Movies>();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Affiche 3 éléments par ligne
      ),
      itemCount: moviesProvider.movies.length,
      itemBuilder: (context, index) {
        final movie = moviesProvider.movies[index];
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
                  "https://image.tmdb.org/t/p/w200${movie.posterPath}",
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