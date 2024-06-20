import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dj_box_shadow.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';

class DJSearchBox extends StatelessWidget {
  const DJSearchBox({
    super.key,
    this.onPressed,
    this.controller,
    this.onChanged,
    this.readOnly = false,
    this.onSearch, this.onFieldSubmitted,
  });

  final Function()? onPressed;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool readOnly;
  final Function()? onSearch;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DJColor.hFFFFFF,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: DJBoxShadow.boxShadow,
      ),
      child: TextField(
        onTap: onPressed,
        controller: controller,
        onChanged: onChanged,
        readOnly: readOnly,
        onSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0)
              .copyWith(left: 16.0, right: 6.0),
          border: InputBorder.none,
          hintText: context.l10n.searchSources,
          hintStyle: DJStyle.h14w600,
          suffixIcon: InkWell(
            onTap: onSearch,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: DJIconButton(
                icon: Assets.icons.icSearch,
                color: DJColor.h000000,
              ),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(maxHeight: 40.0),
        ),
      ),
    );
  }
}
