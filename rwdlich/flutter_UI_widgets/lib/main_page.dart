import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter UI Widgets'),
      ),
      body: Container(
        margin: EdgeInsets.all(32.0),
        padding: EdgeInsets.all(16.0),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2, color: Colors.red),
          color: Colors.green,
        ),
        // color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue,
              child: Text(
                '1',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Text(
                '2',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Text(
                '3',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Clicked');
        },
        child: Icon((Icons.add)),
      ),
    );
  }
}
