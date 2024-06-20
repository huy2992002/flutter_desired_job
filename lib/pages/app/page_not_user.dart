import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/pages/auth/login_page.dart';
import 'package:flutter_desired_job/pages/auth/register_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class PageNotUser extends StatelessWidget {
  const PageNotUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 70.0),
          Text(
            context.l10n.youWantToLookJob,
            style: DJStyle.h25w600.copyWith(color: DJColor.h46F11B),
          ),
          const SizedBox(height: 10.0),
          DJElevatedButton.outlineSmall(
            onPressed: () => RoutePage.push(context, page: const LoginPage()),
            text: context.l10n.login,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(context.l10n.or, style: DJStyle.h17w400),
          ),
          DJElevatedButton.small(
            onPressed: () =>
                RoutePage.push(context, page: const RegisterPage()),
            text: context.l10n.register,
          ),
        ],
      ),
    );
  }
}
