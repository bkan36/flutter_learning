import 'package:flutter/material.dart';
import 'package:BullsEyes/gamemodel.dart';
import 'package:BullsEyes/sliderthumbimage.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';

class Control extends StatefulWidget {
  Control({Key key, @required this.model}) : super(key: key);

  final GameModel model;

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  ui.Image _sliderImage;

  Future<ui.Image> _load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void initState() {
    _load('images/nub.png').then((image) {
      setState(() {
        _sliderImage = image;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: Text(
            '1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[700],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 8.0,
              thumbColor: Colors.redAccent,
              thumbShape: SliderThumbImage(_sliderImage),
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
            child: Slider(
              value: widget.model.current.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  widget.model.current = newValue.toInt();
                });
              },
              min: 1.0,
              max: 100.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 64.0),
          child: Text(
            '100',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
