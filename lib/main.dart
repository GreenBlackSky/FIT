import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Generators generator",
      theme: ThemeData(primaryColor: Colors.black),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <String>[];
  final _saved = Set<String>();
  final _font = TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd)
          return Divider(
            height: 8.0,
          );

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions
              .addAll(generateWordPairs().take(10).map(_generatorGenerator));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(String text) {
    final _alreadySaved = _saved.contains(text);
    return ListTile(
      title: Text(
        text,
        style: _font,
      ),
      trailing: Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (_alreadySaved) {
            _saved.remove(text);
          } else {
            _saved.add(text);
          }
        });
      },
    );
  }

  String _generatorGenerator(WordPair pair) =>
      "Generator of ${pair.first} ${pair.second}s";

  Widget _buildSaved(BuildContext context) {
    final tiles = _saved.map(_buildRow);
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved generators'),
      ),
      body: ListView(children: divided),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: _buildSaved),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Here is your idea for generator:"),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
