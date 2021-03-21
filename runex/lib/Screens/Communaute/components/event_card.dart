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
                SizedBox(
                  width: 80,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        'join',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )),
                  onPressed: () {},
                ),
                ),
                
              ]),
              SizedBox(
                height: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
