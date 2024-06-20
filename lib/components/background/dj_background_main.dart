import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';

class DJBackgroundMain extends StatelessWidget {
  const DJBackgroundMain({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: DJColor.hD5EFD8.withOpacity(0.3),
          ),
        ),
        Positioned(
          top: -26,
          right: -60,
          child: CircleAvatar(
            radius: 110,
            backgroundColor: DJColor.hD5EFD8.withOpacity(0.5),
          ),
        ),
        Positioned(
          top: 135,
          left: 12,
          child: CircleAvatar(
            radius: 78,
            backgroundColor: DJColor.h6DD031.withOpacity(0.2),
          ),
        ),
        Positioned(
          top: 450,
          right: 61,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: DJColor.h3EA248.withOpacity(0.2),
          ),
        ),
        Positioned(
          top: 470,
          left: -50,
          child: CircleAvatar(
            radius: 78,
            backgroundColor: DJColor.h3EA248.withOpacity(0.2),
          ),
        ),
        Positioned.fill(child: child ?? Container()),
      ],
    );
  }
}
