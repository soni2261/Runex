

import 'package:flutter/material.dart';
import 'Onglets/Statistiques/statistiques.dart';
import 'Onglets/Objectifs/objectifs.dart';
import 'Onglets/Historique/historique.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.equalizer_rounded)),
                Tab(icon: Icon(Icons.pie_chart)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
            title: Text('Profil'),
          ),
          body: TabBarView(
            children: <Widget>[
              Statistiques(),
              Objectifs(),
              Historique(),
            ],
          ),
        ),
      ),
    );
  }
}
