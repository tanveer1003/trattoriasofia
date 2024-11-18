import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class WhiteHeading extends StatelessWidget {
  final String text;
  final Function? onPressed;

  WhiteHeading( this.text, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: transparentColor,
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
      onPressed: onPressed as void Function()?,
    );
  }
}
