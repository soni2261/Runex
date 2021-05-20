import 'package:flutter/material.dart';
import 'package:runex/Screens/MonEspace/Onglets/Parametres/Parametres.dart';
import 'package:runex/Screens/MonEspace/Onglets/profile_page/profile_screen.dart';
import 'Onglets/Statistiques/home_page.dart';
import 'Onglets/Objectifs/objectifs.dart';
import 'Onglets/Historique/historique.dart';
import 'package:runex/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/theme.dart';

import 'Onglets/tab_indicator.dart';

class Profil extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          elevation: 0,
          bottom: TabBar(
            indicator: CircleTabIndicator(color: Colors.white, radius: 3),
            tabs: [
              Tab(icon: Icon(Icons.equalizer_rounded)),
              Tab(icon: Icon(Icons.pie_chart)),
              Tab(icon: Icon(Icons.history)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          title: Text('Profil'),
          centerTitle: true,
          // backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Parametres()),
                  );
                })
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            Objectifs(),
            Historique(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
