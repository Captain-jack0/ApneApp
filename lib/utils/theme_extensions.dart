import 'package:flutter/material.dart';

extension TextThemeCompat on TextTheme {
  /// Flutter 3'te bodyText2 yerine bodyMedium kullanılıyor,
  /// bu extension eski kodların bodyText2'yi bulabilmesi için ekleniyor.
  TextStyle? get bodyText2 => bodyMedium;
}
