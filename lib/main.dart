import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Prueba', home: MyList());
  }
}

class MyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyListState();
  }
}

class MyListState extends State<MyList> {
  final _words = <WordPair>[];
  final saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Prueba Examen'),
            backgroundColor: Colors.grey,
            // Lista de widgets(icons) con acciones
            actions: <Widget>[
              IconButton(icon: Icon(Icons.list), onPressed: pressed)
            ]),
        body: scroll(),
        backgroundColor: Colors.blueGrey);
  }

  Widget scroll() {
    return ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider(
              color: Colors.black,
            );
          }
          if (i >= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }
          return row(_words[i]);
        },
        padding: EdgeInsets.all(18.0));
  }

  Widget row(WordPair word) {
    return ListTile(
        title: Text(word.toString()),
        trailing: saved.contains(word)
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border),
        onTap: () {
          setState(() {
            if (saved.contains(word)) {
              saved.remove(word);
            } else {
              saved.add(word);
            }
          });
        });
  }

  // Método llamado en lista de acciones AppBar
  // Abre lista de guardados en nueva ruta
  void pressed() {
    // Se usa navigator pasando context
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      // Se recorre uno a uno los elementos de saved,
      // así se crean nuestros tiles
      final tiles = saved.map((pair) {
        return ListTile(title: Text(pair.toString()));
      });

      // Podemos añadir un divisor a la lista de esta otra forma
      final dividedTiles = ListTile.divideTiles(
        context: context,
        tiles: tiles,
        color: Colors.black,
      ).toList();

      // Ahora sí retornamos nuestra vista con el Listview y nuestros tiles
      return Scaffold(
          appBar: AppBar(
            title: Text('Favoritos'),
            backgroundColor: Colors.grey,
          ),
          body: ListView(children: dividedTiles),
          backgroundColor: Colors.blueGrey);
    }));
  }
}
