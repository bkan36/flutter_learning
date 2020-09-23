/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:steppe_up/model/line_info.dart';
import 'package:steppe_up/model/text_run.dart';
import 'package:steppe_up/model/vertical_paragraph_constraints.dart';
import 'package:steppe_up/util/line_breaker.dart';

// TODO: Refer to the tutorial for directions to complete this class.
class VerticalParagraph {
  VerticalParagraph(this._paragraphStyle, this._textStyle, this._text);

  ui.ParagraphStyle _paragraphStyle;
  ui.TextStyle _textStyle;
  String _text;

  double _width = 0;
  double _height = 0;
  double _minIntrinsicHeight = 0;
  double _maxIntrinsicHeight = 0;

  double get width => _width;

  double get height => _height;

  double get minIntrinsicHeight => _minIntrinsicHeight;

  double get maxIntrinsicHeight => _maxIntrinsicHeight;

  List<TextRun> _runs = [];

  void _addRun(int start, int end) {
    // 2
    final builder = ui.ParagraphBuilder(_paragraphStyle)
      ..pushStyle(_textStyle)
      ..addText(_text.substring(start, end));
    final paragraph = builder.build();

    // 3
    paragraph.layout(ui.ParagraphConstraints(width: double.infinity));

    final run = TextRun(start, end, paragraph);
    _runs.add(run);
  }

  List<LineInfo> _lines = [];

  void _addLine(int start, int end, double width, double height) {
    final bounds = Rect.fromLTRB(0, 0, width, height);
    final LineInfo lineInfo = LineInfo(start, end, bounds);
    _lines.add(lineInfo);
  }

  void layout(VerticalParagraphConstraints constraints) =>
      _layout(constraints.height);

  void _layout(double height) {
    if (height == _height) {
      return;
    }
    _calculateRuns();
    _calculateLineBreaks(height);
    _calculateWidth();
    _height = height;
    _calculateIntrinsicHeight();
    print("There are ${_runs.length} runs.");
    print("There are ${_lines.length} lines.");
    print("width=$width height=$height");
    print("min=$minIntrinsicHeight max=$maxIntrinsicHeight");
  }

  void _calculateRuns() {
    if (_runs.isNotEmpty) {
      return;
    }

    final breaker = LineBreaker();
    breaker.text = _text;
    final int breakCount = breaker.computeBreaks();
    final breaks = breaker.breaks;

    int start = 0;
    int end;
    for (int i = 0; i < breakCount; i++) {
      end = breaks[i];
      _addRun(start, end);
      start = end;
    }

    end = _text.length;
    if (start < end) {
      _addRun(start, end);
    }
  }

  void _calculateLineBreaks(double maxLineLength) {
    if (_runs.isEmpty) {
      return;
    }

    if (_lines.isNotEmpty) {
      _lines.clear();
    }

    int start = 0;
    int end;
    double lineWidth = 0;
    double lineHeight = 0;
    for (int i = 0; i < _runs.length; i++) {
      end = i;
      final run = _runs[i];

      // 4
      final runWidth = run.paragraph.maxIntrinsicWidth;
      final runHeight = run.paragraph.height;

      // 5
      if (lineWidth + runWidth > maxLineLength) {
        _addLine(start, end, lineWidth, lineHeight);
        start = end;
        lineWidth = runWidth;
        lineHeight = runHeight;
      } else {
        lineWidth += runWidth;

        // 6
        lineHeight = math.max(lineHeight, run.paragraph.height);
      }
    }

    end = _runs.length;
    if (start < end) {
      _addLine(start, end, lineWidth, lineHeight);
    }
  }

  void _calculateWidth() {
    double sum = 0;
    for (LineInfo line in _lines) {
      sum += line.bounds.height;
    }
    _width = sum;
  }

  void _calculateIntrinsicHeight() {
    double sum = 0;
    double maxRunWidth = 0;
    for (TextRun run in _runs) {
      final width = run.paragraph.maxIntrinsicWidth;
      maxRunWidth = math.max(width, maxRunWidth);
      sum += width;
    }

    _minIntrinsicHeight = maxRunWidth;

    _maxIntrinsicHeight = sum;
  }

  void draw(Canvas canvas, Offset offset) {
    canvas.save();

    canvas.translate(offset.dx, offset.dy);

    canvas.rotate(math.pi / 2);

    for (LineInfo line in _lines) {
      // 3
      canvas.translate(0, -line.bounds.height);

      // 4
      double dx = 0;
      for (int i = line.textRunStart; i < line.textRunEnd; i++) {
        // 5
        canvas.drawParagraph(_runs[i].paragraph, Offset(dx, 0));
        dx += _runs[i].paragraph.longestLine;
      }
    }

    canvas.restore();
  }
}
