import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/dj_bottom_navigation_bar.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/business_model.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/business/create_job/bs_fill_job.dart';
import 'package:flutter_desired_job/pages/business/home/bs_home_page.dart';
import 'package:flutter_desired_job/pages/business/profile/bs_profile_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';

class BSMainPage extends StatefulWidget {
  const BSMainPage({super.key});

  @override
  State<BSMainPage> createState() => _BSMainPageState();
}

class _BSMainPageState extends State<BSMainPage> {
  AuthServices authServices = AuthServices();
  JobService jobService = JobService();
  BusinessModel? myBusiness;
  int currentIndex = 0;
  List<JobModel> businessJobs = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getMyBusiness();
  }

  Future<void> _getMyBusiness() async {
    setState(() => isLoading = true);
    if (SharedPrefs.account?.id != null) {
      final value = await authServices.getMyBusiness(SharedPrefs.account!.id!);
      myBusiness = value;
      _getJobBusiness();
    }
  }

  Future<void> _getJobBusiness() async {
    if (myBusiness != null) {
      businessJobs = await jobService.getBusinessJobs(myBusiness!.id!) ?? [];
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> iconNav = [
      {'icon': Assets.icons.icBookmarkOutline, 'label': context.l10n.plan},
      {'icon': Assets.icons.icUser, 'label': context.l10n.profile},
    ];

    List<Widget> pages = [
      BSHomePage(
        businessJobs: businessJobs,
        isLoading: isLoading,
        refresh: () => _getMyBusiness(),
      ),
      BSProfilePage(lengthJobs: businessJobs.length),
    ];

    return Scaffold(
      body: DJBackgroundMain(
        child: pages[currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (myBusiness != null) {
            RoutePage.push(
              context,
              page: BSFillJob(
                business: myBusiness!,
                onCreate: (value) {
                  businessJobs.add(value);
                  setState(() {});
                },
              ),
            );
          }
        },
        shape: const CircleBorder(),
        backgroundColor: DJColor.h83C189,
        child: const Icon(Icons.add, size: 30, color: DJColor.hFFFFFF),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: DJBottomNavigationBar(
        currentIndex: currentIndex,
        iconNav: iconNav,
        onTap: (idx) {
          setState(() => currentIndex = idx);
        },
      ),
    );
  }
}
