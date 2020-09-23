import 'dart:ui';

class LineInfo {
  LineInfo(this.textRunStart, this.textRunEnd, this.bounds);

  // 1
  int textRunStart;
  int textRunEnd;

  // 2
  Rect bounds;
}