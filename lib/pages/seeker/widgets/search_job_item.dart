import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/components/dj_linear_gradient.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_svg/svg.dart';

class SearchJobItem extends StatelessWidget {
  const SearchJobItem({
    super.key,
    required this.job,
    required this.index,
    this.onPressed,
  });

  final JobModel? job;
  final int index;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              gradient: DJLinearGradient.linearGradientColumn(
                colors: [
                  index % 2 == 0 ? DJColor.hDF4FF6 : DJColor.hF6774F,
                  index % 2 == 0 ? DJColor.hDF4FF6 : DJColor.hF6774F,
                  index % 2 == 0 ? DJColor.hDF4FF6 : DJColor.hF6774F,
                  index % 2 == 0
                      ? DJColor.h8FE1DC.withOpacity(0.2)
                      : DJColor.hE18FCA.withOpacity(0.2)
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DJAvatarNetwork(path: job?.business?.avatar),
                    const SizedBox(width: 6.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job?.business?.name ?? '-:-',
                          style:
                              DJStyle.h15w500.copyWith(color: DJColor.hFFFFFF),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.icLocation,
                              color: DJColor.hFFFFFF,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              job?.business?.address?.location ?? '-:-',
                              style: DJStyle.h13w500
                                  .copyWith(color: DJColor.hFFFFFF),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (job?.salary != null)
                        _buildContainerInfo(
                            job!.salary?.toFormatDollar() ?? '-:-'),
                      ...List.generate(
                        job!.skills?.length ?? 0,
                        (index) {
                          return _buildContainerInfo(
                            job!.skills?[index] ?? '-:-',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  job?.content ?? '-:-',
                  style: DJStyle.h12w500.copyWith(color: DJColor.h000000),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 23.0,
              vertical: 10.0,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: DJColor.hFFFFFF,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(14.0)),
              boxShadow: [
                BoxShadow(
                    color: DJColor.h000000.withOpacity(0.1),
                    offset: const Offset(0.1, 3.0),
                    blurRadius: 2),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.icFavorite,
                    width: 20.0,
                  ),
                  const SizedBox(width: 10.0),
                  Text(job?.position ?? '-:-'),
                  const SizedBox(width: 14.0),
                  ...List.generate(
                    job?.skills?.length ?? 0,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: Text(job?.skills?[index] ?? '-:-'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildContainerInfo(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: DJColor.hFFFFFF.withOpacity(0.2),
        border: Border.all(
          color: DJColor.hFFFFFF.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Text(
        text,
        style: DJStyle.h12w500.copyWith(color: DJColor.hFFFFFF),
      ),
    );
  }
}
