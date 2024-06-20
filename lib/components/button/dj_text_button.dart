import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';

class DJTextButton extends StatelessWidget {
  const DJTextButton({
    super.key,
    this.onPressed,
    required this.text,
    this.textStyle = DJStyle.h14w400,
  });

  final Function()? onPressed;
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
