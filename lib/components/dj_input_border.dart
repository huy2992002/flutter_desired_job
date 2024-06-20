import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';

class DJInputBorder {
  DJInputBorder._();

  static OutlineInputBorder outlineInputBorder({Color? color, double? radius}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? DJColor.hE7E3E3),
      borderRadius: BorderRadius.circular(radius ?? 10.0),
    );
  }
}
