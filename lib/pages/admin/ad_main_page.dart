import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/dj_bottom_navigation_bar.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/pages/admin/business/ad_business_page.dart';
import 'package:flutter_desired_job/pages/admin/job/ad_job_page.dart';
import 'package:flutter_desired_job/pages/admin/user/ad_user_page.dart';
import 'package:flutter_desired_job/pages/welcome/welcome_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_svg/svg.dart';

class ADMainPage extends StatefulWidget {
  const ADMainPage({super.key});

  @override
  State<ADMainPage> createState() => _ADMainPageState();
}

class _ADMainPageState extends State<ADMainPage> {
  int currentIndex = 0;

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
    List<Map<String, dynamic>> iconNav = [
      {'icon': Assets.icons.icJob, 'label': context.l10n.job},
      {'icon': Assets.icons.icGroup, 'label': context.l10n.user},
      {'icon': Assets.icons.icBusiness, 'label': context.l10n.business},
    ];

    List<Widget> pages = [
      const ADJobPage(),
      const ADUserPage(),
      const ADBusinessPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DJColor.h83C189.withOpacity(0.6),
        title: Text(
          context.l10n.admin,
          style: DJStyle.h20w500,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: _onLogout,
            child: SvgPicture.asset(Assets.icons.icLogOut),
          ),
          const SizedBox(width: 14.0),
        ],
      ),
      body: DJBackgroundMain(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: DJBottomNavigationBar(
        currentIndex: currentIndex,
        iconNav: iconNav,
        onTap: (idx) {
          setState(() => currentIndex = idx);
        },
      ),
    );
  }
}
