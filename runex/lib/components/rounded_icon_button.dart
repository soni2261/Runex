import 'package:flutter/material.dart';
import 'package:runex/constants.dart';

class IconButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final Function press;

  const IconButton({
    Key key,
    this.icon,
    this.color = kPrimaryColor,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; // this  gives us the height and the width of the screen
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.7,
      child: IconButton(
        //onPressed: (){},
        icon: icon,
        color: color,
      ),
    );
  }
}
