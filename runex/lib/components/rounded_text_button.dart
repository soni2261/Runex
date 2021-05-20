import 'package:flutter/material.dart';
import 'package:runex/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final bool isBold;

  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; // this  gives us the height and the width of the screen
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            color: color,
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            )),
      ),
    );
  }
}
