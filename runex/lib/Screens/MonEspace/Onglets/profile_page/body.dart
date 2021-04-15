import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/rounded_text_button.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/constants.dart';
import 'package:runex/sizeconfig.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    final tabChanger = DefaultTabController.of(context);
    final theme = Provider.of<ThemeChanger>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: defaultSize * 24,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: defaultSize * 15,
                    color: theme.isDark()
                        ? Color.fromRGBO(40, 35, 55, 1)
                        : kPrimaryColor,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: defaultSize),
                        height: defaultSize * 14,
                        width: defaultSize * 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: defaultSize * 0.6,
                              color: theme.isDark()
                                  ? Color.fromRGBO(65, 55, 85, 1)
                                  : Colors.white),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/vangogh.png")),
                        ),
                      ),
                      Text(
                        "Van Gogh",
                        style: TextStyle(fontSize: defaultSize * 2.2),
                      ),
                      SizedBox(
                        height: defaultSize * 0.75,
                      ),
                      Text(
                        "vangogh@bdeb.qc.ca",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultSize * 4,
          ),
          RoundedButton(
            text: "STATS",
            color:
                theme.isDark() ? Color.fromRGBO(40, 35, 55, 1) : kPrimaryColor,
            press: () {
              tabChanger.animateTo(0);
            },
          ),
          SizedBox(
            height: defaultSize,
          ),
          RoundedButton(
            text: "OBJECTIVES",
            color:
                theme.isDark() ? Color.fromRGBO(40, 35, 55, 1) : kPrimaryColor,
            press: () {
              tabChanger.animateTo(1);
            },
          ),
          SizedBox(
            height: defaultSize,
          ),
          RoundedButton(
            text: "HISTORIQUE",
            color:
                theme.isDark() ? Color.fromRGBO(40, 35, 55, 1) : kPrimaryColor,
            press: () {
              tabChanger.animateTo(2);
            },
          ),
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
