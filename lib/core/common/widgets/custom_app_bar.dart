import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions = const [],
  });

  final List<Widget> actions;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Align(
        alignment: Alignment.bottomCenter,
        child: title,
      ),
      leadingWidth: 100,
      scrolledUnderElevation: 0,
      actions: actions,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
