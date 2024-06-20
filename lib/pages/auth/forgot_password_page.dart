import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_auth.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/text/dj_second_text.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/email_model.dart';
import 'package:flutter_desired_job/pages/auth/login_page.dart';
import 'package:flutter_desired_job/pages/auth/update_password_page.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/maths.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';
import 'package:http/http.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  AuthServices authServices = AuthServices();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> _submitSendRequest() async {
    if (!formKey.currentState!.validate()) return;
    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        try {
          List<AccountModel> accounts = await authServices.getAccounts().catchError((_) {
                throw Exception();
              }) ??
              [];

          if (accounts.isEmpty) return;
          AccountModel account = AccountModel();

          account = accounts.singleWhere((e) => e.email == emailController.text);
          String otp = Maths.genOtp(4);

          EmailModel emailModel = EmailModel(
            senderEmail: emailController.text,
            subject: context.l10n.nameApp,
            name: emailController.text,
            appName: context.l10n.nameApp,
            message: context.l10n.myOtp(otp),
          );
          Response response = await authServices.sendOtp(emailModel);
          if (response.statusCode >= 200 && response.statusCode < 300) {
            Navigator.pop(context);
            RoutePage.push(
              context,
              page: UpdatePasswordPage(
                account: account,
                otp: otp,
                emailModel: emailModel,
              ),
            );
          } else {
            throw Exception();
          }
        } catch (e) {
          if (e.runtimeType == StateError) {
            DJSnackBar.snackbarError(
              context,
              title: context.l10n.emailNotExits,
            );
            Navigator.pop(context);
          } else {
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
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: DJBackgroundAuth(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                      top: MediaQuery.of(context).padding.top + 10.0,
                    ),
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
                            description: context.l10n.descriptionForgotPassword,
                          ),
                          const SizedBox(height: 43.0),
                          DJTextField(
                            controller: emailController,
                            hintText: context.l10n.enterEmail,
                            validator: (value) => Validator.validatorEmail(
                              context,
                              value: value,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 30.0),
                          DJElevatedButton(
                            onPressed: _submitSendRequest,
                            text: context.l10n.resetPassword,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                  child: DJSecondText(
                    onTap: () => RoutePage.push(
                      context,
                      page: const LoginPage(),
                    ),
                    firstText: context.l10n.rememberPassword,
                    secondText: context.l10n.loginNow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
