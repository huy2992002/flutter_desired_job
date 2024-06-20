import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_auth.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/text/dj_second_text.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field_password.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/email_model.dart';
import 'package:flutter_desired_job/pages/auth/login_page.dart';
import 'package:flutter_desired_job/pages/auth/otp_verification_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/utils/enum.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/maths.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';
import 'package:http/http.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    this.roleType = RoleType.roleSeeker,
  });
  final RoleType roleType;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthServices authServices = AuthServices();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  File? fileAvatar;
  final formKey = GlobalKey<FormState>();

  Future<void> _pickAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;
    fileAvatar = File(result.files.single.path!);
    setState(() {});
  }

  Future<void> _submitRegister() async {
    if (!formKey.currentState!.validate()) return;

    if (widget.roleType == RoleType.roleBusiness &&
        fileAvatar == null) {
      DJSnackBar.snackbarError(context, title: context.l10n.pleaseChooseAvatar);
      return;
    }

    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        List<AccountModel> accounts = await authServices
                .getAccounts()
                .catchError((_) {
              Navigator.pop(context);
              DJSnackBar.snackbarWarning(context, title: context.l10n.errorInternet);
            }) ??
            [];

        AccountModel account = AccountModel()
          ..id = Maths.randomUUid()
          ..name = nameController.text
          ..numberPhone = phoneController.text
          ..email = emailController.text
          ..password = passwordController.text
          ..role = widget.roleType == RoleType.roleSeeker ? 0 : 1
          ..avatar = widget.roleType == RoleType.roleSeeker
              ? null
              : await authServices.uploadAvatar(fileAvatar!.path);

        bool checkUser = accounts.any((e) => e.email == account.email);

        if (!checkUser) {
          String otp = Maths.genOtp(4);

          EmailModel emailModel = EmailModel(
            senderEmail: emailController.text,
            subject: context.l10n.nameApp,
            name: nameController.text,
            appName: context.l10n.nameApp,
            message: context.l10n.myOtp(otp),
          );

          try {
            Response response = await authServices.sendOtp(emailModel);
            if (response.statusCode >= 200 && response.statusCode < 300) {
              Navigator.pop(context);
              RoutePage.push(
                context,
                page: OtpVerificationPage(
                  otp: otp,
                  emailModel: emailModel,
                  account: account,
                  registerType: widget.roleType,
                ),
              );
            } else {
              throw Exception();
            }
          } catch (e) {
            Navigator.pop(context);
            DJSnackBar.snackbarWarning(context, title: context.l10n.errorInternet);
          }
        } else {
          DJSnackBar.snackbarError(context, title: context.l10n.emailAlready);
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: DJBackgroundAuth(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
              top: MediaQuery.of(context).padding.top + 10.0,
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
                    const SizedBox(height: 20.0),
                    widget.roleType == RoleType.roleSeeker
                        ? DJTitle(text: context.l10n.titleRegister)
                        : Center(
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: _pickAvatar,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.0),
                                    child: SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: fileAvatar != null
                                          ? Image.file(fileAvatar!,
                                              fit: BoxFit.cover)
                                          : Image.asset(
                                              Assets.images.imgLogoApp.path),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0.0,
                                  bottom: 0.0,
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: DJColor.hFFFFFF.withOpacity(0.5),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.add, size: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 20.0),
                    DJTextField(
                      controller: nameController,
                      hintText: widget.roleType == RoleType.roleSeeker
                          ? context.l10n.enterName
                          : context.l10n.nameBusiness,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validator.validatorRequired(
                        context,
                        value: value,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    DJTextField(
                      controller: phoneController,
                      hintText: widget.roleType == RoleType.roleSeeker
                          ? context.l10n.phoneNumber
                          : context.l10n.phoneBusiness,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validator.validatorPhone(
                        context,
                        value: value,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    DJTextField(
                      controller: emailController,
                      hintText: widget.roleType == RoleType.roleSeeker
                          ? context.l10n.enterEmail
                          : context.l10n.emailBusiness,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validator.validatorEmail(
                        context,
                        value: value,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    DJTextFieldPassword(
                      controller: passwordController,
                      hintText: widget.roleType == RoleType.roleSeeker
                          ? context.l10n.enterPassword
                          : context.l10n.hintPassword,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validator.validatorPassword(
                        context,
                        value: value,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    DJTextFieldPassword(
                      controller: confirmPasswordController,
                      hintText: context.l10n.confirmPassword,
                      textInputAction: TextInputAction.done,
                      validator: (value) => Validator.validatorConfirmPassword(
                        context,
                        value: value,
                        password: passwordController.text,
                      ),
                      onFieldSubmitted: (_) => _submitRegister(),
                    ),
                    const SizedBox(height: 20.0),
                    DJElevatedButton(
                      onPressed: _submitRegister,
                      text: context.l10n.register,
                    ),
                    const SizedBox(height: 30.0),
                    Center(
                      child: DJSecondText(
                        onTap: () =>
                            RoutePage.push(context, page: const LoginPage()),
                        firstText: context.l10n.alreadyHaveAccount,
                        secondText: context.l10n.loginNow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
