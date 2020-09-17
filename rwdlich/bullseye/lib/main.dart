import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:BullsEyes/prompt.dart';
import 'package:BullsEyes/control.dart';
import 'package:BullsEyes/score.dart';
import 'package:BullsEyes/gamemodel.dart';
import 'package:BullsEyes/hitmebutton.dart';
import 'package:BullsEyes/teststyles.dart';
import 'package:BullsEyes/stylebutton.dart';

void main() => runApp(BullsEyeApp());

class BullsEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext contexg) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
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
  GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 32.0),
                child: Prompt(targetValue: _model.target),
              ),
              Control(
                model: _model,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: HitMeButton(
                  text: 'HIT ME!',
                  onPressed: () {
                    _showAlert(context);
                    this._alertIsVisible = true;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Score(
                  totalScore: _model.totalScore,
                  round: _model.round,
                  onStartOver: _startNewGame,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _sliderValue() => _model.current;

  int _pointsForCurrentRound() {
    var result = 100 - _amountOff();

    if (result == 100)
      return result + 100;
    else if (result == 99)
      return result + 50;
    else
      return result;
  }

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    setState(() {
      _model.totalScore = GameModel.SCORE_START;
      _model.round = GameModel.ROUND_START;
      _model.target = _newTargetValue();
      _model.current = GameModel.SLIDER_START;
    });
  }

  void _showAlert(BuildContext context) {
    Widget okButton = StyleButton(
        icon: Icons.close,
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsVisible = false;
          setState(() {
            _model.totalScore += _pointsForCurrentRound();
            _model.target = _newTargetValue();
            _model.round += 1;
          });
        });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            _alertTitle(),
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'THE SLIDER\'S VALUE IS',
                textAlign: TextAlign.center,
              ),
              Text(
                '${_sliderValue()}',
                style: TargetTextStyle.bodyText1(context),
                textAlign: TextAlign.center,
              ),
              Text(
                '\nYou scored ${_pointsForCurrentRound()} points this round.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[okButton],
          elevation: 5,
        );
      },
    );
  }

  int _amountOff() => (_sliderValue() - _model.target).abs();

  String _alertTitle() {
    var diff = _amountOff();

    if (diff == 0) {
      return 'Perfect!';
    } else if (diff < 5) {
      return 'You almost had it!';
    } else if (diff <= 10) {
      return 'Not bad.';
    } else
      return 'Are you even trying ?';
  }
}
