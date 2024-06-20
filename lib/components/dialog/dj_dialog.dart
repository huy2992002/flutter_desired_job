import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';
import 'package:flutter_svg/svg.dart';

class DJDiaLog {
  DJDiaLog._();

  static void dialogAlert(
    BuildContext context, {
    String? image,
    required String title,
    String? content,
    String? textButton,
    bool? barrierDismissible,
    Function()? action,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                image ?? Assets.icons.icSuccessMark,
                width: 100.0,
              ),
              const SizedBox(height: 20.0),
              Text(title, style: DJStyle.h20w500, textAlign: TextAlign.center),
              const SizedBox(height: 10.0),
              if (content != null) ...[
                Text(
                  content,
                  style: DJStyle.h14w500,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25.0),
              ],
              DJElevatedButton.small(
                onPressed: action == null
                    ? () => RoutePage.pop(context)
                    : () {
                        action.call();
                      },
                text: textButton ?? context.l10n.cancel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void dialogError(
    BuildContext context, {
    required String title,
    String? content,
    String? textButton,
    Function()? action,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.icons.icErrorMark,
                width: 100.0,
              ),
              const SizedBox(height: 20.0),
              Text(
                title,
                style: DJStyle.h20w500.copyWith(color: DJColor.hF6774F),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              if (content != null) ...[
                Text(
                  content,
                  style: DJStyle.h14w500,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25.0),
              ],
              DJElevatedButton.small(
                onPressed: action == null
                    ? () => RoutePage.pop(context)
                    : () {
                        action.call();
                      },
                color: DJColor.hFFFFFF,
                borderColor: DJColor.hF6774F,
                text: textButton ?? context.l10n.cancel,
                textColor: DJColor.hF6774F,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void dialogQuestion(
    BuildContext context, {
    required String title,
    required String content,
    String? textButton,
    Function()? action,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: DJStyle.h20w500.copyWith(color: DJColor.hFF0000),
              ),
              const SizedBox(height: 4.0),
              Text(
                content,
                style: DJStyle.h15w500.copyWith(color: DJColor.h000000),
              ),

              // const SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(context.l10n.cancel),
              //     SizedBox(width: 6.0),
              //     Text(context.l10n.yes),
              //     // Expanded(
              //     //   child: DJElevatedButton.small(
              //     //     onPressed: () => RoutePage.pop(context),
              //     //     alignment: Alignment.center,
              //     //     color: DJColor.hFFFFFF,
              //     //     borderColor: DJColor.hFF0000,
              //     //     text: context.l10n.cancel,
              //     //     textColor: DJColor.hFF0000,
              //     //   ),
              //     // ),
              //     // const SizedBox(width: 16.0),
              //     // Expanded(
              //     //   child: DJElevatedButton.small(
              //     //     onPressed: () => action?.call(),
              //     //     alignment: Alignment.center,
              //     //     color: DJColor.hFFFFFF,
              //     //     text: context.l10n.yes,
              //     //     textColor: DJColor.h436B49,
              //     //   ),
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () => RoutePage.pop(context),
            child: Text(
              context.l10n.cancel.toUpperCase(),
              style: DJStyle.h13w600,
            ),
          ),
          const SizedBox(width: 8.0),
          InkWell(
            onTap: () => action?.call(),
            child: Text(
              context.l10n.yes.toUpperCase(),
              style: DJStyle.h13w600,
            ),
          ),
        ],
      ),
    );
  }

  static void dialogLoading(
    BuildContext context, {
    required String title,
    Color? colorLoading,
    Future Function()? action,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(color: DJColor.hFFFFFF),
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircularProgressIndicator(
                color: colorLoading ?? DJColor.h436B49,
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Text(title, style: DJStyle.h16w500),
              )
            ],
          ),
        ),
      ),
    );
    await action?.call();
  }

  static void dialogAddAccount(
    BuildContext context, {
    required String title,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController emailController,
    required TextEditingController passController,
    Function()? action,
  }) {
    final formKey = GlobalKey<FormState>();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, process) {
            return AlertDialog(
              title: Text(title),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFieldDialog(
                        controller: nameController,
                        hintText: context.l10n.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            Validator.validatorRequired(context, value: value),
                      ),
                      const SizedBox(height: 8.0),
                      TextFieldDialog(
                        controller: phoneController,
                        hintText: context.l10n.phoneNumber,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            Validator.validatorPhone(context, value: value),
                      ),
                      const SizedBox(height: 8.0),
                      TextFieldDialog(
                        controller: emailController,
                        hintText: context.l10n.email,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            Validator.validatorEmail(context, value: value),
                      ),
                      const SizedBox(height: 8.0),
                      TextFieldDialog(
                        controller: passController,
                        hintText: context.l10n.hintPassword,
                        validator: (value) =>
                            Validator.validatorPassword(context, value: value),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    action?.call();
                  },
                  child: Text(
                    context.l10n.save,
                    style:
                        const TextStyle(color: DJColor.h794ED6, fontSize: 16.0),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.l10n.cancel,
                      style: const TextStyle(fontSize: 16.0)),
                ),
              ],
            );
          });
        });
  }
}

class TextFieldDialog extends StatelessWidget {
  const TextFieldDialog({
    super.key,
    this.controller,
    this.hintText,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
  });

  final TextEditingController? controller;
  final String? hintText;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintText: hintText,
      ),
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
