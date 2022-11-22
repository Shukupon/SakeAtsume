import 'package:flutter/material.dart';
import 'package:sakeatsume/main.dart';
import 'package:sakeatsume/Model/Sake.dart';

class Sakes extends StatefulWidget {
  const Sakes({super.key});

  @override
  State<Sakes> createState() => _SakesState();
}

class _SakesState extends State<Sakes> {
  final _sakeLists = <Sake>[];
  final _savedSakeLists = <Sake>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        if (index >= _sakeLists.length) {
          _sakeLists.add(new Sake(index.toString()));
        }
        final alreadySaved = _savedSakeLists.contains(_sakeLists[index]);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _savedSakeLists.remove(_sakeLists[index]);
              } else {
                _savedSakeLists.add(_sakeLists[index]);
              }
            });
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    _sakeLists[index].getName()(),
                    style: _biggerFont,
                  ),
                  Icon(
                    // NEW from here ...
                    alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved ? Colors.red : null,
                    semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void loadSavedSake() {}
}
