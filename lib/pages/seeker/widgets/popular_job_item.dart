import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/components/dj_linear_gradient.dart';
import 'package:flutter_desired_job/components/dj_shimmer.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';

class PopularJobItem extends StatelessWidget {
  const PopularJobItem({
    super.key,
    this.onPressed,
    required this.job,
  });

  final Function()? onPressed;
  final JobModel? job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: DJLinearGradient.linearGradientColumn(
            colors: [
              DJColor.h26E543,
              DJColor.h9EC395,
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        constraints: const BoxConstraints(minWidth: 224),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DJAvatarNetwork(
                  path: job?.business?.avatar,
                  width: 44,
                  height: 44,
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job?.position ?? '-:-',
                      style: DJStyle.h16w600.copyWith(color: DJColor.h000000),
                    ),
                    Text(
                      job?.business?.name ?? '-:-',
                      style: DJStyle.h16w500,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: List.generate(job?.levels?.length ?? 0, (index) {
                String? level = job?.levels?[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: DJColor.hFFFFFF,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      level ?? '-:-',
                      style: DJStyle.h13w500,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10.0),
            if (job?.salary != null)
              Row(
                children: [
                  Text(
                    context.l10n.salary,
                    style: DJStyle.h13w600,
                  ),
                  Text(
                    job?.salary?.toFormatDollar() ?? '-:-',
                    style: DJStyle.h12w500.copyWith(
                      color: DJColor.h000000,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class PopularJobItemLoad extends StatelessWidget {
  const PopularJobItemLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 152,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: DJLinearGradient.linearGradientColumn(
          colors: [
            DJColor.h26E543,
            DJColor.h9EC395,
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DJShimmer.circular(radius: 22.0),
              const SizedBox(width: 10.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DJShimmer(width: 74.0, height: 19.0),
                  SizedBox(height: 10.0),
                  DJShimmer(width: 110.0, height: 16.0),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          const Row(
            children: [
              DJShimmer(width: 60.0, height: 22.0),
              SizedBox(width: 6.0),
              DJShimmer(width: 80.0, height: 22.0),
            ],
          ),
        ],
      ),
    );
  }
}
