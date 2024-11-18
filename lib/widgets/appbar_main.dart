import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class AppbarMain extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Function? onPressed;

  AppbarMain(this.text, {this.onPressed});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appbarColor,
      elevation: 0,
      title: Text(text),
      centerTitle: false,
      actions: <Widget>[
        IconButton(
          icon: ImageIcon(AssetImage('assets/icons/ic_notification.png')),
          onPressed: () {
            /*
            if (currentUser.value.token.toString() != "") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ConversationsView()));
            } else {
              showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return AuthPage(); //Container(child: Text("aa"));
                  });
            }
            */
          },
        ),
        IconButton(
          icon: ImageIcon(AssetImage('assets/icons/ic_explore.png')),
          onPressed: () {
            /*
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HashVideosView()));
            */
          },
        ),
        IconButton(
          icon: Icon(
            Icons.filter_list,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
