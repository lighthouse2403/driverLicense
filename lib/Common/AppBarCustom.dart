import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  final Widget leading;
  final List<Widget> actions;

  AppBarCustom({super.key, required this.title, required this.leading, required this.actions});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    double availableWidth = mediaQuery.size.width - 160;
    availableWidth -= 32 * actions.length;
    availableWidth -= 32;
    return SliverAppBar(
      expandedHeight: 120.0,
      forceElevated: true,
      leading: leading,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: availableWidth,
          ),
          child: Text(title, textScaleFactor: .8,),
        ),
      ),
    );
  }
}