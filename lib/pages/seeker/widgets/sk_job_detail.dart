import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/components/dj_box_shadow.dart';
import 'package:flutter_desired_job/components/dj_shimmer.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/business_model.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/business/create_job/bs_fill_job.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/sk_apply_page.dart';
import 'package:flutter_desired_job/pages/business/home/bs_list_candidate.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SKJobDetail extends StatefulWidget {
  const SKJobDetail({super.key, required this.job});

  final JobModel job;

  @override
  State<SKJobDetail> createState() => _SKJobDetailState();
}

class _SKJobDetailState extends State<SKJobDetail> {
  JobService jobService = JobService();
  List<JobModel> favoriteJobs = [];
  bool isFavorite = false;
  AccountModel? account = SharedPrefs.account;
  bool isLoading = false;

  @override
  void initState() {
    checkFavorite();
    super.initState();
  }

  Future<void> checkFavorite() async {
    if (SharedPrefs.account?.role != 0) return;
    setState(() => isLoading = true);
    try {
      if (account?.id != null) {
        favoriteJobs = await jobService.getFavoriteJobs(account!.id!) ?? [];
        isFavorite = favoriteJobs.any((element) => element.id == widget.job.id);
      }
    } catch (e) {
      DJDiaLog.dialogError(context, title: e.toString());
    }
    setState(() => isLoading = false);
  }

  Future<void> addFavoriteJobs() async {
    isFavorite = true;
    setState(() {});
    if (account?.id != null) {
      favoriteJobs.add(widget.job);
      jobService.updateFavoriteJobs(account!.id!, favoriteJobs).onError(
            (error, stackTrace) => debugPrint(error.toString()),
          );
    }
  }

  Future<void> removeFavoriteJobs() async {
    isFavorite = false;
    setState(() {});
    if (widget.job.id != null && account?.id != null) {
      favoriteJobs.removeWhere((e) => e.id == widget.job.id);
      jobService.updateFavoriteJobs(account!.id!, favoriteJobs).onError(
            (error, stackTrace) => debugPrint(error.toString()),
          );
    }
  }

  Future<void> showHiddenPost() async {
    DJDiaLog.dialogQuestion(
      context,
      title: context.l10n.alert,
      content: (widget.job.isHidden ?? false)
          ? context.l10n.doYouWantShowPost
          : context.l10n.doYouWantHiddenPost,
      action: () {
        Navigator.pop(context);

        setState(() => widget.job.isHidden = !(widget.job.isHidden ?? false));
        DJDiaLog.dialogLoading(
          context,
          title: context.l10n.processing,
          action: () async {
            await jobService.updateJob(
              JobModel(id: widget.job.id, isHidden: widget.job.isHidden),
            );
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> approvedPost(JobModel job) async {
    DJDiaLog.dialogQuestion(
      context,
      title: context.l10n.alert,
      content: context.l10n.doYouWantApprovedPost,
      action: () {
        Navigator.pop(context);

        DJDiaLog.dialogLoading(
          context,
          title: context.l10n.processing,
          action: () async {
            await jobService.updateJob(
              JobModel(id: job.id, isApproved: true),
            );
            setState(() => job.isApproved = true);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DJBackgroundMain(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
            top: MediaQuery.paddingOf(context).top + 6,
            bottom: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  DJIconButton(
                    onPressed: () => RoutePage.pop(context),
                    icon: Assets.icons.icChevronLeft,
                  ),
                  const SizedBox(width: 14.0),
                  DJTitle(text: context.l10n.jobDetails),
                ],
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: isLoading
                    ? _buildLoadingDetailJob()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                DJAvatarNetwork(
                                  path: widget.job.business?.avatar,
                                  width: 54.0,
                                  height: 54.0,
                                ),
                                const SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.job.business?.name ?? 0}',
                                      style: DJStyle.h12w600
                                          .copyWith(color: DJColor.h436B49),
                                    ),
                                    Text(widget.job.position ?? '',
                                        style: DJStyle.h18w700),
                                    Text(widget
                                            .job.business?.address?.location ??
                                        ''),
                                  ],
                                ),
                                const Spacer(),
                                Material(
                                  color: Colors.transparent,
                                  child: SharedPrefs.account?.role == 0
                                      ? InkWell(
                                          onTap: isFavorite
                                              ? removeFavoriteJobs
                                              : addFavoriteJobs,
                                          child: SvgPicture.asset(
                                            isFavorite
                                                ? Assets.icons.icBookmark
                                                : Assets
                                                    .icons.icBookmarkOutline,
                                            color: DJColor.h436B49,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            RoutePage.push(
                                              context,
                                              page: BSListCandidate(
                                                cvs: widget.job.cvs ?? [],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: DJColor.hFFFFFF,
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: SvgPicture.asset(
                                              Assets.icons.icListCustomer,
                                              width: 40.0,
                                              height: 40.0,
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            (widget.job.getJobStatus())
                                .toStatusDisplay(context),
                            const SizedBox(height: 8.0),
                            Wrap(
                              runSpacing: 10.0,
                              children: [
                                if (widget.job.salary != null)
                                  _buildInfoJob(
                                    icon: Assets.icons.icSalary,
                                    title: widget.job.salary.toFormatDollar(),
                                  ),
                                ...List.generate(
                                  widget.job.levels?.length ?? 0,
                                  (index) {
                                    return _buildInfoJob(
                                      icon: Assets.icons.icSchool,
                                      title: widget.job.levels?[index] ?? '-:-',
                                    );
                                  },
                                ),
                                ...List.generate(
                                  widget.job.types?.length ?? 0,
                                  (index) {
                                    return _buildInfoJob(
                                      icon: Assets.icons.icSchedule,
                                      title: widget.job.types?[index] ?? '-:-',
                                    );
                                  },
                                ),
                              ],
                            ),
                            if (widget.job.business?.address?.lat != null &&
                                widget.job.business?.address?.long != null) ...[
                              const SizedBox(height: 18.0),
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(color: DJColor.h46F11B),
                                ),
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                      widget.job.business?.address?.lat ??
                                          16.03231382590131,
                                      widget.job.business?.address?.long ??
                                          108.21517569496591,
                                    ),
                                    zoom: 18.0,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: const MarkerId('99999'),
                                      position: LatLng(
                                        widget.job.business?.address?.lat ??
                                            16.03231382590131,
                                        widget.job.business?.address?.long ??
                                            108.21517569496591,
                                      ),
                                    ),
                                  },
                                ),
                              ),
                            ],
                            const SizedBox(height: 18.0),
                            if (widget.job.business?.website != null) ...[
                              _buildTitleDetail(
                                icon: Assets.icons.icWebsite,
                                title: context.l10n.website,
                              ),
                              Text(widget.job.business?.website ?? ''),
                            ],
                            const SizedBox(height: 18.0),
                            _buildTitleDetail(
                                icon: Assets.icons.icTime,
                                title: context.l10n.duration),
                            Text(
                                '${widget.job.startDay.toDateTime} - ${widget.job.endDay.toDateTime}'),
                            const SizedBox(height: 18.0),
                            _buildTitleDetail(
                              icon: Assets.icons.icEdit,
                              title: context.l10n.jobDescription,
                            ),
                            Text(widget.job.content ?? ''),
                            const SizedBox(height: 20.0),
                            _buildTitleDetail(
                              icon: Assets.icons.icTaskAlt,
                              title: context.l10n.skillsAndRequirements,
                            ),
                            if (widget.job.skills != null)
                              Text(widget.job.skills?.join(', ') ?? '-:-'),
                            Text(widget.job.requirement ?? '-:-'),
                            const SizedBox(height: 20.0),
                            _buildTitleDetail(
                              icon: Assets.icons.icBenefits,
                              title: context.l10n.benefits,
                            ),
                            Text(widget.job.benefits ?? '-:-'),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 23).copyWith(bottom: 12),
        child: SharedPrefs.account?.role == 0
            ? isLoading
                ? null
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DJElevatedButton(
                        onPressed: () {
                          RoutePage.push(
                            context,
                            page: SKApplyPage(
                              id: widget.job.id,
                              cvs: widget.job.cvs ?? [],
                            ),
                          );
                        },
                        text: context.l10n.applyNow,
                      ),
                    ],
                  )
            : SharedPrefs.account?.role == 1
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DJElevatedButton(
                              onPressed: showHiddenPost,
                              text: (widget.job.isHidden ?? false)
                                  ? context.l10n.showPost
                                  : context.l10n.hiddenPost,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: DJElevatedButton(
                              onPressed: () => RoutePage.push(
                                context,
                                page: BSFillJob(
                                  business:
                                      widget.job.business ?? BusinessModel(),
                                  job: widget.job,
                                  businessPost: BusinessPost.edit,
                                ),
                              ),
                              text: context.l10n.editPost,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DJElevatedButton(
                              onPressed: showHiddenPost,
                              text: (widget.job.isHidden ?? false)
                                  ? context.l10n.showPost
                                  : context.l10n.hiddenPost,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: DJElevatedButton(
                              onPressed: (widget.job.isApproved ?? false)
                                  ? null
                                  : () {
                                      if (widget.job.id != null) {
                                        approvedPost(widget.job);
                                      }
                                    },
                              color: (widget.job.isApproved ?? false)
                                  ? DJColor.h83C189
                                  : DJColor.h436B49,
                              text: (widget.job.isApproved ?? false)
                                  ? context.l10n.approved
                                  : context.l10n.approve,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildLoadingDetailJob() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DJShimmer.circular(radius: 29.0),
              const SizedBox(width: 16.0),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DJShimmer(width: 72.0, height: 16.0),
                    SizedBox(height: 4.0),
                    DJShimmer(width: 140.0, height: 20.0),
                    SizedBox(height: 4.0),
                    DJShimmer(width: 50.0, height: 16.0),
                  ],
                ),
              ),
              const DJShimmer(width: 20, height: 22)
            ],
          ),
          const SizedBox(height: 10.0),
          Wrap(
            runSpacing: 10.0,
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DJShimmer(
                  width: 90,
                  height: 30,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const DJShimmer(width: double.infinity, height: 180),
          const SizedBox(height: 16.0),
          const DJShimmer(width: 150, height: 30),
          const SizedBox(height: 16.0),
          const DJShimmer(width: double.infinity, height: 100),
          const SizedBox(height: 16.0),
          const DJShimmer(width: 180, height: 40),
        ],
      ),
    );
  }

  Widget _buildTitleDetail({required String icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: DJColor.hFFFFFF,
              borderRadius: BorderRadius.circular(8),
              boxShadow: DJBoxShadow.boxShadow,
            ),
            child: SvgPicture.asset(
              icon,
              width: 20.0,
              height: 20.0,
              color: DJColor.h000000,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: DJStyle.h16w600.copyWith(color: DJColor.h000000),
          ),
        ],
      ),
    );
  }

  Container _buildInfoJob({required String icon, required String title}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: DJColor.h436B49,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 16,
            height: 16,
            color: DJColor.hFFFFFF,
          ),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: DJStyle.h10w400,
          ),
        ],
      ),
    );
  }
}
