import 'package:flutter/material.dart';
import '../helpers/colors.dart';

// ignore: must_be_immutable
class PrimaryText extends StatelessWidget {
  final String text;
  double padding = 12;
  double size = 20;
  Color color = Color.fromARGB(255, 0, 112, 58);
  final Function? onPressed;

  PrimaryText(this.text,
      {this.padding = 12,
      this.color = const Color.fromARGB(255, 0, 112, 58),
      this.size = 20,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: transparentColor,
      onTap: onPressed as void Function()?,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding == 12 ? 12 : padding),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: "Colonia Deco",
              fontSize: size == 20 ? 20 : size,
              color: color == Color.fromARGB(255, 0, 112, 58)
                  ? Color.fromARGB(255, 0, 112, 58)
                  : color),
        ),
      ),
    );
  }
}
