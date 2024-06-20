import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';

class DJElevatedButton extends StatelessWidget {
  DJElevatedButton({
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    this.alignment = Alignment.center,
    this.color = DJColor.h436B49,
    this.borderColor = DJColor.h436B49,
    BorderRadius? borderRadius,
    required this.text,
    this.textColor = DJColor.hFFFFFF,
    this.isDisable = false,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(10.0);

  DJElevatedButton.outline({
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    this.alignment = Alignment.center,
    this.color = DJColor.hFFFFFF,
    this.borderColor = DJColor.h436B49,
    BorderRadius? borderRadius,
    required this.text,
    TextStyle? textStyle,
    this.isDisable = false,
  })  : borderRadius = borderRadius ?? BorderRadius.circular(10.0),
        textColor = DJColor.h436B49;

  DJElevatedButton.press({
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    this.alignment = Alignment.center,
    this.color = DJColor.h83C189,
    this.borderColor = DJColor.h83C189,
    BorderRadius? borderRadius,
    required this.text,
    this.textColor = DJColor.hFFFFFF,
    this.isDisable = false,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(10.0);

  DJElevatedButton.small({
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.alignment,
    this.color = DJColor.h436B49,
    this.borderColor = DJColor.h436B49,
    BorderRadius? borderRadius,
    required this.text,
    this.textColor = DJColor.hFFFFFF,
    this.isDisable = false,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(10.0);

  DJElevatedButton.outlineSmall({
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.alignment,
    this.color = DJColor.hFFFFFF,
    this.borderColor = DJColor.h436B49,
    BorderRadius? borderRadius,
    required this.text,
    TextStyle? textStyle,
    this.isDisable = false,
  })  : borderRadius = borderRadius ?? BorderRadius.circular(10.0),
        textColor = DJColor.h436B49;

  DJElevatedButton.pressSmall({
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.alignment,
    this.color = DJColor.h83C189,
    this.borderColor = DJColor.h83C189,
    BorderRadius? borderRadius,
    required this.text,
    this.textColor = DJColor.hFFFFFF,
    this.isDisable = false,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(10.0);

  final Function()? onPressed;
  final EdgeInsetsGeometry padding;
  final Alignment? alignment;
  final Color color;
  final Color borderColor;
  final BorderRadius borderRadius;
  final String text;
  final Color textColor;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onPressed,
              borderRadius: borderRadius,
              child: Ink(
                padding: padding,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: borderColor),
                  borderRadius: borderRadius,
                ),
                child: Center(
                  child: isDisable
                      ? SizedBox.square(
                          dimension: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: textColor,
                          ),
                        )
                      : Text(
                          text,
                          style: DJStyle.h16w600.copyWith(color: textColor),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
