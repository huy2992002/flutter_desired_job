import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class DJCodeTextField extends StatelessWidget {
  const DJCodeTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onCompleted,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      appContext: context,
      textStyle: const TextStyle(color: DJColor.h000000),
      length: 4,
      cursorColor: DJColor.h000000,
      cursorHeight: 16.0,
      cursorWidth: 2.0,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.6),
        fieldHeight: 60.0,
        fieldWidth: 50.0,
        activeFillColor: DJColor.h000000,
        inactiveColor: DJColor.h000000,
        activeColor: DJColor.h000000,
        selectedColor: DJColor.h000000,
      ),
      scrollPadding: EdgeInsets.zero,
      // onEditingComplete: () {
      //   verificationCodeController.clear();
      //   focusNode.unfocus();
      // },
      onCompleted: onCompleted,
    );
  }
}
