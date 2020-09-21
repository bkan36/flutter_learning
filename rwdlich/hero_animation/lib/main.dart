import 'package:flutter/material.dart';

import 'pages/recipes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFd33946),
        canvasColor: Color(0xFFd33946),
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              headline: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
      ),
      home: Recipes(),
    );
  }
}
