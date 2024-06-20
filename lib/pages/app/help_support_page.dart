import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/container_profile.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/row_profile_item.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

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
                    text: context.l10n.helpAndSupport,
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      context.l10n.helpAndSupportInfo,
                      style: DJStyle.h13w500,
                    ),
                    const SizedBox(height: 6.0),
                    ContainerForm(
                      child: Column(
                        children: [
                          RowProfileItem(
                            leftIcon: Assets.icons.icEmailRound,
                            title: context.l10n.mailInfo,
                          ),
                          RowProfileItem(
                            leftIcon: Assets.icons.icPhoneRound,
                            title: context.l10n.phoneInfo,
                          ),
                        ],
                      ),
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
