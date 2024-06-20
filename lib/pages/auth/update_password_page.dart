import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_auth.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_code_text_field.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field_password.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/email_model.dart';
import 'package:flutter_desired_job/pages/auth/login_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/maths.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';
import 'package:http/http.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({
    super.key,
    required this.account,
    required this.otp,
    required this.emailModel,
  });

  final AccountModel account;
  final String otp;
  final EmailModel emailModel;

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  AuthServices authServices = AuthServices();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String otp = '';
  bool canResend = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    otp = widget.otp;
    super.initState();
  }

  Future<void> resendOtp() async {
    setState(() => canResend = false);
    otpController.clear();
    otp = Maths.genOtp(4);
    try {
      await authServices.sendOtp(widget.emailModel..message = otp);
    } catch (e) {
      Navigator.pop(context);
      DJSnackBar.snackbarWarning(context, title: context.l10n.errorInternet);
    }
    await Future.delayed(const Duration(seconds: 30));
    setState(() => canResend = true);
  }

  Future<void> _submitForgotPass() async {
    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        if (!formKey.currentState!.validate() ||
            (otpController.text.length < 4)) {
          DJSnackBar.snackbarError(
            context,
            title: context.l10n.pleaseDontEmpty,
          );
          return;
        }
        if (otpController.text != otp) {
          await Future.delayed(const Duration(seconds: 1));
          Navigator.pop(context);
          DJSnackBar.snackbarError(context, title: context.l10n.otpIncorrect);
        } else {
          widget.account.password = newPasswordController.text;
          try {
            AccountModel account = AccountModel()
              ..id = widget.account.id
              ..password = widget.account.password;

            Response response = await authServices.updateAccount(account);
            if (response.statusCode >= 200 && response.statusCode < 300) {
              RoutePage.pushAndRemove(
                context,
                page: LoginPage(email: widget.account.email, isNotBack: true),
              );
              DJSnackBar.snackbarSuccess(
                context,
                title: context.l10n.changePasswordSuccess,
              );
            } else {
              throw Exception();
            }
          } catch (_) {
            DJSnackBar.snackbarWarning(
              context,
              title: context.l10n.errorInternet,
            );
            Navigator.pop(context);
          }
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
                    const SizedBox(height: 30.0),
                    DJTitle(
                      text: context.l10n.forgotPassword,
                      description: context.l10n.desOtpVerification,
                    ),
                    const SizedBox(height: 43.0),
                    DJCodeTextField(
                      controller: otpController,
                    ),
                    Material(
                      child: InkWell(
                        onTap: canResend ? resendOtp : null,
                        borderRadius: BorderRadius.circular(20),
                        child: Text(
                          context.l10n.resendOtp,
                          style: DJStyle.h14w500.copyWith(
                            color: canResend ? DJColor.h000000 : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DJTextFieldPassword(
                      controller: newPasswordController,
                      hintText: context.l10n.enterNewPassword,
                      validator: (value) => Validator.validatorPassword(
                        context,
                        value: value,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    DJTextFieldPassword(
                      controller: confirmPasswordController,
                      hintText: context.l10n.enterThePassword,
                      validator: (value) {
                        return Validator.validatorConfirmPassword(
                          context,
                          value: value,
                          password: newPasswordController.text,
                        );
                      },
                      onFieldSubmitted: (_) => _submitForgotPass(),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 40.0),
                    DJElevatedButton(
                      onPressed: _submitForgotPass,
                      text: context.l10n.resetPassword,
                    )
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
