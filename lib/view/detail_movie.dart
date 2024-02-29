import 'package:flutter/material.dart';
import 'package:netwish/model/Movie.dart';

class DetailMovie extends StatelessWidget {
  final Movie movie;
  const DetailMovie({super.key, required this.movie});

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
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.cover,
              ),
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
}
