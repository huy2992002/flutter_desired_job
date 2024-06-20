import 'package:flutter/material.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DJSnackBar {
  static void snackbarDefault(
    BuildContext context, {
    required String title,
    Color? color,
    String? iconPath,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: color ?? DJColor.h6B6968,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath ?? Assets.icons.icTick,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: DJColor.hFFFFFF,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void snackbarSuccess(
    BuildContext context, {
    required String title,
  }) {
    snackbarDefault(
      context,
      title: title,
      color: DJColor.h55B938,
    );
  }

  static void snackbarError(
    BuildContext context, {
    required String title,
  }) {
    snackbarDefault(
      context,
      title: title,
      color: DJColor.hD65745,
      iconPath: Assets.icons.icError,
    );
  }

  static void snackbarWarning(
    BuildContext context, {
    required String title,
  }) {
    snackbarDefault(
      context,
      title: title,
      color: DJColor.hEAC645,
      iconPath: Assets.icons.icWarning,
    );
  }
}
