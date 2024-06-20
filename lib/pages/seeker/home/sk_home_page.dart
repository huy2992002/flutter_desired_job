import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/components/textfield/dj_search_box.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/auth/login_page.dart';
import 'package:flutter_desired_job/pages/seeker/profile/sk_my_account_page.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/sk_all_jobs_page.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/sk_job_detail.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/popular_job_item.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/recent_job_item.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_svg/svg.dart';

class SKHomePage extends StatefulWidget {
  const SKHomePage({super.key, this.onSearch});

  final VoidCallback? onSearch;

  @override
  State<SKHomePage> createState() => _SKHomePageState();
}

class _SKHomePageState extends State<SKHomePage> {
  JobService jobServices = JobService();
  List<JobModel> jobs = [];
  List<JobModel> popularJobs = [];
  List<JobModel> recentJobs = [];
  bool isLoadPopular = false;
  bool isLoadRecent = false;

  @override
  void initState() {
    super.initState();
    _getJobs();
  }

  void _getJobs() async {
    setState(() {
      isLoadPopular = false;
      isLoadRecent = false;
    });
    jobs = await jobServices.getJobs().catchError((onError) {
          DJDiaLog.dialogError(context, title: context.l10n.errorInternet);
        }) ??
        [];
    print('object ${jobs.length}');
    popularJobs = jobs
        .where((element) => element.getJobStatus() == JobStatus.open)
        .toList();
    setState(() => isLoadPopular = true);
    print('object ${popularJobs.length}');

    recentJobs = jobs
        .where((element) => element.getJobStatus() == JobStatus.open)
        .toList();
    recentJobs.sort(
      (a, b) => DateTime.parse(b.createdAt ?? '2021-01-01').compareTo(
        DateTime.parse(a.createdAt ?? '2021-01-01'),
      ),
    );

    setState(() => isLoadRecent = true);
  }

  void onTapNotUser() {
    DJDiaLog.dialogAlert(
      context,
      image: Assets.icons.icLogoApp,
      title: context.l10n.youWantToLookJob,
      textButton: context.l10n.login,
      action: () {
        Navigator.pop(context);
        RoutePage.push(
          context,
          page: const LoginPage(isNotBack: true),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SharedPrefs.account == null
                    ? _buildAppBarNotUser()
                    : _buildAppBarHome(),
                const SizedBox(height: 20.0),
                DJSearchBox(
                  onPressed: widget.onSearch,
                  readOnly: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _getJobs();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _buildTitleHome(
                      onPressed: SharedPrefs.account == null
                          ? onTapNotUser
                          : () {
                              RoutePage.push(
                                context,
                                page: SKAllJobPage(
                                  title: context.l10n.allPopularJob,
                                  jobs: popularJobs,
                                ),
                              );
                            },
                      title: context.l10n.popularJob,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: List.generate(
                              !isLoadPopular
                                  ? 6
                                  : (popularJobs.length) < 6
                                      ? (popularJobs.length)
                                      : 6, (index) {
                            if (isLoadPopular) {
                              final job = popularJobs[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: PopularJobItem(
                                  onPressed: SharedPrefs.account == null
                                      ? onTapNotUser
                                      : () {
                                          RoutePage.push(
                                            context,
                                            page: SKJobDetail(job: job),
                                          );
                                        },
                                  job: job,
                                ),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: PopularJobItemLoad(),
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        _buildTitleHome(
                          onPressed: SharedPrefs.account == null
                              ? onTapNotUser
                              : () {
                                  RoutePage.push(
                                    context,
                                    page: SKAllJobPage(
                                      title: context.l10n.allRecentJob,
                                      jobs: recentJobs,
                                    ),
                                  );
                                },
                          title: context.l10n.recentJobList,
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 34.0),
                          itemCount: !isLoadRecent
                              ? 3
                              : (recentJobs.length) < 3
                                  ? (recentJobs.length)
                                  : 3,
                          itemBuilder: (context, index) {
                            if (isLoadRecent) {
                              final job = recentJobs[index];
                              return RecentJobItem(
                                onPressed: SharedPrefs.account == null
                                    ? onTapNotUser
                                    : () {
                                        RoutePage.push(
                                          context,
                                          page: SKJobDetail(job: job),
                                        );
                                      },
                                job: job,
                              );
                            } else {
                              return const RecentJobItemLoad();
                            }
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitleHome({required String title, Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        children: [
          Text(
            title,
            style: DJStyle.h14w600.copyWith(color: DJColor.h000000),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onPressed,
            child: Text(context.l10n.viewAll, style: DJStyle.h12w500),
          ),
        ],
      ),
    );
  }

  Row _buildAppBarNotUser() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.youWantToLookJob, style: DJStyle.h17w400),
              const SizedBox(height: 4.0),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: DJElevatedButton.small(
                  onPressed: () => RoutePage.push(
                    context,
                    page: const LoginPage(),
                  ),
                  text: context.l10n.login,
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 20),
        SvgPicture.asset(Assets.icons.icLogoApp, width: 60.0),
      ],
    );
  }

  Row _buildAppBarHome() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.welcomeBack, style: DJStyle.h20w500),
              Text(
                (SharedPrefs.account?.name ?? '').toUpperCase(),
                style: DJStyle.h25w600,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => RoutePage.push(
            context,
            page: SKMyAccountPage(
              onUpdate: () => setState(() {}),
            ),
          ),
          child: DJAvatarNetwork(
            path: SharedPrefs.account?.avatar,
            width: 52,
            height: 52,
          ),
        ),
      ],
    );
  }
}
