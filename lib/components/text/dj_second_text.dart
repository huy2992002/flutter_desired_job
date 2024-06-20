import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';

class DJSecondText extends StatelessWidget {
  DJSecondText({
    super.key,
    this.onTap,
    required this.firstText,
    required this.secondText,
    TextStyle? firstTextStyle,
    TextStyle? secondTextStyle,
  })  : firstTextStyle =
            firstTextStyle ?? DJStyle.h16w400.copyWith(color: DJColor.h40573A),
        secondTextStyle = secondTextStyle ?? DJStyle.h16w500;

  final Function()? onTap;
  final String firstText;
  final String secondText;
  final TextStyle? firstTextStyle;
  final TextStyle? secondTextStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: firstTextStyle,
          ),
          TextSpan(
            text: secondText,
            style: secondTextStyle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
