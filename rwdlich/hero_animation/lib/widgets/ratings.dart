import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  final int value;
  final Color color;

  const Ratings({Key key, this.value = 0, this.color = Colors.amber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Icon(
            index < value ? Icons.star : Icons.star_border,
            color: color,
          );
        }),
      ),
    );
  }
}
