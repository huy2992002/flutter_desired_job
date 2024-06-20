import 'package:flutter/material.dart';

class DJLinearGradient {
  static LinearGradient linearGradientColumn({required List<Color> colors}) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors
    );
  }
}
