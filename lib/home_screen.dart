import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_name_generator/saved_suggestion_scree.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final saved = <WordPair>{};

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return SavedSuggestionsScreen(items: saved);
        },
      ), // ...to here.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        /*The expression i ~/ 2 divides i by 2 and returns an integer result.
       For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2. This calculates the actual
           number of word pairings in the ListView, minus the divider widgets.*/
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        final alreadySaved = saved.contains(_suggestions[index]);
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Removed From Saved' : 'Saved',
          ),
          onTap: () {
            setState(() {
              alreadySaved
                  ? saved.remove(_suggestions[index])
                  : saved.add(_suggestions[index]);
            });
          },
        );
      }),
    );
  }
}