import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dj_input_border.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_svg/svg.dart';

class DJTextFieldPassword extends StatefulWidget {
  DJTextFieldPassword({
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

  @override
  State<DJTextFieldPassword> createState() => _DJTextFieldPasswordState();
}

class _DJTextFieldPasswordState extends State<DJTextFieldPassword> {
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.color,
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0).copyWith(
          left: 30.0,
        ),
        border: DJInputBorder.outlineInputBorder(),
        focusedBorder: DJInputBorder.outlineInputBorder(),
        enabledBorder: DJInputBorder.outlineInputBorder(),
        errorBorder: DJInputBorder.outlineInputBorder(),
        hintText: widget.hintText,
        labelText: widget.hintText,
        hintStyle: widget.hintStyle,
        floatingLabelStyle: widget.floatingLabelStyle,
        suffixIcon: GestureDetector(
          onTap: () => setState(() => isShowPassword = !isShowPassword),
          child: SvgPicture.asset(
            isShowPassword ? Assets.icons.icEye : Assets.icons.icEyePassword,
            color: DJColor.h837C77,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 20.0,
          minWidth: 44.0,
        ),
      ),
      obscureText: isShowPassword,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
