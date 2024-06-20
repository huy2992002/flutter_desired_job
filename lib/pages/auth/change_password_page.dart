import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field_password.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/pages/auth/login_page.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthServices authServices = AuthServices();
  final formKey = GlobalKey<FormState>();

  Future<void> changePasswordSubmit() async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }

    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        try {
          final user =
              await authServices.getMyAccount(SharedPrefs.account?.id ?? '');
          String password = user?.password ?? '';

          if (password != currentPasswordController.text) {
            DJSnackBar.snackbarError(
              context,
              title: context.l10n.currentPassIncorrect,
            );
            Navigator.pop(context);
          } else {
            AccountModel myUser = AccountModel()
              ..id = SharedPrefs.account?.id
              ..password = newPasswordController.text;
            await authServices.updateAccount(myUser);
            DJSnackBar.snackbarSuccess(
              context,
              title: context.l10n.changePasswordSuccess,
            );
            Navigator.pop(context);
            RoutePage.pushAndRemove(
              context,
              page: LoginPage(
                email: SharedPrefs.account?.email,
                isNotBack: true,
              ),
            );
          }
        } catch (e) {
          DJSnackBar.snackbarWarning(
            context,
            title: context.l10n.errorInternet,
          );
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox20 = SizedBox(height: 20.0);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: DJBackgroundMain(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
              top: MediaQuery.paddingOf(context).top + 6.0,
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
                    DJTitle(text: context.l10n.changePassword),
                    const SizedBox(height: 70.0),
                    DJTextFieldPassword(
                      controller: currentPasswordController,
                      hintText: context.l10n.currentPassword,
                      validator: (value) =>
                          Validator.validatorPassword(context, value: value),
                      textInputAction: TextInputAction.next,
                    ),
                    sizedBox20,
                    DJTextFieldPassword(
                      controller: newPasswordController,
                      hintText: context.l10n.newPassword,
                      validator: (value) =>
                          Validator.validatorPassword(context, value: value),
                      textInputAction: TextInputAction.next,
                    ),
                    sizedBox20,
                    DJTextFieldPassword(
                      controller: confirmPasswordController,
                      hintText: context.l10n.confirmPassword,
                      validator: (value) => Validator.validatorConfirmPassword(
                        context,
                        value: value,
                        password: newPasswordController.text,
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => changePasswordSubmit(),
                    ),
                    const SizedBox(height: 40.0),
                    DJElevatedButton(
                      onPressed: changePasswordSubmit,
                      text: context.l10n.changePassword,
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
