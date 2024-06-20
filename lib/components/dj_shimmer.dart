import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DJShimmer extends StatelessWidget {
  const DJShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(3)),
  });

  factory DJShimmer.circular({
    required double radius,
  }) {
    return DJShimmer(
      width: radius * 2,
      height: radius * 2,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  final double width;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
