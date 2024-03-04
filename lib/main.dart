import 'package:flutter/material.dart';
import 'package:netwish/model/Movies.dart';
import 'package:netwish/service/api.dart';
import 'package:netwish/view/list_movie.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Movies()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Netwish'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  int currentPage = 1;
  String currentMovieText = "";
  dynamic moviesProvider;

  @override
  void initState() {
    super.initState();
    moviesProvider = context.read<Movies>();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(221, 24, 24, 24),
          title:
              Text(widget.title, style: const TextStyle(color: Colors.white)),
          actions: [
            InkWell(
                onTap: () => {_dialogSearch(context)},
                child: const Icon(Icons.search))
          ],
        ),
        body: Column(
          children: [const Expanded(child: ListMovie()), pagination(context)],
        ));
  }

  Future<void> _dialogSearch(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Rechercher un film"),
              content: TextField(controller: controller),
              actions: [
                TextButton(
                    onPressed: () {
                      currentMovieText = "";
                      currentPage = 1;
                      currentMovieText = controller.text;
                      controller.text = "";
                      loadMovie(context);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Valider"))
              ]);
        });
  }

  void loadMovie(BuildContext context) {
    Api api = Api();
    setState(() {
      api.fetchMovie(currentMovieText, context, currentPage);
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

  Widget pagination(BuildContext context) {
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
