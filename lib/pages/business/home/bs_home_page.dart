import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/recent_job_item.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/sk_job_detail.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BSHomePage extends StatefulWidget {
  const BSHomePage({
    super.key,
    required this.businessJobs,
    this.isLoading = false,
    this.refresh,
  });

  final List<JobModel> businessJobs;
  final bool isLoading;
  final Function()? refresh;

  @override
  State<BSHomePage> createState() => _BSHomePageState();
}

class _BSHomePageState extends State<BSHomePage> {
  JobService jobService = JobService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
        top: MediaQuery.of(context).padding.top + 10.0,
        bottom: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                (SharedPrefs.account?.name ?? '').toUpperCase(),
                style: DJStyle.h25w600,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              DJAvatarNetwork(
                path: SharedPrefs.account?.avatar,
                width: 52,
                height: 52,
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            context.l10n.allBusinessJob,
            style: DJStyle.h16w500,
          ),
          Expanded(
            child: widget.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: DJColor.h26E543,
                    ),
                  )
                : widget.businessJobs.isEmpty
                    ? Center(
                        child: Text(
                          context.l10n.haveNotPostJob,
                          style:
                              DJStyle.h16w500.copyWith(color: DJColor.h26E543),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          widget.refresh?.call();
                        },
                        child: SlidableAutoCloseBehavior(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 8.0,
                            ),
                            itemCount: widget.businessJobs.length,
                            itemBuilder: (context, index) {
                              final job = widget.businessJobs[index];
                              return Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.25,
                                  motion: const ScrollMotion(),
                                  children: [
                                    const SizedBox(width: 4.0),
                                    SlidableAction(
                                      onPressed: (_) {
                                        DJDiaLog.dialogQuestion(
                                          context,
                                          title: context.l10n.alert,
                                          content:
                                              context.l10n.doYouWantRemovePost,
                                          action: () {
                                            Navigator.pop(context);
                                            DJDiaLog.dialogLoading(
                                              context,
                                              title: context.l10n.processing,
                                              action: () async {
                                                if (job.id != null) {
                                                  await jobService
                                                      .removeJob(job.id!);
                                                  widget.businessJobs.remove(job);
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        );
                                      },
                                      backgroundColor: DJColor.hD65745,
                                      foregroundColor: DJColor.hFFFFFF,
                                      icon: Icons.delete,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ],
                                ),
                                child: RecentJobItem(
                                  onPressed: () => RoutePage.push(
                                    context,
                                    page: SKJobDetail(job: job),
                                  ),
                                  job: job,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10.0),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
