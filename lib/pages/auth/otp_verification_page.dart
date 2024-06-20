import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_auth.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_code_text_field.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/business_model.dart';
import 'package:flutter_desired_job/models/email_model.dart';
import 'package:flutter_desired_job/models/user_model.dart';
import 'package:flutter_desired_job/pages/auth/login_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/utils/enum.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/maths.dart';
import 'package:flutter_desired_job/utils/route.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    required this.otp,
    required this.emailModel,
    required this.account,
    required this.registerType,
  });

  final String otp;
  final EmailModel emailModel;
  final AccountModel account;
  final RoleType registerType;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  AuthServices authServices = AuthServices();
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  bool canResend = true;
  late String otp;

  @override
  void initState() {
    otpFocusNode.requestFocus();
    otp = widget.otp;
    super.initState();
  }

  Future<void> resendOtp() async {
    setState(() => canResend = false);
    otpController.clear();
    otpFocusNode.requestFocus();
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

  Future<void> onCompleted(String value) async {
    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        if (value == otp) {
          authServices.addAccount(widget.account).then((response) {
            if (response.statusCode >= 200 && response.statusCode < 300) {
              if (widget.registerType == RoleType.roleSeeker) {
                UserModel user = UserModel()
                  ..id = Maths.randomUUid()
                  ..email = widget.account.email
                  ..numberPhone = widget.account.numberPhone
                  ..name = widget.account.name
                  ..accountId = widget.account.id;
                authServices.addUser(user).then((value) {
                  if (value.statusCode >= 200 && value.statusCode < 300) {
                    RoutePage.pushAndRemove(
                      context,
                      page: LoginPage(
                        email: widget.emailModel.senderEmail,
                        isNotBack: true,
                      ),
                    );
                    DJSnackBar.snackbarSuccess(
                      context,
                      title: context.l10n.createAccSuccess,
                    );
                  } else {
                    throw Exception();
                  }
                });
              } else {
                BusinessModel business = BusinessModel()
                  ..id = Maths.randomUUid()
                  ..email = widget.account.email
                  ..phone = widget.account.numberPhone
                  ..name = widget.account.name
                  ..avatar = widget.account.avatar
                  ..accountId = widget.account.id;
                authServices.addBusiness(business).then((value) {
                  if (value.statusCode >= 200 && value.statusCode < 300) {
                    RoutePage.pushAndRemove(
                      context,
                      page: LoginPage(
                        email: widget.emailModel.senderEmail,
                        isNotBack: true,
                      ),
                    );
                    DJSnackBar.snackbarSuccess(
                      context,
                      title: context.l10n.createAccSuccess,
                    );
                  } else {
                    throw Exception();
                  }
                });
              }
            } else {
              throw Exception();
            }
          }).catchError((onError) {
            Navigator.pop(context);
            DJSnackBar.snackbarWarning(
              context,
              title: context.l10n.errorInternet,
            );
          });
        } else {
          Navigator.pop(context);
          DJSnackBar.snackbarError(context, title: context.l10n.otpIncorrect);
          otpController.clear();
          otpFocusNode.requestFocus();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DJIconButton(
                    onPressed: () => RoutePage.pop(context),
                    icon: Assets.icons.icChevronLeft,
                  ),
                  const SizedBox(height: 20.0),
                  DJTitle(
                    text: context.l10n.otpVerification,
                    description: context.l10n.desOtpVerification,
                  ),
                  const SizedBox(height: 30.0),
                  DJCodeTextField(
                    controller: otpController,
                    focusNode: otpFocusNode,
                    onCompleted: onCompleted,
                  ),
                  const SizedBox(height: 14.0),
                  Material(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
