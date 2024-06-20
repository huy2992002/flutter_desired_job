import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/user_model.dart';
import 'package:flutter_desired_job/pages/admin/widgets/account_item.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/maths.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ADUserPage extends StatefulWidget {
  const ADUserPage({super.key});

  @override
  State<ADUserPage> createState() => _ADUserPageState();
}

class _ADUserPageState extends State<ADUserPage> {
  AuthServices authServices = AuthServices();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  List<UserModel> users = [];
  List<AccountModel> accounts = [];
  bool isLoading = false;

  @override
  void initState() {
    _getUsers();
    super.initState();
  }

  Future<void> _getUsers() async {
    setState(() => isLoading = true);
    users = await authServices.getUsers() ?? [];
    accounts = await authServices.getAccounts() ?? [];
    setState(() => isLoading = false);
  }

  Future<void> _removeUser(UserModel user) async {
    DJDiaLog.dialogQuestion(
      context,
      title: context.l10n.alert,
      content: context.l10n.doYouWantRemoveUser,
      action: () {
        Navigator.pop(context);
        DJDiaLog.dialogLoading(
          context,
          title: context.l10n.processing,
          action: () async {
            try {
              if (user.id != null && user.accountId != null) {
                await authServices.removeAccount(user.accountId!);
                await authServices.removeUser(user.id!);
                users.remove(user);
                Navigator.pop(context);
                setState(() {});
              }
            } catch (e) {
              Navigator.pop(context);
              DJSnackBar.snackbarWarning(context,
                  title: context.l10n.errorInternet);
            }
          },
        );
      },
    );
  }

  void _clearController() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passController.clear();
  }

  void _addUser(AccountModel account) {
    try {
      authServices.addAccount(account).then((response) {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          accounts.add(account);
          UserModel user = UserModel()
            ..id = Maths.randomUUid()
            ..email = account.email
            ..numberPhone = account.numberPhone
            ..name = account.name
            ..accountId = account.id;
          authServices.addUser(user).then((value) {
            if (value.statusCode >= 200 && value.statusCode < 300) {
              Navigator.pop(context);
              users.add(user);
              setState(() {});
              _clearController();
              DJSnackBar.snackbarSuccess(
                context,
                title: context.l10n.createAccSuccess,
              );
            } else {
              throw Exception();
            }
          });
        } else {
          throw Exception();
        }
      });
    } catch (e) {
      Navigator.pop(context);
      DJSnackBar.snackbarError(
        context,
        title: context.l10n.errorInternet,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 4.0,
              left: 20.0,
              bottom: 10.0,
            ),
            child: Text(context.l10n.adminUser, style: DJStyle.h18w700),
          ),
          Expanded(
            child: SlidableAutoCloseBehavior(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: DJColor.h436B49,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _getUsers,
                      child: SlidableAutoCloseBehavior(
                        child: ListView.separated(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users.reversed.toList()[index];
                            return AccountItem(
                              avatar: user.avatar ?? '-:-',
                              name: user.name ?? '-:-',
                              email: user.email ?? '-:-',
                              onRemove: (_) => _removeUser(user),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DJDiaLog.dialogAddAccount(
            context,
            title: context.l10n.addUser,
            nameController: nameController,
            phoneController: phoneController,
            emailController: emailController,
            passController: passController,
            action: () {
              bool checkEmail =
                  accounts.any((e) => e.email == emailController.text);
              if (checkEmail) {
                DJSnackBar.snackbarError(context,
                    title: context.l10n.emailAlready);
              } else {
                AccountModel account = AccountModel()
                  ..id = Maths.randomUUid()
                  ..name = nameController.text
                  ..email = emailController.text
                  ..numberPhone = phoneController.text
                  ..password = passController.text
                  ..role = 0;
                  
                _addUser(account);
              }
            },
          );
        },
        shape: const CircleBorder(),
        backgroundColor: DJColor.h83C189,
        child: const Icon(Icons.add, size: 30, color: DJColor.hFFFFFF),
      ),
    );
  }
}
