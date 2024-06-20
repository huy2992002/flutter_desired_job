import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dialog/dj_dialog.dart';
import 'package:flutter_desired_job/components/snackbar/dj_snackbar.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/business_model.dart';
import 'package:flutter_desired_job/pages/admin/widgets/account_item.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_desired_job/services/remote/auth_services.dart';
import 'package:flutter_desired_job/services/remote/job_services.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/maths.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ADBusinessPage extends StatefulWidget {
  const ADBusinessPage({super.key});

  @override
  State<ADBusinessPage> createState() => _ADBusinessPageState();
}

class _ADBusinessPageState extends State<ADBusinessPage> {
  AuthServices authServices = AuthServices();
  JobService jobService = JobService();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  List<BusinessModel> business = [];
  List<AccountModel> accounts = [];
  bool isLoading = false;

  Future<void> _getBusiness() async {
    setState(() => isLoading = true);
    business = await authServices.getBusiness() ?? [];
    accounts = await authServices.getAccounts() ?? [];
    setState(() => isLoading = false);
  }

  Future<void> _removeBusiness(BusinessModel businessItem) async {
    DJDiaLog.dialogQuestion(
      context,
      title: context.l10n.alert,
      content: context.l10n.doYouWantRemoveBusiness,
      action: () {
        Navigator.pop(context);
        DJDiaLog.dialogLoading(
          context,
          title: context.l10n.processing,
          action: () async {
            try {
              if (businessItem.id != null && businessItem.accountId != null) {
                await authServices.removeAccount(businessItem.accountId!);
                await authServices.removeBusiness(businessItem.id!);
                await jobService.removeJobBusinessId(businessItem.id!);
                business.remove(businessItem);
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

  void _addBusiness(AccountModel account) {
    try {
      authServices.addAccount(account).then((response) {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          accounts.add(account);
          BusinessModel businessItem = BusinessModel()
            ..id = Maths.randomUUid()
            ..email = account.email
            ..phone = account.numberPhone
            ..name = account.name
            ..avatar = account.avatar
            ..accountId = account.id;
          authServices.addBusiness(businessItem).then((value) {
            if (value.statusCode >= 200 && value.statusCode < 300) {
              Navigator.pop(context);
              business.add(businessItem);
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
  void initState() {
    _getBusiness();
    super.initState();
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
            child: Text(context.l10n.adminBusiness, style: DJStyle.h18w700),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: DJColor.h436B49,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _getBusiness,
                    child: SlidableAutoCloseBehavior(
                      child: ListView.separated(
                        itemCount: business.length,
                        itemBuilder: (context, index) {
                          final businessItem = business[index];
                          return AccountItem(
                            avatar: businessItem.avatar ?? '-:-',
                            name: businessItem.name ?? '-:-',
                            email: businessItem.email ?? '-:-',
                            onRemove: (_) => _removeBusiness(businessItem),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
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
                  ..role = 1;
                _addBusiness(account);
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
