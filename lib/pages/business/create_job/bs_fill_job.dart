import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field_post.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/business_model.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/app/detail_address_page.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/container_profile.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/maths.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum BusinessPost { create, edit }

class BSFillJob extends StatefulWidget {
  const BSFillJob({
    super.key,
    required this.business,
    this.job,
    this.businessPost = BusinessPost.create,
    this.onCreate,
  });
  final BusinessModel business;
  final JobModel? job;
  final BusinessPost businessPost;
  final Function(JobModel)? onCreate;

  @override
  State<BSFillJob> createState() => _BSFillJobState();
}

class _BSFillJobState extends State<BSFillJob> {
  TextEditingController addressController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController requiredController = TextEditingController();
  TextEditingController benefitController = TextEditingController();
  DateTime? startDate;
  DateTime? dueDate;
  LatLng? latLngSelected;
  List<String> levelsSelected = [];
  List<String> typesSelected = [];
  bool canAction = false;
  AuthServices authServices = AuthServices();
  JobService jobServices = JobService();

  @override
  void initState() {
    addressController.text = widget.business.address?.location ?? '';
    websiteController.text = widget.business.website ?? '';
    getValueJob();
    checkCanAction();
    setState(() {});
    super.initState();
  }

  void getValueJob() {
    if (widget.businessPost == BusinessPost.create && widget.job == null) {
      return;
    }
    startDate = DateTime.parse(widget.job!.startDay!);
    startDateController.text = startDate?.toIso8601String().toDateTime ?? '';
    dueDate = DateTime.parse(widget.job!.endDay!);
    dueDateController.text = dueDate?.toIso8601String().toDateTime ?? '';
    positionController.text = widget.job?.position ?? '';
    salaryController.text = '${(widget.job?.salary ?? '')}';
    desController.text = widget.job?.content ?? '';
    requiredController.text = widget.job?.requirement ?? '';
    benefitController.text = widget.job?.benefits ?? '';
    levelsSelected = widget.job?.levels ?? [];
    typesSelected = widget.job?.types ?? [];
    for (var e in levels) {
      if (levelsSelected.contains(e.name)) {
        e.isSelect = true;
      }
    }
    for (var e in types) {
      if (typesSelected.contains(e.name)) {
        e.isSelect = true;
      }
    }
  }

  void checkCanAction() {
    if (widget.businessPost == BusinessPost.create) {
      canAction = addressController.text.isNotEmpty &&
          websiteController.text.isNotEmpty &&
          startDateController.text.isNotEmpty &&
          dueDateController.text.isNotEmpty &&
          positionController.text.isNotEmpty &&
          desController.text.isNotEmpty &&
          requiredController.text.isNotEmpty &&
          benefitController.text.isNotEmpty &&
          levelsSelected.isNotEmpty &&
          typesSelected.isNotEmpty;
    } else {
      canAction = addressController.text != widget.business.address?.location ||
          websiteController.text != widget.business.website ||
          startDate?.toIso8601String() != widget.job?.startDay ||
          dueDate?.toIso8601String() != widget.job?.endDay ||
          positionController.text != widget.job?.position ||
          levelsSelected != widget.job?.levels ||
          typesSelected != widget.job?.types ||
          salaryController.text != '${widget.job?.salary ?? ''}' ||
          desController.text != widget.job?.content ||
          requiredController.text != widget.job?.requirement ||
          benefitController.text != widget.job?.benefits;
    }
    setState(() {});
  }

  Future<void> _submitPost() async {
    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        AddressModel address = AddressModel();
        address.location = addressController.text;
        if (latLngSelected != null) {
          address.lat = latLngSelected?.latitude;
          address.long = latLngSelected?.longitude;
        }
        widget.business.address = address;
        widget.business.website = websiteController.text;
        JobModel job = JobModel(
          id: Maths.randomUUid(),
          businessId: widget.business.id,
          startDay: startDate?.toIso8601String(),
          endDay: dueDate?.toIso8601String(),
          position: positionController.text,
          levels: levelsSelected,
          types: typesSelected,
          salary: salaryController.text.isNotEmpty
              ? double.parse(salaryController.text)
              : null,
          content: desController.text,
          requirement: requiredController.text,
          benefits: benefitController.text,
          business: widget.business,
          isApproved: false,
          createdAt: DateTime.now().toIso8601String(),
        );

        try {
          final response = await jobServices.addJobs(job);
          if (response.statusCode >= 200 && response.statusCode < 300) {
            DJSnackBar.snackbarSuccess(
              context,
              title: context.l10n.createJobSuccess,
            );
            widget.onCreate?.call(job);
            Navigator.pop(context);
          } else {
            throw Exception();
          }
          Navigator.pop(context);
        } catch (e) {
          Navigator.pop(context);
          DJSnackBar.snackbarWarning(
            context,
            title: context.l10n.errorInternet,
          );
        }
      },
    );
  }

  Future<void> _submitEdit() async {
    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        widget.job?.business?.address?.location = addressController.text;
        if (latLngSelected != null) {
          widget.job?.business?.address?.lat = latLngSelected?.latitude;
          widget.job?.business?.address?.long = latLngSelected?.longitude;
        }
        widget.business.website = websiteController.text;

        widget.job?.startDay = startDate?.toIso8601String();
        widget.job?.endDay = dueDate?.toIso8601String();
        widget.job?.position = positionController.text;
        widget.job?.levels = levelsSelected;
        widget.job?.types = typesSelected;
        widget.job?.salary = salaryController.text.isNotEmpty
            ? double.parse(salaryController.text)
            : null;
        widget.job?.content = desController.text;
        widget.job?.requirement = requiredController.text;
        widget.job?.benefits = benefitController.text;
        widget.job?.business = widget.business;
        widget.job?.isApproved = false;

        if (widget.job != null) {
          try {
            final response = await jobServices.updateJob(widget.job!);

            if (response.statusCode >= 200 && response.statusCode < 300) {
              DJSnackBar.snackbarSuccess(
                context,
                title: context.l10n.editJobSuccess,
              );
              Navigator.pop(context);
            } else {
              throw Exception();
            }
            Navigator.pop(context);
          } catch (e) {
            Navigator.pop(context);
            DJSnackBar.snackbarWarning(
              context,
              title: context.l10n.errorInternet,
            );
          }
        }
      },
    );
  }

  List<ItemSelect> levels = [
    ItemSelect('Intern', false),
    ItemSelect('Fresher', false),
    ItemSelect('Junior', false),
    ItemSelect('Mid-level', false),
    ItemSelect('Senior', false),
    ItemSelect('Leader', false),
    ItemSelect('All levels', false),
  ];

  List<ItemSelect> types = [
    ItemSelect('Remote', false),
    ItemSelect('Part time', false),
    ItemSelect('Full time', false),
  ];

  @override
  Widget build(BuildContext context) {
    const sizedBox6 = SizedBox(height: 6.0);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: DJBackgroundMain(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
              top: MediaQuery.paddingOf(context).top + 6,
              bottom: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      DJIconButton(
                        onPressed: () => RoutePage.pop(context),
                        icon: Assets.icons.icChevronLeft,
                      ),
                      const SizedBox(width: 14.0),
                      DJTitle(
                        text: widget.businessPost == BusinessPost.create
                            ? context.l10n.createPost
                            : context.l10n.editPost,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  ContainerForm(
                    child: Column(
                      children: [
                        DJTextFieldPost(
                          controller: addressController,
                          title: context.l10n.address,
                          isRequired: true,
                          icon: GestureDetector(
                            onTap: () => RoutePage.push(
                              context,
                              page: DetailAddressPage(
                                onSelect: (latLng) {
                                  latLngSelected = latLng;
                                  widget.job?.business?.address?.lat =
                                      latLng.latitude;
                                  widget.job?.business?.address?.long =
                                      latLng.longitude;
                                },
                              ),
                            ),
                            child: SvgPicture.asset(
                              Assets.icons.icLocationFocus,
                              height: 20,
                            ),
                          ),
                          onChanged: (_) => checkCanAction(),
                          textInputAction: TextInputAction.next,
                        ),
                        sizedBox6,
                        DJTextFieldPost(
                          controller: websiteController,
                          title: context.l10n.website,
                          isRequired: true,
                          onChanged: (_) => checkCanAction(),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  ContainerForm(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DJTextFieldPost(
                                controller: startDateController,
                                title: context.l10n.startDate,
                                isRequired: true,
                                icon: GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now().copyWith(
                                          // day: DateTime.now().day - 1,
                                          ),
                                      lastDate: dueDate ?? DateTime(2030),
                                    ).then((value) {
                                      if (value != null) {
                                        startDate = value;
                                        startDateController.text = startDate
                                                ?.toIso8601String()
                                                .toDateTime ??
                                            '';
                                        checkCanAction();
                                      }
                                    });
                                  },
                                  child: const Icon(
                                    Icons.calendar_month,
                                    size: 18.0,
                                  ),
                                ),
                                onChanged: (_) => checkCanAction(),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Expanded(
                              child: DJTextFieldPost(
                                controller: dueDateController,
                                title: context.l10n.dueDate,
                                isRequired: true,
                                icon: GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      firstDate: startDate ?? DateTime.now(),
                                      lastDate: DateTime(2050),
                                    ).then((value) {
                                      if (value != null) {
                                        dueDate = value;
                                        dueDateController.text = dueDate
                                                ?.toIso8601String()
                                                .toDateTime ??
                                            '';
                                        checkCanAction();
                                      }
                                    });
                                  },
                                  child: const Icon(
                                    Icons.calendar_month,
                                    size: 18.0,
                                  ),
                                ),
                                onChanged: (_) => checkCanAction(),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                        DJTextFieldPost(
                          controller: positionController,
                          title: context.l10n.position,
                          isRequired: true,
                          onChanged: (_) => checkCanAction(),
                          textInputAction: TextInputAction.next,
                        ),
                        sizedBox6,
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Row(
                            children: [
                              Text(
                                context.l10n.levels,
                                style: DJStyle.h13w500
                                    .copyWith(color: DJColor.h6B6968),
                              ),
                              Text(
                                '*',
                                style: DJStyle.h13w500
                                    .copyWith(color: DJColor.hD65745),
                              ),
                            ],
                          ),
                        ),
                        GridViewPost(
                          length: levels.length,
                          itemBuilder: (context, index) {
                            final level = levels[index];
                            return SelectItem(
                              onPressed: () {
                                level.isSelect = !level.isSelect;
                                levelsSelected = levels
                                    .where((e) => e.isSelect == true)
                                    .map((e) => e.name)
                                    .toList();

                                if (levelsSelected.contains(levels.last.name)) {
                                  levelsSelected = [levels.last.name];
                                }
                                checkCanAction();
                              },
                              item: level,
                            );
                          },
                        ),
                        sizedBox6,
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Row(
                            children: [
                              Text(
                                context.l10n.types,
                                style: DJStyle.h13w500
                                    .copyWith(color: DJColor.h6B6968),
                              ),
                              Text(
                                '*',
                                style: DJStyle.h13w500
                                    .copyWith(color: DJColor.hD65745),
                              ),
                            ],
                          ),
                        ),
                        GridViewPost(
                          length: types.length,
                          itemBuilder: (context, index) {
                            final type = types[index];
                            return SelectItem(
                              onPressed: () {
                                type.isSelect = !(type.isSelect);
                                typesSelected = types
                                    .where((e) => e.isSelect == true)
                                    .map((e) => e.name)
                                    .toList();
                                checkCanAction();
                              },
                              item: type,
                            );
                          },
                        ),
                        sizedBox6,
                        DJTextFieldPost(
                          controller: salaryController,
                          title: context.l10n.salary,
                          textInputType: TextInputType.number,
                          onChanged: (_) => checkCanAction(),
                          textInputAction: TextInputAction.next,
                        ),
                        sizedBox6,
                        DJTextFieldPost(
                          controller: desController,
                          title: context.l10n.content,
                          isRequired: true,
                          onChanged: (_) => checkCanAction(),
                          textInputAction: TextInputAction.next,
                        ),
                        sizedBox6,
                        DJTextFieldPost(
                          controller: requiredController,
                          title: context.l10n.requirement,
                          isRequired: true,
                          onChanged: (_) => checkCanAction(),
                          textInputAction: TextInputAction.next,
                        ),
                        sizedBox6,
                        DJTextFieldPost(
                          controller: benefitController,
                          title: context.l10n.benefits,
                          isRequired: true,
                          onChanged: (_) => checkCanAction(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              decoration: const BoxDecoration(
                color: DJColor.hFFFFFF,
                boxShadow: [
                  BoxShadow(blurRadius: 4),
                ],
              ),
              child: DJElevatedButton(
                onPressed: canAction
                    ? widget.businessPost == BusinessPost.create
                        ? _submitPost
                        : _submitEdit
                    : null,
                text: widget.businessPost == BusinessPost.create
                    ? context.l10n.createPost
                    : context.l10n.editPost,
                color: canAction ? DJColor.h436B49 : DJColor.h9EC395,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridViewPost extends StatelessWidget {
  const GridViewPost({
    super.key,
    required this.length,
    required this.itemBuilder,
  });

  final int length;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: DJColor.h6B6968),
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 0.2,
        ),
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class SelectItem extends StatelessWidget {
  const SelectItem({
    super.key,
    required this.item,
    this.onPressed,
  });

  final ItemSelect item;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          children: [
            Icon(
              item.isSelect
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank_rounded,
              size: 18.0,
            ),
            const SizedBox(width: 3.0),
            Text(item.name),
          ],
        ),
      ),
    );
  }
}

class ItemSelect {
  String name;
  bool isSelect;

  ItemSelect(this.name, this.isSelect);
}
