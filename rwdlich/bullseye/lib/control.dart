import 'package:flutter/material.dart';
import 'gamemodel.dart';

class Control extends StatefulWidget {
  Control({Key key, @required this.model}) : super(key: key);

  final GameModel model;

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  double _currentValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text('1'),
        ),
        Expanded(
          child: Slider(
            value: widget.model.current.toDouble(),
            onChanged: (newValue) {
              setState(() {
                _currentValue = newValue;
                widget.model.current = newValue.toInt();
              });
            },
            min: 1.0,
            max: 100.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text('100'),
        )
      ],
    );
  }
}
