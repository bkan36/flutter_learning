import 'package:flutter/material.dart';

class Prompt extends StatelessWidget {
  Prompt({@required this.targetValue});
  final int targetValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('PUT THE BULLEYE AS CLOSE AS YOU CAN TO'),
        Text('$targetValue'),
      ],
    );
  }
}
