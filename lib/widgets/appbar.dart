import "package:flutter/material.dart";

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = const Color.fromRGBO(56, 182, 255, 1.0);
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  const BuildAppBar({super.key, required this.title, required this.appBar, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      backgroundColor: backgroundColor,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

}