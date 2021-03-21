import 'package:flutter/material.dart';
import 'package:runex/Screens/MonEspace/Onglets/Parametres/Parametres.dart';
import 'package:runex/constants.dart';
import 'Onglets/Statistiques/statistiques.dart';
import 'Onglets/Objectifs/objectifs.dart';
import 'Onglets/Historique/historique.dart';
import 'package:runex/services/auth.dart';

class Profil extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
            backgroundColor: kPrimaryColor,
            actions: [
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () async {
                    // await _auth.signOutGoogle();
                    // await _auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Parametres()),
                    );
                  })
            ],
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
