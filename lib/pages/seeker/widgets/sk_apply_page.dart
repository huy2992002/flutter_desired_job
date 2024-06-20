import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/cv_model.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/models/user_model.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/maths.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';

class SKApplyPage extends StatefulWidget {
  const SKApplyPage({
    super.key,
    this.id,
    required this.cvs,
  });
  final String? id;
  final List<CVModel> cvs;

  @override
  State<SKApplyPage> createState() => _SKApplyPageState();
}

class _SKApplyPageState extends State<SKApplyPage> {
  JobService jobService = JobService();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController introduceController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController strengthsController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = SharedPrefs.account?.name ?? '';
    phoneController.text = SharedPrefs.account?.numberPhone ?? '';
    emailController.text = SharedPrefs.account?.email ?? '';

    super.initState();
  }

  Future<void> submitApply() async {
    if (!formKey.currentState!.validate()) return;
    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        try {
          CVModel cv = CVModel()
            ..id = Maths.randomUUid()
            ..user = (UserModel()
              ..name = nameController.text
              ..numberPhone = phoneController.text
              ..email = emailController.text
              ..avatar = SharedPrefs.account?.avatar)
            ..introduce = introduceController.text
            ..education = educationController.text
            ..strengths = strengthsController.text;

          widget.cvs.add(cv);
          await jobService.updateJob(JobModel(id: widget.id, cvs: widget.cvs));
          Navigator.pop(context);
          Navigator.pop(context);
          DJSnackBar.snackbarSuccess(context, title: context.l10n.applySuccess);
        } catch (e) {
          Navigator.pop(context);
          DJSnackBar.snackbarError(context, title: context.l10n.errorInternet);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
            top: MediaQuery.paddingOf(context).top + 6,
            bottom: 10,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DJIconButton(
                    onPressed: () => RoutePage.pop(context),
                    icon: Assets.icons.icChevronLeft,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    context.l10n.applyNow,
                    style: DJStyle.h25w600.copyWith(color: DJColor.h3EA248),
                  ),
                  const SizedBox(height: 40.0),
                  TitleForm(title: context.l10n.name),
                  TextFieldForm(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validator.validatorRequired(context, value: value),
                  ),
                  const SizedBox(height: 10.0),
                  TitleForm(title: context.l10n.phoneNumber),
                  TextFieldForm(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validator.validatorPhone(context, value: value),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10.0),
                  TitleForm(title: context.l10n.email),
                  TextFieldForm(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validator.validatorEmail(context, value: value),
                  ),
                  const SizedBox(height: 10.0),
                  TitleForm(title: context.l10n.introduceYourself),
                  TextFieldForm(
                    controller: introduceController,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validator.validatorRequired(context, value: value),
                  ),
                  const SizedBox(height: 10.0),
                  TitleForm(title: context.l10n.education),
                  TextFieldForm(
                    controller: educationController,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validator.validatorRequired(context, value: value),
                  ),
                  const SizedBox(height: 10.0),
                  TitleForm(title: context.l10n.strengths),
                  TextFieldForm(
                    controller: strengthsController,
                    textInputAction: TextInputAction.done,
                    validator: (value) =>
                        Validator.validatorRequired(context, value: value),
                    onFieldSubmitted: (_) => submitApply(),
                  ),
                  const SizedBox(height: 40.0),
                  DJElevatedButton(
                    onPressed: submitApply,
                    text: context.l10n.applyNow,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldForm extends StatelessWidget {
  const TextFieldForm({
    super.key,
    this.controller,
    this.hintText,
    this.onChange,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChange;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly,
      style: DJStyle.h15w500.copyWith(
        color: DJColor.h6B6968,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 2.0,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: DJColor.h83C189,
          ),
          gapPadding: 2,
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: DJColor.h83C189,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: hintText,
        hintText: hintText,
      ),
      cursorColor: DJColor.h83C189,
      cursorHeight: 18,
    );
  }
}

class TitleForm extends StatelessWidget {
  const TitleForm({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: DJStyle.h14w600.copyWith(color: DJColor.h83C189));
  }
}
