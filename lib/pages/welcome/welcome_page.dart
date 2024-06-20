import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_welcome.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_text_button.dart';
import 'package:flutter_desired_job/components/text/dj_second_text.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/pages/auth/login_page.dart';
import 'package:flutter_desired_job/pages/auth/register_page.dart';
import 'package:flutter_desired_job/pages/seeker/sk_main_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: DJBackgroundWelcome(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.12),
              Image.asset(Assets.images.imgWelcome.path),
              const SizedBox(height: 14.0),
              SvgPicture.asset(Assets.icons.icLogoApp),
              DJSecondText(
                firstText: context.l10n.desired,
                secondText: context.l10n.titleJob,
                firstTextStyle: DJStyle.h25w600,
                secondTextStyle: DJStyle.h18w400,
              ),
              const SizedBox(height: 32.0),
              DJElevatedButton(
                onPressed: () =>
                    RoutePage.push(context, page: const LoginPage()),
                text: context.l10n.login,
              ),
              const SizedBox(height: 22.0),
              DJElevatedButton.outline(
                onPressed: () =>
                    RoutePage.push(context, page: const RegisterPage()),
                text: context.l10n.register,
              ),
              const Spacer(),
              DJTextButton(
                onPressed: () => RoutePage.pushAndRemove(
                  context,
                  page: const SKMainPage(),
                ),
                text: context.l10n.continueAsAGuest,
                textStyle: DJStyle.h14w400.copyWith(color: DJColor.h40573A),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
