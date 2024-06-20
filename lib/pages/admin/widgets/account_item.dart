import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/dj_avatar_network.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/resources/dj_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    super.key,
    this.onTap,
    required this.avatar,
    required this.name,
    required this.email,
    this.onRemove,
  });

  final Function()? onTap;
  final String avatar;
  final String name;
  final String email;
  final Function(BuildContext)? onRemove;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: onRemove,
            backgroundColor: DJColor.hD65745,
            foregroundColor: DJColor.hFFFFFF,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(8.0),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: const BoxDecoration(),
          child: Row(
            children: [
              DJAvatarNetwork(
                path: avatar,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: DJStyle.h16w600.copyWith(
                        color: DJColor.hF6774F,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(email)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
