import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/pages/app/change_language_page.dart';
import 'package:flutter_desired_job/pages/app/help_support_page.dart';
import 'package:flutter_desired_job/pages/app/page_not_user.dart';
import 'package:flutter_desired_job/pages/auth/change_password_page.dart';
import 'package:flutter_desired_job/pages/seeker/profile/sk_my_account_page.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/container_profile.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/row_profile_item.dart';
import 'package:flutter_desired_job/pages/welcome/welcome_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class SKProfilePage extends StatefulWidget {
  const SKProfilePage({super.key, this.onChangeFavorite});

  final Function()? onChangeFavorite;

  @override
  State<SKProfilePage> createState() => _SKProfilePageState();
}

class _SKProfilePageState extends State<SKProfilePage> {
  AccountModel? account = SharedPrefs.account;

  @override
  void initState() {
    super.initState();
  }

  void _onLogout() {
    DJDiaLog.dialogQuestion(
      context,
      title: context.l10n.alert,
      content: context.l10n.doYouWantLogout,
      action: () {
        SharedPrefs.removeUserLogin();
        RoutePage.pushAndRemove(
          context,
          page: const WelcomePage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return account == null
        ? const PageNotUser()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.paddingOf(context).top + 10.0, bottom: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DJTitle(text: context.l10n.profile),
                  const SizedBox(height: 24.0),
                  ContainerForm(
                    child: Column(
                      children: [
                        RowProfileItem(
                          onPressed: () => RoutePage.push(
                            context,
                            page: const SKMyAccountPage(),
                          ),
                          leftIcon: Assets.icons.icUser,
                          title: context.l10n.myAccount,
                          description: context.l10n.makeChangesToYourAccount,
                        ),
                        RowProfileItem(
                          onPressed: widget.onChangeFavorite,
                          leftIcon: Assets.icons.icBookmarkOutline,
                          title: context.l10n.favorite,
                          description: context.l10n.favoritesList,
                        ),
                        RowProfileItem(
                          onPressed: () => RoutePage.push(
                            context,
                            page: const ChangePasswordPage(),
                          ),
                          leftIcon: Assets.icons.icResetPassword,
                          title: context.l10n.changePassword,
                          description: context.l10n.furtherSecureYourAccount,
                        ),
                        RowProfileItem(
                          leftIcon: Assets.icons.icShieldDone,
                          title: context.l10n.myCV,
                          description: context.l10n.manageYourDeviceSecurity,
                        ),
                        RowProfileItem(
                          onPressed: () => RoutePage.push(
                            context,
                            page: const ChangeLanguagePage(),
                          ),
                          leftIcon: Assets.icons.icChangedLanguage,
                          title: context.l10n.changeLanguage,
                          description: context.l10n.desChangeLanguage,
                        ),
                        RowProfileItem(
                          onPressed: _onLogout,
                          leftIcon: Assets.icons.icLogOut,
                          title: context.l10n.logOut,
                          rightIcon: null,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      context.l10n.more,
                      style: DJStyle.h14w500.copyWith(color: DJColor.h000000),
                    ),
                  ),
                  ContainerForm(
                    child: Column(
                      children: [
                        RowProfileItem(
                          onPressed: () => RoutePage.push(
                            context,
                            page: const HelpSupportPage(),
                          ),
                          leftIcon: Assets.icons.icNotification,
                          title: context.l10n.helpAndSupport,
                        ),
                        // RowProfileItem(
                        //   onPressed: () => RoutePage.push(
                        //     context,
                        //     page: const AboutAppPage(),
                        //   ),
                        //   leftIcon: Assets.icons.icHeart,
                        //   title: context.l10n.aboutApp,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
