import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map map;
  const EventCard(
    this.map, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon icon;
    if (map['sport'] == 'run') {
      icon = Icon(
        Icons.directions_run,
      );
    } else if (map['sport'] == 'walk') {
      icon = Icon(
        Icons.directions_walk,
      );
    } else {
      icon = Icon(
        Icons.directions_bike,
      );
    }
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(children: <Widget>[
                icon,
                SizedBox(
                  width: 10,
                ),
                Text(
                  map['name'],
                  style: TextStyle(color: Colors.grey[850], fontSize: 22),
                ),
              ]),
              SizedBox(
                height: 3,
              ),
              Row(children: <Widget>[
                Text(
                  "Événement • ",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  map['isFinished'] ? "Terminé" : "En cours",
                  style: TextStyle(
                      color: map['isFinished']
                          ? Colors.grey[600]
                          : Colors.green[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
