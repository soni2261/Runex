import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map map;
  const EventCard(
    this.map, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.people),
                SizedBox(
                  width: 10,
                ),
                Text(
                  map['name'],
                  style: TextStyle(color: Colors.grey[850], fontSize: 22),
                ),
              ]),
              Text(
                map['isFinished'] ? "Termine" : "En cours",
                style: TextStyle(
                    color: map['isFinished']
                        ? Colors.grey[600]
                        : Colors.green[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}