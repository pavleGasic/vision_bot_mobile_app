import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.onPressed,
    super.key,
    this.title,
    this.actions = const [],
    this.iconData,
  });

  final void Function()? onPressed;
  final List<Widget>? actions;
  final Widget? title;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: onPressed != null
          ? Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                icon: Icon(
                  iconData ?? Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: onPressed,
              ),
            )
          : null,
      scrolledUnderElevation: 0,
      actions: actions,
      backgroundColor: Theme.of(context).primaryColor,
      title: title,
      centerTitle: true,
      elevation: 10,
      shadowColor: Theme.of(context).primaryColor,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
