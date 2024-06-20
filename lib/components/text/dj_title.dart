import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';

class DJTitle extends StatelessWidget {
  const DJTitle({
    super.key,
    required this.text,
    this.description,
    this.style,
  });

  final String text;
  final String? description;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: style ?? DJStyle.h25w600),
        if (description != null) ...[
          const SizedBox(height: 10.0),
          Text(
            description!,
            style: DJStyle.h16w500.copyWith(color: DJColor.h8391A1),
          ),
        ]
      ],
    );
  }
}
