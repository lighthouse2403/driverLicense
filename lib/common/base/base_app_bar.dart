import 'package:flutter/material.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/extension/text_extension.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  List<Widget>? actions = [];
  Widget? leading;

  BaseAppBar({required this.title, this.actions, this.leading, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? '').w800().text18().whiteColor().ellipsis(),
      backgroundColor: AppColors.mainColor,
      actions: actions,
      leading: leading,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}

