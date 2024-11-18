import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class AppbarList extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Function? onPressed;

  AppbarList(this.text, {this.onPressed});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appbarColor,
      title: Text(text),
      elevation: 0,
      centerTitle: false,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.filter_list,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
