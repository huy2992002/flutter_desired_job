import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/background/dj_background_auth.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field.dart';
import 'package:flutter_desired_job/components/textfield/dj_text_field_password.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:flutter_desired_job/utils/validator.dart';

class RegisterBusiness extends StatefulWidget {
  const RegisterBusiness({super.key});

  @override
  State<RegisterBusiness> createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? fileAvatar;
  final formKey = GlobalKey<FormState>();

  Future<void> _onRegister() async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }
    if (fileAvatar == null) {
      DJSnackBar.snackbarError(context, title: context.l10n.pleaseChooseAvatar);
      return;
    }
    
  }

  Future<void> _pickAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;
    fileAvatar = File(result.files.single.path!);
    setState(() {});
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
                    Center(
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
                                    ? Image.file(fileAvatar!, fit: BoxFit.cover)
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
                    const SizedBox(height: 40.0),
                    DJTextField(
                      controller: nameController,
                      hintText: context.l10n.nameBusiness,
                      validator: (value) => Validator.validatorRequired(
                        context,
                        value: value,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 14.0),
                    DJTextField(
                      controller: phoneController,
                      hintText: context.l10n.phoneBusiness,
                      validator: (value) => Validator.validatorPhone(
                        context,
                        value: value,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 14.0),
                    DJTextField(
                      controller: emailController,
                      hintText: context.l10n.emailBusiness,
                      validator: (value) => Validator.validatorEmail(
                        context,
                        value: value,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 14.0),
                    DJTextFieldPassword(
                      controller: passwordController,
                      hintText: context.l10n.hintPassword,
                      validator: (value) => Validator.validatorPassword(
                        context,
                        value: value,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 14.0),
                    DJTextFieldPassword(
                      hintText: context.l10n.confirmPassword,
                      validator: (value) => Validator.validatorConfirmPassword(
                        context,
                        value: value,
                        password: passwordController.text,
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 50.0),
                    DJElevatedButton(
                      text: context.l10n.register,
                      onPressed: _onRegister,
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
