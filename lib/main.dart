import 'package:flutter/material.dart';
import 'package:netwish/model/Movies.dart';
import 'package:netwish/service/api.dart';
import 'package:netwish/view/list_movie.dart';
import 'package:netwish/view/pagination.dart';
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
  // On appel le controller pour input
  final controller = TextEditingController();
  // La barre de recherche qu'on va transmettre à la pagination
  String currentMovieText = "";

  @override
  void initState() {
    super.initState();
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
          // Logo de Netflix alias Netwish
          leading: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset("images/netflix_logo.png")),
          // Le superbe titre que tout le monde ADORE !
          title:
              Text(widget.title, style: const TextStyle(color: Colors.white)),
          actions: [
            // On appel notre barre de recherche ici
            InkWell(
                onTap: () => {_dialogSearch(context)},
                child: const Icon(Icons.search))
          ],
        ),
        body: Column(
          children: [
            const Expanded(child: ListMovie()), // On affiche la liste des films
            Pagination(currentMovieText: currentMovieText) // On affiche sa pagination
          ],
        ));
  }

// On appel la barre de recherche
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
                      // On initialise son état
                      setState(() {
                        currentMovieText = "";
                        currentPage = 1;
                        currentMovieText = controller.text;
                        controller.text = "";
                        loadMovie(context);
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("Valider"))
              ]);
        });
  }

// On recherche l'api pour la barre de recherche
  void loadMovie(BuildContext context) {
    Api api = Api();
    api.fetchMovie(currentMovieText, context, 1);
  }
}
