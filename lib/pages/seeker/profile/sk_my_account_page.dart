import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_main.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/text/dj_title.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/business_model.dart';
import 'package:flutter_desired_job/models/user_model.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/utils/enum.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';

class SKMyAccountPage extends StatefulWidget {
  const SKMyAccountPage({
    super.key,
    this.onUpdate,
    this.roleType = RoleType.roleSeeker,
  });

  final Function()? onUpdate;
  final RoleType roleType;

  @override
  State<SKMyAccountPage> createState() => _SKMyAccountPageState();
}

class _SKMyAccountPageState extends State<SKMyAccountPage> {
  AuthServices authServices = AuthServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool canAction = false;
  String? avatar;
  File? fileAvatar;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  void checkValueNoChange() {
    canAction = fileAvatar != null ||
        nameController.text != SharedPrefs.account?.name ||
        emailController.text != SharedPrefs.account?.email ||
        phoneController.text != SharedPrefs.account?.numberPhone;
    setState(() {});
  }

  Future<void> updateProfile() async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }

    DJDiaLog.dialogLoading(
      context,
      title: context.l10n.processing,
      action: () async {
        try {
          String? newName = nameController.text == SharedPrefs.account?.name
              ? null
              : nameController.text;
          String? newPhone = phoneController.text == SharedPrefs.account?.name
              ? null
              : phoneController.text;
          String? newAvatar = await authServices.uploadAvatar(fileAvatar?.path);

          AccountModel acc = AccountModel()
            ..id = SharedPrefs.account?.id
            ..name = newName
            ..numberPhone = newPhone
            ..avatar = newAvatar;

          if (widget.roleType == RoleType.roleSeeker) {
            await updateUser(
              newName: newName,
              newAvatar: newAvatar,
              newPhone: newPhone,
            );
          } else {
            await updateBusiness(
              newName: newName,
              newAvatar: newAvatar,
              newPhone: newPhone,
            );
          }
          await authServices.updateAccount(acc);
          AccountModel? accountSave = SharedPrefs.account;
          if (newName != null) accountSave?.name = newName;
          if (newPhone != null) accountSave?.numberPhone = newPhone;
          if (newAvatar != null) accountSave?.avatar = newAvatar;
          SharedPrefs.account = accountSave;
          widget.onUpdate?.call();
          Navigator.pop(context);
          DJSnackBar.snackbarSuccess(
            context,
            title: context.l10n.updateProfileSuccess,
          );
          Navigator.pop(context);
        } catch (_) {
          DJSnackBar.snackbarWarning(
            context,
            title: context.l10n.errorInternet,
          );
          Navigator.pop(context);
        }
      },
    );
  }

  Future<void> updateUser(
      {String? newName, String? newPhone, String? newAvatar}) async {
    UserModel user = UserModel()
      ..accountId = SharedPrefs.account?.id
      ..name = newName
      ..numberPhone = newPhone
      ..avatar = newAvatar;
    await authServices.updateUser(user);
  }

  Future<void> updateBusiness(
      {String? newName, String? newPhone, String? newAvatar}) async {
    BusinessModel business = BusinessModel()
      ..accountId = SharedPrefs.account?.id
      ..name = newName
      ..phone = newPhone
      ..avatar = newAvatar;
    await authServices.updateBusiness(business);
  }

  void getInformation() {
    emailController.text = SharedPrefs.account?.email ?? '';
    nameController.text = SharedPrefs.account?.name ?? '';
    phoneController.text = SharedPrefs.account?.numberPhone ?? '';
  }

  Future<void> pickAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;
    fileAvatar = File(result.files.single.path!);
    checkValueNoChange();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox24 = SizedBox(height: 22.0);
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
                  children: [
                    Row(
                      children: [
                        DJIconButton(
                          onPressed: () => RoutePage.pop(context),
                          icon: Assets.icons.icChevronLeft,
                        ),
                        const SizedBox(width: 6.0),
                        DJTitle(text: context.l10n.profile),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: pickAvatar,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 62.0,
                            width: 62.0,
                            child: fileAvatar != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(fileAvatar?.path ?? ''),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                        width: 2,
                                        color: DJColor.h26E543,
                                      ),
                                      borderRadius: BorderRadius.circular(62),
                                    ),
                                  )
                                : DJAvatarNetwork(
                                    path: SharedPrefs.account?.avatar,
                                    width: 62,
                                  ),
                          ),
                          Positioned(
                            right: 0.0,
                            bottom: 0.0,
                            child: Container(
                              width: 18.0,
                              height: 18.0,
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
                    const SizedBox(height: 40.0),
                    DJTextField(
                      controller: emailController,
                      hintText: context.l10n.email,
                      readOnly: true,
                    ),
                    sizedBox24,
                    DJTextField(
                      controller: nameController,
                      hintText: context.l10n.name,
                      validator: (value) => Validator.validatorRequired(
                        context,
                        value: value,
                      ),
                      onChange: (_) => checkValueNoChange(),
                      textInputAction: TextInputAction.next,
                    ),
                    sizedBox24,
                    DJTextField(
                      controller: phoneController,
                      hintText: context.l10n.phoneNumber,
                      validator: (value) => Validator.validatorPhone(
                        context,
                        value: value,
                      ),
                      onChange: (_) => checkValueNoChange(),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => canAction ? updateProfile : null,
                    ),
                    const SizedBox(height: 60.0),
                    DJElevatedButton(
                      onPressed: canAction ? updateProfile : null,
                      text: context.l10n.updateProfile,
                      color: canAction ? DJColor.h436B49 : DJColor.h83C189,
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
