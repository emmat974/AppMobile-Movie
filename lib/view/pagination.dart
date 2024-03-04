import 'package:flutter/material.dart';
import 'package:netwish/model/Movies.dart';
import 'package:netwish/service/api.dart';
import 'package:provider/provider.dart';

class Pagination extends StatefulWidget {
  // Nécessite ce qu'on a recherché
  const Pagination({super.key, required this.currentMovieText});
  final String currentMovieText;

  @override
  State<Pagination> createState() => _Pagination();
}

class _Pagination extends State<Pagination> {
  // On initialise a 1;
  int currentPage = 1;
  // var Movies
  dynamic moviesProvider;

  @override
  void initState() {
    super.initState();
    moviesProvider = context.read<Movies>();
  }

// On recherche les films et on mettre à jour l'interface
  void loadMovie(BuildContext context) {
    Api api = Api();
    setState(() {
      api.fetchMovie(widget.currentMovieText, context, currentPage);
    });
  }

// Page suivante de la pagination
  void nextPage(BuildContext context) {
    if (currentPage < moviesProvider!.pagesTotal) {
      currentPage++;
      loadMovie(context);
    }
  }

// Page précédent de la pagination
  void previousPage(BuildContext context) {
    if (currentPage > 1) {
      currentPage--;
      loadMovie(context);
    }
  }

// Affiche la pagination s'il y a des films
  @override
  Widget build(BuildContext context) {
    print("Pagination");
    print(moviesProvider.movies.isEmpty);
    return moviesProvider.movies.isEmpty
        ? Container()
        : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            if (currentPage > 1)
              paginationButton(
                  () => currentPage > 1 ? previousPage(context) : null,
                  "Précédent"),
            if (currentPage < moviesProvider!.pagesTotal)
              paginationButton(
                  () => currentPage <= moviesProvider!.pagesTotal
                      ? nextPage(context)
                      : null,
                  "Suivant"),
          ]);
  }

// Le style de bouton pour éviter de répéter le code plusieurs fois
  ElevatedButton paginationButton(VoidCallback onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
