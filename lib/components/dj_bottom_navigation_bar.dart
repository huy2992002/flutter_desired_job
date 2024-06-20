import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_svg/svg.dart';

class DJBottomNavigationBar extends StatelessWidget {
  const DJBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.iconNav,
    required this.onTap,
  });

  final int currentIndex;
  final List<Map<String, dynamic>> iconNav;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        for (int i = 0; i <= iconNav.length - 1; i++)
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: currentIndex == i ? 1.1 : 1.0,
              child: SvgPicture.asset(
                iconNav[i]['icon'],
                width: 22,
                height: 22,
                color: currentIndex == i ? DJColor.h436B49 : DJColor.h000000,
              ),
            ),
            label: iconNav[i]['label'],
          ),
      ],
      selectedLabelStyle: DJStyle.h11w400,
      unselectedLabelStyle: DJStyle.h11w400,
      selectedItemColor: DJColor.h436B49,
      unselectedItemColor: DJColor.h000000,
    );
  }
}
