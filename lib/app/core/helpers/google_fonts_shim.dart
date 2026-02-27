import 'package:flutter/material.dart';

class GoogleFonts {
  static TextStyle montserrat({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextTheme montserratTextTheme([TextTheme? base]) {
    return base ?? TextTheme();
  }
}
