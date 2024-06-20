import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/sk_job_detail.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/search_job_item.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/route.dart';

class SKAllJobPage extends StatelessWidget {
  const SKAllJobPage({super.key, required this.title, required this.jobs});

  final String title;
  final List<JobModel> jobs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DJBackgroundMain(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
            top: MediaQuery.paddingOf(context).top + 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  DJIconButton(
                    onPressed: () => RoutePage.pop(context),
                    icon: Assets.icons.icChevronLeft,
                  ),
                ],
              ),
              DJTitle(
                text: title,
                style: DJStyle.h18w400.copyWith(color: DJColor.h000000),
              ),
              const SizedBox(height: 14.0),
              const Divider(
                height: 1.0,
                thickness: 1.0,
                color: DJColor.h9C27B0,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return SearchJobItem(
                      onPressed: () => RoutePage.push(
                        context,
                        page: SKJobDetail(job: job),
                      ),
                      job: job,
                      index: index,
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
