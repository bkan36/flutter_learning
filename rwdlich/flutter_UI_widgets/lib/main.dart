import 'package:flutter/material.dart';
import 'package:flutter_ui_widgets/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Widget',
      home: MainPage(),
    );
  }
}
