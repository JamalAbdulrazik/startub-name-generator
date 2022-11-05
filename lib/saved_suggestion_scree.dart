import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedSuggestionsScreen extends StatelessWidget {
  SavedSuggestionsScreen({super.key, required this.items});
  Set<WordPair> items = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    final tiles = items.map((pair) {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: const TextStyle(fontSize: 18),
        ),
      );
    });
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
        : <Widget>[];
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Suggestions')),
      body: ListView(children: divided),
    );
  }
}
