import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netwish/model/Genre.dart';
import 'package:netwish/model/Genres.dart';
import 'package:netwish/model/Movies.dart';
import 'package:provider/provider.dart';

class Api {
  static String key = "26a145d058cf4d1b17cbf084ddebedec";
  static String uri = "https://api.themoviedb.org/3/search/movie";

// Ici on appel l'api selon sa key, sa recherche, la langue et la page courarnt
  Future<void> fetchMovie(
      String search, BuildContext context, int currentPage) async {
    final moviesProvider = context.read<Movies>();
    final genresProvider = context.read<Genres>();

    var url = Uri.parse(
        "$uri?api_key=$key&query=$search&language=fr-FR&page=$currentPage");
    var response = await http.get(url);

    Map<String, dynamic> json = jsonDecode(response.body);

    moviesProvider.addMoviesFromJson(json, genresProvider);
  }

// Ici on initialise des films
  Future<void> homeMovie(BuildContext context) async {
    final moviesProvider = context.read<Movies>();
    final genresProvider = context.read<Genres>();

    var url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$key&language=fr-FR");
    var response = await http.get(url);

    Map<String, dynamic> json = jsonDecode(response.body);

    moviesProvider.addMoviesFromJson(json, genresProvider);
  }

// Ici on va appeler les genre
  Future<void> fetchGenre(BuildContext context) async {
    final genresProvider = context.read<Genres>();

    var url = Uri.parse(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=$key&language=fr-FR");
    var response = await http.get(url);

    Map<String, dynamic> json = jsonDecode(response.body);
    genresProvider.addGenreFromJson(json);
  }
}
