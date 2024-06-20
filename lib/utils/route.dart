import 'package:flutter/material.dart';

class RoutePage {
  static void push(BuildContext context, {required Widget page}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pushAndRemove(BuildContext context, {required Widget page}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
