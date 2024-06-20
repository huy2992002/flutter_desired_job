import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/components/dj_box_shadow.dart';
import 'package:flutter_desired_job/components/dj_shimmer.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';

class RecentJobItem extends StatelessWidget {
  const RecentJobItem({
    super.key,
    required this.job,
    this.onPressed,
  });

  final JobModel? job;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: DJColor.hFFFFFF,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: DJBoxShadow.boxShadow,
        ),
        child: Row(
          children: [
            DJAvatarNetwork(path: job?.business?.avatar),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job?.position ?? '-:-',
                    style: DJStyle.h14w500.copyWith(
                      color: DJColor.h9C27B0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(job?.business?.name ?? '-:-')
                ],
              ),
            ),
            (job?.getJobStatus() ?? JobStatus.expired).toStatusDisplay(context),
          ],
        ),
      ),
    );
  }
}

class StatusJob extends StatelessWidget {
  const StatusJob({
    super.key,
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: DJColor.hFFFFFF,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 11.0
        ),
      ),
    );
  }
}

class RecentJobItemLoad extends StatelessWidget {
  const RecentJobItemLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 17.0,
      ),
      decoration: BoxDecoration(
        color: DJColor.hFFFFFF,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: DJBoxShadow.boxShadow,
      ),
      child: Row(
        children: [
          DJShimmer.circular(radius: 22.0),
          const SizedBox(width: 10.0),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DJShimmer(width: 50.0, height: 17.0),
                SizedBox(height: 8.0),
                DJShimmer(width: 100.0, height: 17.0),
              ],
            ),
          ),
          DJShimmer(
            width: 52,
            height: 28,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ],
      ),
    );
  }
}
