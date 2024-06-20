import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_search_box.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/app/page_not_user.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/sk_job_detail.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/search_job_item.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class SKSearchPage extends StatefulWidget {
  const SKSearchPage({super.key});

  @override
  State<SKSearchPage> createState() => _SKSearchPageState();
}

class _SKSearchPageState extends State<SKSearchPage> {
  JobService jobService = JobService();
  List<JobModel>? jobs;
  List<JobModel> jobsSearch = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getJobs();
  }

  void _getJobs() async {
    jobs = await jobService.getJobs().catchError((onError) {
          DJDiaLog.dialogError(context, title: context.l10n.errorInternet);
        }) ??
        [];

    setState(() {});
  }

  void _search(String searchText) {
    searchText = searchText.toLowerCase();
    if (searchText.isEmpty) {
      jobsSearch = [];
      setState(() {});
      return;
    }
    jobsSearch = jobs
            ?.where((e) =>
                (e.isApproved == true) &&
                ((e.skills ?? []).join().toLowerCase().contains(searchText) ||
                    (e.business?.name ?? '')
                        .toLowerCase()
                        .contains(searchText) ||
                    (e.levels ?? [])
                        .join(' ')
                        .toLowerCase()
                        .contains(searchText) ||
                    (e.position ?? '').toLowerCase().contains(searchText)))
            .toList() ??
        [];
    setState(() {});
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
                DJTitle(text: context.l10n.searchJobs),
                const SizedBox(height: 10.0),
                DJSearchBox(
                  controller: searchController,
                  onSearch: () => _search(searchController.text),
                  onFieldSubmitted: (value) => _search(value),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                    itemCount: jobsSearch.length,
                    itemBuilder: (context, index) {
                      final job = jobsSearch[index];
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
          );
  }
}
