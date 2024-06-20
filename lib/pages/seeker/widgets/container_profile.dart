import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dj_box_shadow.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';

class ContainerForm extends StatelessWidget {
  const ContainerForm({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: DJColor.hFFFFFF,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: DJBoxShadow.boxShadow,
      ),
      child: child,
    );
  }
}
