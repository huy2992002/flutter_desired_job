import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/providers/app_provider.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = SharedPrefs.language == 'en' ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> languages = [
      context.l10n.english,
      context.l10n.vietNamese,
    ];

    List<String> flags = [
      Assets.icons.icFlagUkSvg,
      Assets.icons.icFlagVietnam,
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0)
            .copyWith(top: MediaQuery.of(context).padding.top + 10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: DJIconButton(
                onPressed: () => RoutePage.pop(context),
                icon: Assets.icons.icChevronLeft,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(context.l10n.choiceYourLanguage, style: DJStyle.h18w700),
            const SizedBox(height: 4.0),
            Text(
              context.l10n.desChangeLanguage,
              style: DJStyle.h14w500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35.0),
            ...List.generate(
              languages.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: LanguageItem(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  text: languages[index],
                  iconPath: flags[index],
                  selected: currentIndex == index,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 23).copyWith(bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DJElevatedButton.small(
              onPressed: () {
                if (currentIndex == 0) {
                  Provider.of<AppProvider>(context, listen: false)
                      .changedLocaleEn();
                  SharedPrefs.language = 'en';
                } else {
                  Provider.of<AppProvider>(context, listen: false)
                      .changedLocaleVi();
                  SharedPrefs.language = 'vi';
                }
                Navigator.pop(context);
                DJSnackBar.snackbarSuccess(
                  context,
                  title: context.l10n.changeLanguageSuccess,
                );
              },
              text: context.l10n.select,
              color: DJColor.h794ED6,
              borderColor: DJColor.h794ED6,
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    this.onTap,
    required this.text,
    required this.selected,
    required this.iconPath,
  });
  final Function()? onTap;
  final String iconPath;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 7.0,
        ),
        decoration: BoxDecoration(
          color: selected ? DJColor.h794ED6.withOpacity(0.1) : null,
          border: Border.all(
            color: selected ? DJColor.h794ED6 : DJColor.h8391A1,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              child: SvgPicture.asset(
                iconPath,
                width: 24.0,
              ),
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                text,
                style: selected
                    ? const TextStyle(
                        color: DJColor.h794ED6,
                      )
                    : null,
              ),
            ),
            Icon(
              selected ? Icons.check_circle_sharp : Icons.circle_outlined,
              size: 19,
              color: selected ? DJColor.h794ED6 : DJColor.h8391A1,
            ),
          ],
        ),
      ),
    );
  }
}
