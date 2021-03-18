import 'package:flutter/material.dart';
import 'package:runex/Screens/Profil/Onglets/Historique/components/event_card.dart';
import 'package:runex/Screens/Profil/Onglets/Historique/components/solo_run_card.dart';

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
        'isFinished': false
      },
      {
        'id': '654321',
        'name': 'Second Workout',
        'isEvent': false,
      },
      {
        'id': 'aliisthebest',
        'name': 'Third Workout',
        'isEvent': true,
        'isFinished': true
      },
    ];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: listeMap.map((id) => idToCard(id)).toList(),
        ),
      ),
    );
  }
}
