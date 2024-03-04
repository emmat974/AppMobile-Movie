import 'package:flutter/material.dart';
import 'package:netwish/model/Movie.dart';

class DetailMovie extends StatelessWidget {
  // Nécessite un objet movie
  final Movie movie;
  const DetailMovie({super.key, required this.movie});

// On affiche un film par rapport à Movie
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(221, 24, 24, 24),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            movie.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.network(
                (movie.posterPath == ""
                    ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFMajTZbAQY6npCl8mKCCgtcpHrDjFFwTOqtCd_TzlRY_ombudyD5Y_jxWFOiGJz-hzO4&usqp=CAU"
                    : "https://image.tmdb.org/t/p/w200${movie.posterPath}"),
                fit: BoxFit.cover,
              ),
              listGenre(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  movie.overview,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }

  Widget listGenre() {
    return Wrap(
      spacing: 8.0, // Espacement horizontal entre les chips
      runSpacing: 4.0, // Espacement vertical entre les lignes
      children: List<Widget>.generate(
        movie.genres.length,
        (int index) {
          return Chip(
            label: Text(movie.genres[index].name),
            // Vous pouvez ajouter d'autres propriétés comme la suppression ou l'action sur le chip
          );
        },
      ),
    );
  }
}
