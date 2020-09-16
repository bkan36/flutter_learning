import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  Score(
      {Key key,
      @required this.totalScore,
      @required this.round,
      @required this.onStartOver})
      : super(key: key);

  final int totalScore;
  final int round;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text('Start Over', style: TextStyle(color: Colors.green)),
          onPressed: () {
            onStartOver();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Score: '),
              Text('$totalScore '),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Round: '),
              Text('$round'),
            ],
          ),
        ),
        FlatButton(
          child: Text('Info', style: TextStyle(color: Colors.redAccent)),
          onPressed: () {},
        ),
      ],
    );
  }
}
