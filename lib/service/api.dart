import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netwish/model/Movies.dart';
import 'package:provider/provider.dart';

class Api {
  static String key = "26a145d058cf4d1b17cbf084ddebedec";
  static String uri = "https://api.themoviedb.org/3/search/movie";

  Future<void> fetchMovie(
      String search, BuildContext context, int currentPage) async {
    final moviesProvider = context.read<Movies>();

    var url = Uri.parse(
        "$uri?api_key=$key&query=$search&language=fr-FR&page=$currentPage");
    var response = await http.get(url);

    Map<String, dynamic> json = jsonDecode(response.body);

    moviesProvider.addMoviesFromJson(json);
  }
}
