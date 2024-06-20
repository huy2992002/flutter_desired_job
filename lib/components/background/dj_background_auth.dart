import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';

class DJBackgroundAuth extends StatelessWidget {
  const DJBackgroundAuth({
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            DJColor.hFFFFFF,
            DJColor.hFFFFFF,
            DJColor.hFFFFFF,
            DJColor.h46F11B.withOpacity(0.35),
          ],
        ),
      ),
      child: child,
    );
  }
}
