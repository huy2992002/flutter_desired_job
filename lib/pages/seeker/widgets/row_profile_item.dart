import 'package:flutter/material.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_svg/svg.dart';

class RowProfileItem extends StatelessWidget {
  const RowProfileItem({
    super.key,
    this.onPressed,
    required this.leftIcon,
    this.title,
    this.description,
    this.rightIcon = 'assets/icons/ic_month_chevron.svg',
  });

  final Function()? onPressed;
  final String leftIcon;
  final String? title;
  final String? description;
  final String? rightIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: DJColor.hF2F2FB,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    leftIcon,
                    width: 18.0,
                    color: DJColor.h000000,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: DJStyle.h13w500,
                      ),
                    if (description != null) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        description!,
                        style: DJStyle.h11w400,
                      ),
                    ],
                  ],
                ),
              ),
              if (rightIcon != null) SvgPicture.asset(rightIcon!)
            ],
          ),
        ),
      ),
    );
  }
}
