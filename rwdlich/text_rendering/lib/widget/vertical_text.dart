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

import 'package:flutter/widgets.dart';
import 'package:steppe_up/widget/render_vertical_text.dart';

/// A widget that displays text in vertical lines which wrap from left to right.
///
/// The text string and style are passed in with the [text] argument as a
/// [TextSpan]. The current implementation only uses the top level text and style
/// in the TextSpan. Any children in the TextSpan are ignored. Thus this widget
/// behaves similarly to the Flutter [Text] widget, even though it takes a
/// TextSpan like a [RichText] widget.
class VerticalText extends LeafRenderObjectWidget {
  const VerticalText({
    Key key,
    this.text,
  }) : super(key: key);

  final TextSpan text;

  @override
  RenderVerticalText createRenderObject(BuildContext context) {
    return RenderVerticalText(text);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderVerticalText renderObject) {
    renderObject.text = text;
  }
}
