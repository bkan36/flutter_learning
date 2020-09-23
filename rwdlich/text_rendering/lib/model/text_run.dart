import 'dart:ui' as ui show Paragraph;

class TextRun {
  TextRun(this.start, this.end, this.paragraph);

  // 1
  int start;
  int end;

  // 2
  ui.Paragraph paragraph;
}