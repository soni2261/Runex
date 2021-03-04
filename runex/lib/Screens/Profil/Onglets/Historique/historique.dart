import 'package:flutter/material.dart';

class Historique extends StatefulWidget {
  Historique({Key key}) : super(key: key);

  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  Widget idToCard(id) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Evenement",
                style: TextStyle(color: Colors.grey[850], fontSize: 22),
              ),
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

  @override
  Widget build(BuildContext context) {
    List<String> listeID = ["123456", "654321", "AliIsTheBest"];

    return Container(
      child: Column(
        children: listeID.map((id) => idToCard(id)).toList(),
      ),
    );
  }
}
