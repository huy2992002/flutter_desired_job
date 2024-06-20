import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dj_input_border.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';

class DJTextField extends StatelessWidget {
  DJTextField({
    super.key,
    this.controller,
    this.onChange,
    this.color = DJColor.hF7F8F9,
    this.hintText,
    this.hintStyle = DJStyle.h16w400,
    TextStyle? floatingLabelStyle,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
    this.readOnly = false,
  }) : floatingLabelStyle = floatingLabelStyle ??
            DJStyle.h16w400.copyWith(color: DJColor.h436B49);

  final TextEditingController? controller;
  final Function(String)? onChange;
  final Color? color;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? floatingLabelStyle;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      style: DJStyle.h14w400,
      decoration: InputDecoration(
        filled: true,
        fillColor: color,
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0).copyWith(
          left: 30.0,
        ),
        border: DJInputBorder.outlineInputBorder(),
        focusedBorder: DJInputBorder.outlineInputBorder(),
        enabledBorder: DJInputBorder.outlineInputBorder(),
        errorBorder: DJInputBorder.outlineInputBorder(),
        hintText: hintText,
        labelText: hintText,
        hintStyle: hintStyle,
        floatingLabelStyle: floatingLabelStyle,
      ),
      textInputAction: textInputAction,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly,
    );
  }
}
