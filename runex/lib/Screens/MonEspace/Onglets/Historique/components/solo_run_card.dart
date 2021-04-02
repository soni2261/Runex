import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/theme.dart';

class SoloRunCard extends StatelessWidget {
  final Map map;
  const SoloRunCard(
    this.map, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    Color subTextColor = theme.isDark() ? Colors.grey[400] : Colors.grey[600];
    SvgPicture pic;
    if (map['sport'] == 'run') {
      pic = SvgPicture.asset(
        "assets/icons/run_icon_2.svg",
        height: 100,
      );
    } else if (map['sport'] == 'walk') {
      pic = SvgPicture.asset(
        "assets/icons/walk_icon.svg",
        height: 100,
      );
    } else {
      pic = SvgPicture.asset(
        "assets/icons/velo_icon.svg",
        height: 100,
      );
    }

    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(children: <Widget>[
                pic,
                SizedBox(
                  width: 20,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    map['name'],
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Solo Workout",
                    style: TextStyle(
                        color: subTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ]),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
