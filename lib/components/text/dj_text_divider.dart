import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/button/dj_text_button.dart';

class DJTextDivider extends StatelessWidget {
  const DJTextDivider({
    super.key,
    this.onPressed,
    required this.text,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
  });

  final Function()? onPressed;
  final String text;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.5,
          width: size.width / 2 - 40 - 80,
          color: Colors.black,
        ),
        Padding(
            padding: padding,
            child: DJTextButton(
              onPressed: onPressed,
              text: text,
            )),
        Container(
          height: 0.5,
          width: size.width / 2 - 40 - 80,
          color: Colors.black,
        ),
      ],
    );
  }
}
