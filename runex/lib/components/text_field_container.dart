import 'package:flutter/material.dart';
import 'package:runex/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double sizeMultiple;
  const TextFieldContainer({
    Key key,
    this.child,
    this.color = kPrimaryLightColor,
    this.sizeMultiple = 0.7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      width: size.width * sizeMultiple,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: child,
    );
  }
}
