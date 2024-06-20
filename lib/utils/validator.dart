import 'package:flutter/material.dart';
import 'package:flutter_desired_job/utils/extension.dart';

class Validator {
  static String? validatorRequired(BuildContext context,
      {required dynamic value}) {
    if (value!.isEmpty) {
      return context.l10n.fieldIsRequired;
    }
    return null;
  }

  static String? validatorPhone(BuildContext context,
      {required dynamic value}) {
    if (value!.isEmpty) {
      return context.l10n.fieldIsRequired;
    }
    const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return context.l10n.validPhone;
    }
    return null;
  }

  static String? validatorEmail(BuildContext context,
      {required dynamic value}) {
    if (value!.isEmpty) {
      return context.l10n.fieldIsRequired;
    }
    const pattern =
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return context.l10n.validEmail;
    }
    return null;
  }

  static String? validatorPassword(BuildContext context,
      {required dynamic value}) {
    if (value!.isEmpty) {
      return context.l10n.fieldIsRequired;
    }
    if ((value as String).length < 6) {
      return context.l10n.validPassword;
    }
    return null;
  }

  static String? validatorConfirmPassword(BuildContext context,
      {required dynamic value, required String password}) {
    if (value!.isEmpty) {
      return context.l10n.fieldIsRequired;
    }
    if ((value as String).length < 6) {
      return context.l10n.validPassword;
    }
    if (value != password) {
      return context.l10n.validConfirmPassword;
    }
    return null;
  }
}
