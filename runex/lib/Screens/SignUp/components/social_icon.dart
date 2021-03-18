import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIcon extends StatelessWidget {
  final String imageSrc;
  final Function press;
  const SocialIcon({
    Key key,
    @required this.imageSrc,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(border: Border.all(), shape: BoxShape.circle),
        child: SvgPicture.asset(
          imageSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
