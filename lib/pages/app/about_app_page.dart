import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DJBackgroundMain(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
            top: MediaQuery.of(context).padding.top + 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  DJIconButton(
                    onPressed: () => RoutePage.pop(context),
                    icon: Assets.icons.icChevronLeft,
                  ),
                  const SizedBox(width: 14.0),
                  DJTitle(
                    text: '${context.l10n.desired} ${context.l10n.titleJob}',
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children:  [
                    Text(
                      context.l10n.copyright,
                      style: DJStyle.h20w500,
                    ),
                    Text(context.l10n.university),
                    const SizedBox(height: 16.0),
                    Text(
                      context.l10n.aboutApp,
                      style: DJStyle.h20w500,
                    ),
                    Text(
                      context.l10n.aboutAppInfo,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
