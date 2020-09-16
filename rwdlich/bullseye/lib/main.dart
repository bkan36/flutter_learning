import 'package:flutter/material.dart';

void main() => runApp(BullsEyeApp());

class BullsEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext contexg) {
    return MaterialApp(
        title: 'BullsEye',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: GamePage(title: 'BullsEye'));
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisible = false;
  bool _whosThere = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to my first app',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            FlatButton(
              child: Text('Hit Me!', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                this._alertIsVisible = true;
                _showAlert(context);
                print('BUtton pressed');
              },
            ),
            FlatButton(
              child: Text('Knock Knock!',
                  style: TextStyle(color: Colors.deepOrangeAccent)),
              onPressed: () {
                this._whosThere = true;
                _showWhosThere(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    Widget okButton = FlatButton(
        child: Text('Awesome'),
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsVisible = false;
          print('Awesome pressed! $_alertIsVisible');
        });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hello there'),
          content: Text('This is my first popup'),
          actions: <Widget>[okButton],
          elevation: 5,
        );
      },
    );
  }

  void _showWhosThere(BuildContext context) {
    Widget okButton = FlatButton(
        child: Text('owls say who?'),
        onPressed: () {
          Navigator.of(context).pop();
          this._whosThere = false;
          print('Awesome pressed! $_whosThere');
        });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('who\'s there'),
          content: Text('Owls say'),
          actions: <Widget>[okButton],
          elevation: 5,
        );
      },
    );
  }
}
