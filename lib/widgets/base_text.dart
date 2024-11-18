import 'package:flutter/material.dart';
import '../helpers/colors.dart';

// ignore: must_be_immutable
class BaseText extends StatelessWidget {
  final String text;
  double padding = 12;
  FontWeight fontWeight = FontWeight.normal;
  double size = 17;
  final Function? onPressed;

  BaseText(this.text,
      {this.padding = 12,
      this.size = 17,
      this.fontWeight = FontWeight.normal,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: transparentColor,
      onTap: onPressed as void Function()?,
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: size == 17 ? 17 : size,
            fontWeight: fontWeight == FontWeight.normal
                ? FontWeight.normal
                : fontWeight,
            color: Colors.black),
      ),
    );
  }
}
