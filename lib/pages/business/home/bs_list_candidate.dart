import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/cv_model.dart';
import 'package:flutter_desired_job/pages/admin/widgets/account_item.dart';
import 'package:flutter_desired_job/pages/business/home/bs_detail_candidate.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class BSListCandidate extends StatelessWidget {
  const BSListCandidate({super.key, required this.cvs});

  final List<CVModel> cvs;

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
              DJTitle(text: context.l10n.listCandidate),
              const SizedBox(height: 15.0),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: cvs.length,
                  itemBuilder: (context, index) {
                    final user = cvs[index].user;
                    return AccountItem(
                      onTap: () => RoutePage.push(
                        context,
                        page: BSDetailCandidate(cv: cvs[index]),
                      ),
                      avatar: user?.avatar ?? '',
                      name: user?.name ?? '',
                      email: user?.email ?? '',
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
