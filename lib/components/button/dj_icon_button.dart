import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_svg/svg.dart';

class DJIconButton extends StatelessWidget {
  const DJIconButton({
    super.key,
    this.onPressed,
    this.width,
    this.padding = const EdgeInsets.all(7.7),
    this.color = DJColor.hFFFFFF,
    this.borderColor = DJColor.h6B6968,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    required this.icon,
    this.iconColor,
  });

  const DJIconButton.socialMedia({
    super.key,
    this.onPressed,
    this.width = 105.0,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0),
    this.color = DJColor.hFFFFFF,
    this.borderColor = DJColor.hFFFFFF,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    required this.icon,
    this.iconColor,
  });

  final Function()? onPressed;
  final double? width;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color borderColor;
  final BorderRadius borderRadius;
  final String icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Ink(
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor),
            borderRadius: borderRadius,
          ),
          child: SvgPicture.asset(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
