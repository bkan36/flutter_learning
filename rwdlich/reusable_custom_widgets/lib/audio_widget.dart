import 'package:flutter/material.dart';
import 'dart:ui';

class AudioWidget extends StatefulWidget {
  const AudioWidget({
    Key key,
    this.isPlaying = false,
    this.onPlayStateChanged,
    this.currentTime,
    this.onSeekBarMoved,
    @required this.totalTime,
  }) : super(key: key);

  final bool isPlaying;
  final ValueChanged<bool> onPlayStateChanged;
  final Duration currentTime;
  final ValueChanged<Duration> onSeekBarMoved;
  final Duration totalTime;

  @override
  _AudioWidgetState createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  double _sliderValue;
  bool _userIsMovingSlider;

  @override
  void initState() {
    super.initState();
    _sliderValue = _getSliderValue();
    _userIsMovingSlider = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_userIsMovingSlider) _sliderValue = _getSliderValue();

    return Container(
      height: 60,
      child: Row(
        children: [
          _buildPlayPauseButton(),
          _buildCurrentTimeLabel(),
          _buildSeekBar(context),
          _buildTotalTimeLabel(),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  Text _buildTotalTimeLabel() {
    return Text(
      _getTimeString(1.0),
    );
  }

  Text _buildCurrentTimeLabel() {
    return Text(
      _getTimeString(_sliderValue),
      style: TextStyle(
        fontFeatures: [FontFeature.tabularFigures()],
      ),
    );
  }

  Expanded _buildSeekBar(BuildContext context) {
    return Expanded(
      child: Slider(
        value: _sliderValue,
        activeColor: Theme.of(context).textTheme.bodyText2.color,
        inactiveColor: Theme.of(context).disabledColor,
        // 1
        onChangeStart: (value) {
          _userIsMovingSlider = true;
        },
        // 2
        onChanged: (value) {
          setState(() {
            _sliderValue = value;
          });
        },
        // 3
        onChangeEnd: (value) {
          _userIsMovingSlider = false;
          if (widget.onSeekBarMoved != null) {
            final currentTime = _getDuration(value);
            widget.onSeekBarMoved(currentTime);
          }
        },
      ),
    );
  }

  IconButton _buildPlayPauseButton() {
    return IconButton(
      icon: (widget.isPlaying) ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      color: Colors.white,
      onPressed: () {
        if (widget.onPlayStateChanged != null) {
          widget.onPlayStateChanged(!widget.isPlaying);
        }
      },
    );
  }

  double _getSliderValue() {
    if (widget.currentTime == null) return 0;

    return widget.currentTime.inMilliseconds / widget.totalTime.inMilliseconds;
  }

  Duration _getDuration(double sliderValue) {
    final seconds = widget.totalTime.inSeconds * sliderValue;
    return Duration(seconds: seconds.toInt());
  }

  String _getTimeString(double sliderValue) {
    final time = _getDuration(sliderValue);

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final minutes =
        twoDigits(time.inMinutes.remainder(Duration.minutesPerHour));
    final seconds =
        twoDigits(time.inSeconds.remainder(Duration.secondsPerMinute));

    final hours = widget.totalTime.inHours > 0 ? '${time.inHours}:' : '';
    return "$hours$minutes:$seconds";
  }
}
