import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/dj_bottom_navigation_bar.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/pages/seeker/favorite/sk_favorite_page.dart';
import 'package:flutter_desired_job/pages/seeker/home/sk_home_page.dart';
import 'package:flutter_desired_job/pages/seeker/profile/sk_profile_page.dart';
import 'package:flutter_desired_job/pages/seeker/search/sk_search_page.dart';
import 'package:flutter_desired_job/utils/extension.dart';

class SKMainPage extends StatefulWidget {
  const SKMainPage({super.key});

  @override
  State<SKMainPage> createState() => _SKMainPageState();
}

class _SKMainPageState extends State<SKMainPage> {
  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      SKHomePage(onSearch: () => changeCurrentIndex(1)),
      const SKSearchPage(),
      const SKFavoritePage(),
      SKProfilePage(onChangeFavorite: () => changeCurrentIndex(2)),
    ];

    List<Map<String, dynamic>> iconNav = [
      {'icon': Assets.icons.icHome, 'label': context.l10n.home},
      {'icon': Assets.icons.icSearch, 'label': context.l10n.search},
      {'icon': Assets.icons.icClipboard, 'label': context.l10n.favorite},
      {'icon': Assets.icons.icUser, 'label': context.l10n.profile},
    ];

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          body: DJBackgroundMain(
            child: pages[currentIndex],
          ),
          bottomNavigationBar: DJBottomNavigationBar(
            currentIndex: currentIndex,
            iconNav: iconNav,
            onTap: (idx) {
              setState(() => currentIndex = idx);
            },
          )),
    );
  }
}
