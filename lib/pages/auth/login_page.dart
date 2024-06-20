import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_auth.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/button/dj_text_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/text/dj_second_text.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field_password.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/pages/admin/ad_main_page.dart';
import 'package:flutter_desired_job/pages/auth/forgot_password_page.dart';
import 'package:flutter_desired_job/pages/auth/register_page.dart';
import 'package:flutter_desired_job/pages/business/bs_main_page.dart';
import 'package:flutter_desired_job/pages/seeker/sk_main_page.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/utils/enum.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.email, this.isNotBack});

  final String? email;
  final bool? isNotBack;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthServices authServices = AuthServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email ?? '';
  }

  Future<void> _submitLogin() async {
    if (!formKey.currentState!.validate()) return;
    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        List<AccountModel> accounts =
            await authServices.getAccounts().catchError((_) {
                  DJSnackBar.snackbarWarning(
                    context,
                    title: context.l10n.errorInternet,
                  );
                  Navigator.pop(context);
                }) ??
                [];

        if (accounts.isEmpty) {
          DJSnackBar.snackbarError(context,
              title: context.l10n.emailOrPassIncorrect);
          Navigator.pop(context);
          return;
        }

        List<AccountModel> accountLogin = accounts
            .where((e) =>
                e.email == emailController.text &&
                e.password == passwordController.text)
            .toList();

        if (accountLogin.isEmpty) {
          DJSnackBar.snackbarError(context,
              title: context.l10n.emailOrPassIncorrect);
          Navigator.pop(context);
        } else {
          SharedPrefs.account = accountLogin[0];
          if (accountLogin[0].role == 0) {
            RoutePage.pushAndRemove(context, page: const SKMainPage());
          } else if (accountLogin[0].role == 1) {
            RoutePage.pushAndRemove(context, page: const BSMainPage());
          } else {
            RoutePage.pushAndRemove(context, page: const ADMainPage());
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
                top: MediaQuery.of(context).padding.top + 10.0, bottom: 20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      30.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!(widget.isNotBack ?? false))
                        DJIconButton(
                          onPressed: () => RoutePage.pop(context),
                          icon: Assets.icons.icChevronLeft,
                        ),
                      const SizedBox(height: 44.0),
                      DJTitle(text: context.l10n.titleLogin),
                      const SizedBox(height: 44.0),
                      DJTextField(
                        controller: emailController,
                        hintText: context.l10n.enterEmail,
                        validator: (value) => Validator.validatorEmail(
                          context,
                          value: value,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 25.0),
                      DJTextFieldPassword(
                        controller: passwordController,
                        hintText: context.l10n.enterPassword,
                        validator: (value) => Validator.validatorPassword(
                          context,
                          value: value,
                        ),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (p0) => _submitLogin(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: DJTextButton(
                            onPressed: () => RoutePage.push(
                              context,
                              page: const ForgotPasswordPage(),
                            ),
                            text: context.l10n.forgotPassword,
                            textStyle: DJStyle.h14w400
                                .copyWith(color: DJColor.h6B6968),
                          ),
                        ),
                      ),
                      DJElevatedButton(
                        onPressed: _submitLogin,
                        text: context.l10n.login,
                      ),
                      const SizedBox(height: 25.0),
                      Center(
                        child: DJSecondText(
                          firstText: context.l10n.dontHaveAccount,
                          secondText: context.l10n.registerNow,
                          onTap: () => RoutePage.push(context,
                              page: const RegisterPage()),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: DJTextButton(
                          onPressed: () => RoutePage.push(
                            context,
                            page: const RegisterPage(
                              roleType: RoleType.roleBusiness,
                            ),
                          ),
                          text: context.l10n.registerForBusiness,
                          textStyle:
                              DJStyle.h14w400.copyWith(color: DJColor.h40573A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
