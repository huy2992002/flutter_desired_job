import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_welcome.dart';
import 'package:flutter_desired_job/components/text/dj_second_text.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/pages/admin/ad_main_page.dart';
import 'package:flutter_desired_job/pages/business/bs_main_page.dart';
import 'package:flutter_desired_job/pages/seeker/sk_main_page.dart';
import 'package:flutter_desired_job/pages/welcome/welcome_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    switchPage();
  }

  void switchPage() {
    Timer(const Duration(milliseconds: 2600), () {
      bool check = SharedPrefs.account == null;
      if (check) {
        RoutePage.pushAndRemove(
          context,
          page: const WelcomePage(),
        );
      } else {
        if (SharedPrefs.account!.role == 0) {
          RoutePage.pushAndRemove(context, page: const SKMainPage());
        } else if (SharedPrefs.account!.role == 1) {
          RoutePage.pushAndRemove(context, page: const BSMainPage());
        } else {
          RoutePage.pushAndRemove(context, page: const ADMainPage());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: DJBackgroundWelcome(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.icons.icLogoApp,
                width: size.width * 0.5,
              ),
              const SizedBox(height: 10.0),
              Shimmer.fromColors(
                baseColor: DJColor.h000000,
                highlightColor: DJColor.h26E543,
                child: DJSecondText(
                  firstText: context.l10n.desired,
                  secondText: context.l10n.titleJob,
                  firstTextStyle: DJStyle.h30w600,
                  secondTextStyle: DJStyle.h20w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
