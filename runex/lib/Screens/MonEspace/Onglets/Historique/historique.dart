import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/Screens/MonEspace/Onglets/Historique/components/entrainement_card.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';

class Historique extends StatefulWidget {
  Historique({Key key}) : super(key: key);

  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  Widget idToCard(map) {
    return EntrainementCard(map);
  }

  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    List listeMap = [];
    // [
    //   {
    //     'id': '123456',
    //     'name': 'First Workout',
    //     'isEvent': true,
    //     'isFinished': false,
    //     'sport': 'run'
    //   },
    //   {
    //     'id': '654321',
    //     'name': 'Second Workout',
    //     'isEvent': false,
    //     'sport': 'walk'
    //   },
    //   {
    //     'id': 'aliisthebest',
    //     'name': 'Third Workout',
    //     'isEvent': true,
    //     'isFinished': true,
    //     'sport': 'cycling'
    //   },
    // ];

    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            utilisateur = snapshot.data;
            listeMap = utilisateur.historique;
          } else {
            return Loading();
          }
          if (listeMap.isEmpty) {
            return Center(
              child: Text(
                "Pas d'entrainements à afficher!",
                style: TextStyle(fontSize: 22, color: Colors.grey[600]),
              ),
            );
          }
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: listeMap
                    .map((map) => idToCard(map))
                    .toList()
                    .reversed
                    .toList(),
              ),
            ),
          );
        });
  }
}
