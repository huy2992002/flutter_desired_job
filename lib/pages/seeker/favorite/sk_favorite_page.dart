import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/app/page_not_user.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/recent_job_item.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/sk_job_detail.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class SKFavoritePage extends StatefulWidget {
  const SKFavoritePage({super.key});

  @override
  State<SKFavoritePage> createState() => _SKFavoritePageState();
}

class _SKFavoritePageState extends State<SKFavoritePage> {
  JobService jobService = JobService();
  List<JobModel> favoriteJobs = [];
  bool isLoading = false;

  @override
  void initState() {
    getFavoriteJob();
    super.initState();
  }

  Future<void> getFavoriteJob() async {
    setState(() => isLoading = true);
    favoriteJobs =
        await jobService.getFavoriteJobs(SharedPrefs.account?.id ?? '') ??
            [];
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SharedPrefs.account == null
        ? const PageNotUser()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
              top: MediaQuery.paddingOf(context).top + 6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DJTitle(text: context.l10n.favoritesList),
                const SizedBox(height: 16.0),
                Expanded(
                  child: favoriteJobs.isEmpty && !isLoading
                      ? Center(
                          child: Text(
                            context.l10n.favoritesListEmpty,
                            style: DJStyle.h16w500
                                .copyWith(color: DJColor.h26E543),
                          ),
                        )
                      : ListView.separated(
                          itemCount: isLoading ? 1 : favoriteJobs.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            if (!isLoading) {
                              final job = favoriteJobs[index];
                              return RecentJobItem(
                                onPressed: () => RoutePage.push(
                                  context,
                                  page: SKJobDetail(job: job),
                                ),
                                job: job,
                              );
                            } else {
                              return const RecentJobItemLoad();
                            }
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16.0),
                        ),
                ),
              ],
            ),
          );
  }
}
