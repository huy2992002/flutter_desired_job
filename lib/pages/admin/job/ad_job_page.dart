import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/recent_job_item.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/sk_job_detail.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ADJobPage extends StatefulWidget {
  const ADJobPage({super.key});

  @override
  State<ADJobPage> createState() => _ADJobPageState();
}

class _ADJobPageState extends State<ADJobPage> {
  JobService jobService = JobService();
  List<JobModel> jobs = [];
  bool isLoading = false;

  @override
  void initState() {
    _getAllJob();
    super.initState();
  }

  Future<void> _getAllJob() async {
    setState(() => isLoading = true);
    jobs = await jobService.getJobs() ?? [];
    jobs.sort(
      (a, b) => DateTime.parse(b.createdAt ?? '2021-01-01').compareTo(
        DateTime.parse(a.createdAt ?? '2021-01-01'),
      ),
    );
    setState(() => isLoading = false);
  }

  Future<void> _removeJob(JobModel job) async {
    DJDiaLog.dialogQuestion(
      context,
      title: context.l10n.alert,
      content: context.l10n.doYouWantRemovePost,
      action: () {
        Navigator.pop(context);
        DJDiaLog.dialogLoading(
          context,
          title: context.l10n.processing,
          action: () async {
            if (job.id != null) {
              await jobService.removeJob(job.id!);
              jobs.remove(job);
              setState(() {});
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 20.0,
          ),
          child: Text(context.l10n.adminJob, style: DJStyle.h18w700),
        ),
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: DJColor.h436B49,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _getAllJob,
                  child: SlidableAutoCloseBehavior(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.25,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  _removeJob(job);
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
                      itemCount: jobs.length,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
