
import 'package:flutter/widgets.dart';

bool _shouldUseImperialSystem(Locale locale) {
  final countryCode = locale.countryCode;
  return countryCode == 'US';
}

// 1
extension IntMeasurementConversion on int {
  int get _roundedPoundFromKg => (this * 2.20462).round();
  double get _flOzFromMl => this * 0.033814;

  // 2
  int toPoundsIfNotAlready(Locale locale) {
    if (_shouldUseImperialSystem(locale)) {
      return this;
    }

    return _roundedPoundFromKg;
  }

  double toFlOzIfNotAlready(Locale locale) {
    if (_shouldUseImperialSystem(locale)) {
      return toDouble();
    }

    return _flOzFromMl;
  }
}

extension DoubleMeasurementConversion on double {
  int get _roundedMlFromFlOz => (this * 29.5735).round();
  
  // 3
  double toMillilitersIfShouldUseMetricSystem(Locale locale) {
    if (_shouldUseImperialSystem(locale)) {
      return this;
    }

    return _roundedMlFromFlOz.toDouble();
  }
}
