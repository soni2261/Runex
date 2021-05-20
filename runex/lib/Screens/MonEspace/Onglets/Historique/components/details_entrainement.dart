import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/constants.dart';

//this class if for home screen
//lets continue

class DetailsEntrainement extends StatefulWidget {
  final Map map;
  const DetailsEntrainement(
    this.map, {
    Key key,
  }) : super(key: key);
  @override
  _DetailsEntrainementState createState() => _DetailsEntrainementState();
}

class _DetailsEntrainementState extends State<DetailsEntrainement> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger theme = Provider.of<ThemeChanger>(context);
    Map map = widget.map;

    double somme = 0;

    // for (int i = 0; i < map['vitesse'].length; i++) {
    //   somme = somme + map['vitesse'][i];
    // }
    // String vitesseMoyenne = '0';
    // if (map['vitesse'].length != 0)
    //   vitesseMoyenne = (somme / map['vitesse'].length).toStringAsFixed(1);

    String distance = (map['distance']).toStringAsFixed(2);

    Color couleurDeCard =
        theme.isDark() ? Color.fromRGBO(65, 55, 85, 1) : Colors.white;

    Color couleurDeShadow =
        theme.isDark() ? Color.fromRGBO(25, 20, 35, 1) : Colors.grey;

    String sport;

    if (map['sport'] == 'course')
      sport = 'Course';
    else if (map['sport'] == 'velo')
      sport = 'Vélo';
    else
      sport = 'Marche';

    String temps = '', uniteTemps = '';
    if ((map['duree'] / 60000) > 60) {
      int tempsEnMilliseconds = map['duree'];
      temps = '${(tempsEnMilliseconds / 3600000).toStringAsFixed(0)} : ';
      tempsEnMilliseconds = tempsEnMilliseconds % 3600000;
      temps += '${(tempsEnMilliseconds / 60000).toStringAsFixed(0)}';
      uniteTemps = 'heures : minutes';
    } else {
      temps = '${(map["duree"] / 60000).toStringAsFixed(0)}';
      uniteTemps = 'minutes';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(map['name']),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date et Temps"),
                Text(
                  map['name'],
                  // "February 07, 2021",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 10, 5),
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: couleurDeShadow.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    color: couleurDeCard,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(0, 87, 231, 1),
                        ),
                        child: Icon(
                          Icons.eco,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sport",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        sport,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: couleurDeShadow.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    color: couleurDeCard,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(4, 132, 68, 1),
                        ),
                        child: Icon(
                          Icons.timer_sharp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Temps",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        temps,
                        // (map['duree'] / 1000).toStringAsFixed(0),
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        uniteTemps,
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: couleurDeShadow.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    color: couleurDeCard,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Icon(
                          Icons.local_fire_department_sharp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Distance",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        distance,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Km",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 10, 0),
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: couleurDeShadow.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    color: couleurDeCard,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(252, 186, 3, 1),
                        ),
                        child: Icon(
                          Icons.speed_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Vitesse moyenne",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        map['vitesse'].toStringAsFixed(1),
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "m/s",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
