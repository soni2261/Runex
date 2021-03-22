import 'package:flutter/material.dart';
import 'package:runex/Screens/MonEspace/Onglets/Historique/components/event_card.dart';
import 'package:runex/Screens/MonEspace/Onglets/Historique/components/solo_run_card.dart';

class Historique extends StatefulWidget {
  Historique({Key key}) : super(key: key);

  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  Widget idToCard(map) {
    if (map['isEvent']) {
      return EventCard(map);
    } else {
      return SoloRunCard(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map> listeMap = [
      {
        'id': '123456',
        'name': 'First Workout',
        'isEvent': true,
        'isFinished': false,
        'sport': 'run'
      },
      {
        'id': '654321',
        'name': 'Second Workout',
        'isEvent': false,
        'sport': 'walk'
      },
      {
        'id': 'aliisthebest',
        'name': 'Third Workout',
        'isEvent': true,
        'isFinished': true,
        'sport': 'cycling'
      },
    ];

    return SingleChildScrollView(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: listeMap.map((id) => idToCard(id)).toList(),
          ),
        ),
      ),
    );
  }
}
