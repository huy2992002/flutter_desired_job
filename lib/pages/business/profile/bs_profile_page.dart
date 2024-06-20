import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/components/dj_box_shadow.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/pages/app/change_language_page.dart';
import 'package:flutter_desired_job/pages/auth/change_password_page.dart';
import 'package:flutter_desired_job/pages/seeker/profile/sk_my_account_page.dart';
import 'package:flutter_desired_job/pages/welcome/welcome_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/utils/enum.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_svg/svg.dart';

class BSProfilePage extends StatefulWidget {
  const BSProfilePage({super.key, required this.lengthJobs});

  final int lengthJobs;

  @override
  State<BSProfilePage> createState() => _BSProfilePageState();
}

class _BSProfilePageState extends State<BSProfilePage> {
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
              top: MediaQuery.of(context).padding.top + 10.0, bottom: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconEditProfile(
                  onTap: () => RoutePage.push(
                    context,
                    page: SKMyAccountPage(
                      roleType: RoleType.roleBusiness,
                      onUpdate: () => setState(() {}),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DJAvatarNetwork(
                    path: SharedPrefs.account?.avatar,
                    width: 100.0,
                    height: 100.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            SharedPrefs.account?.name ?? '-:-',
                            style: DJStyle.h18w700,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          SharedPrefs.account?.email ?? '-:-',
                          style:
                              DJStyle.h13w500.copyWith(color: DJColor.h6B6968),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildItemProfile(
                    title: context.l10n.posted,
                    description: widget.lengthJobs.toString(),
                  ),
                  _buildItemProfile(
                    title: context.l10n.view,
                    description: 0.toString(),
                  ),
                  _buildItemProfile(
                    title: context.l10n.registrations,
                    description: 0.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: DJColor.hFFFFFF,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0),
              ),
              boxShadow: DJBoxShadow.boxShadow,
            ),
            child: Column(
              children: [
                ItemSettingProfile(
                  icon: Assets.icons.icResetPassword,
                  text: context.l10n.resetPassword,
                  onTap: () => RoutePage.push(
                    context,
                    page: const ChangePasswordPage(),
                  ),
                ),
                const DIviderProfile(),
                ItemSettingProfile(
                  icon: Assets.icons.icChangedLanguage,
                  text: context.l10n.changeLanguage,
                  onTap: () => RoutePage.push(
                    context,
                    page: const ChangeLanguagePage(),
                  ),
                ),
                const DIviderProfile(),
                ItemSettingProfile(
                  icon: Assets.icons.icLogOut,
                  text: context.l10n.logOut,
                  onTap: _onLogout,
                ),
                const DIviderProfile(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildItemProfile({
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Text(title, style: DJStyle.h16w500),
        Text(
          description,
          style: DJStyle.h16w600.copyWith(color: DJColor.h40573A),
        ),
      ],
    );
  }
}

class ItemSettingProfile extends StatelessWidget {
  const ItemSettingProfile({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final String icon;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: DJColor.hE7E3E3,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SvgPicture.asset(
              icon,
              width: 20.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              text,
              style: DJStyle.h15w500.copyWith(color: DJColor.h000000),
            ),
          ),
          SvgPicture.asset(Assets.icons.icMonthChevron),
        ],
      ),
    );
  }
}

class DIviderProfile extends StatelessWidget {
  const DIviderProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: DJColor.hE7E3E3,
      height: 24,
      thickness: 1.5,
    );
  }
}

class IconEditProfile extends StatelessWidget {
  const IconEditProfile({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: DJColor.hFFFFFF,
          borderRadius: BorderRadius.circular(8),
          boxShadow: DJBoxShadow.boxShadow,
        ),
        child: SvgPicture.asset(
          Assets.icons.icEdit,
          width: 20.0,
          height: 20.0,
          color: DJColor.h000000,
        ),
      ),
    );
  }
}
