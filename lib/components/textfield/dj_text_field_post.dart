import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';

class DJTextFieldPost extends StatelessWidget {
  const DJTextFieldPost({
    super.key,
    this.isRequired = false,
    required this.title,
    this.controller,
    this.icon,
    this.readOnly = false,
    this.textInputType,
    this.onChanged,
    this.textInputAction,
  });

  final bool isRequired;
  final String title;
  final TextEditingController? controller;
  final Widget? icon;
  final bool readOnly;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Row(
            children: [
              Text(
                title,
                style: DJStyle.h13w500.copyWith(color: DJColor.h6B6968),
              ),
              if (isRequired)
                Text(
                  '*',
                  style: DJStyle.h13w500.copyWith(color: DJColor.hD65745),
                ),
            ],
          ),
        ),
        TextField(
          controller: controller,
          style: DJStyle.h12w500.copyWith(color: DJColor.h000000),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            border: _buildOutlineBorder(),
            focusedBorder: _buildOutlineBorder(),
            enabledBorder: _buildOutlineBorder(),
            suffixIcon: icon,
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 18.0, minWidth: 40.0),
          ),
          onChanged: onChanged,
          keyboardType: textInputType,
          readOnly: readOnly,
          textInputAction: textInputAction,
        ),
      ],
    );
  }

  OutlineInputBorder _buildOutlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(color: DJColor.h6B6968),
    );
  }
}
