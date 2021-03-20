import 'package:flutter/material.dart';
import 'package:runex/Screens/Welcome/welcome_screen.dart';
import 'package:runex/constants.dart';
import 'Onglets/Statistiques/statistiques.dart';
import 'Onglets/Objectifs/objectifs.dart';
import 'Onglets/Historique/historique.dart';
import 'package:runex/services/auth.dart';
//import 'package:runex/constants.dart';

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
                    await _auth.signOut();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                WelcomeScreen()));
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
