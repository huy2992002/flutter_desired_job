import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dj_linear_gradient.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';

class DJBackgroundWelcome extends StatelessWidget {
  const DJBackgroundWelcome({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: DJLinearGradient.linearGradientColumn(
          colors: [
            DJColor.h46F11B.withOpacity(0.35),
            DJColor.hFFFFFF,
            DJColor.hFFFFFF,
            DJColor.hFFFFFF,
          ],
        ),
      ),
      child: child,
    );
  }
}
