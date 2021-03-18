import 'package:flutter/material.dart';

class SoloRunCard extends StatelessWidget {
  final Map map;
  const SoloRunCard(
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
                Icon(
                  Icons.person,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  map['name'],
                  style: TextStyle(color: Colors.grey[850], fontSize: 22),
                ),
              ]),
              Text(
                "En cours",
                style: TextStyle(
                    color: Colors.green[700],
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
