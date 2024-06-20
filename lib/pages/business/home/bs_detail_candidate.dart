import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/cv_model.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class BSDetailCandidate extends StatefulWidget {
  const BSDetailCandidate({super.key, required this.cv});
  final CVModel cv;

  @override
  State<BSDetailCandidate> createState() => _BSDetailCandidateState();
}

class _BSDetailCandidateState extends State<BSDetailCandidate> {
  TextEditingController introduceController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController stretchController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    introduceController.text = widget.cv.introduce ?? '';
    educationController.text = widget.cv.education ?? '';
    stretchController.text = widget.cv.strengths ?? '';
    emailController.text = widget.cv.user?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DJBackgroundMain(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
            top: MediaQuery.paddingOf(context).top + 6,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DJIconButton(
                onPressed: () => RoutePage.pop(context),
                icon: Assets.icons.icChevronLeft,
              ),
              DJTitle(text: context.l10n.candidate),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  DJAvatarNetwork(
                    path: widget.cv.user?.avatar,
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cv.user?.name ?? '',
                          style: DJStyle.h18w400,
                        ),
                        TextFieldCopy(
                          controller: emailController,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                context.l10n.introduceYourself,
                style: DJStyle.h18w700,
              ),
              TextFieldCopy(
                controller: introduceController,
              ),
              const SizedBox(height: 10.0),
              Text(
                context.l10n.education,
                style: DJStyle.h18w700,
              ),
              TextFieldCopy(
                controller: educationController,
              ),
              const SizedBox(height: 10.0),
              Text(
                context.l10n.strengths,
                style: DJStyle.h18w700,
              ),
              TextFieldCopy(
                controller: stretchController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldCopy extends StatelessWidget {
  const TextFieldCopy({
    super.key,
    this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: DJStyle.h16w400,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        border: InputBorder.none,
      ),
      readOnly: true,
    );
  }
}
