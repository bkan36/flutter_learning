import 'package:flutter/material.dart';

import 'pages/characters.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CharactersPage(),
    );
  }
}
