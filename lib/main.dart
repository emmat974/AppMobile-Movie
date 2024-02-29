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
        body: const ListMovie());
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
                      Api api = Api();
                      api.fetchMovie(controller.text, context);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Valider"))
              ]);
        });
  }
}
