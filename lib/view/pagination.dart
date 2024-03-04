import 'package:flutter/material.dart';
import 'package:netwish/model/Movies.dart';
import 'package:netwish/service/api.dart';
import 'package:provider/provider.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key, required this.currentMovieText});
  final String currentMovieText;

  @override
  State<Pagination> createState() => _Pagination();
}

class _Pagination extends State<Pagination> {
  int currentPage = 1;
  dynamic moviesProvider;

  @override
  void initState() {
    super.initState();
    moviesProvider = context.read<Movies>();
  }

  void loadMovie(BuildContext context) {
    Api api = Api();
    setState(() {
      api.fetchMovie(widget.currentMovieText, context, currentPage);
    });
  }

  void nextPage(BuildContext context) {
    if (currentPage < moviesProvider!.pagesTotal) {
      currentPage++;
      loadMovie(context);
    }
  }

  void previousPage(BuildContext context) {
    if (currentPage > 1) {
      currentPage--;
      loadMovie(context);
    }
  }

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
