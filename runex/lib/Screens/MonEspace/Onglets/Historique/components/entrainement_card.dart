import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/theme.dart';
import 'details_entrainement.dart';

class EntrainementCard extends StatelessWidget {
  final Map map;
  const EntrainementCard(
    this.map, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    SvgPicture pic;
    if (map['sport'] == 'course') {
      pic = SvgPicture.asset(
        "assets/icons/run_icon_2.svg",
        height: 100,
      );
    } else if (map['sport'] == 'marche') {
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
    int duree = map['duree'];

    String temps = '';

    temps = (duree / 3600000).toStringAsFixed(1);
    // if ((duree / 3600000).floor() > 0) {
    //   temps += '${(duree / 3600000).floor()}H';
    //   duree = duree % 3600000;
    // }
    // if ((duree / 60000).floor() > 0) {
    //   temps += ', ${(duree / 60000).floor()} minutes';
    //   duree = duree % 60000;
    // }
    // if ((duree / 1000.floor()) > 0) {
    //   temps += '${(duree / 1000).floor()} secondes';
    //   duree = duree % 1000;
    // }

    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsEntrainement(map)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(children: <Widget>[
                pic,
                //icon,
                SizedBox(
                  width: 30,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    map['name'],
                    style: TextStyle(
                        /*color: Colors.grey[850],*/ fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Distance: ${map["distance"].toStringAsFixed(2)} km',
                    style: TextStyle(
                        fontSize: 18,
                        color: theme.isDark()
                            ? Colors.grey[400]
                            : Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      'Durée: $temps heures',
                      style: TextStyle(
                          fontSize: 17,
                          color: theme.isDark()
                              ? Colors.indigoAccent[100]
                              : Colors.indigoAccent[700],
                          fontWeight: FontWeight.w500),
                    ),
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
