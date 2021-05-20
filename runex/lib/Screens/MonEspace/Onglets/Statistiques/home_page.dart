import 'package:flutter/material.dart';
import 'package:runex/Screens/MonEspace/Onglets/Statistiques/pie_chart_page.dart';
import 'package:runex/services/database.dart';
import 'package:runex/models/user.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/loading.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            utilisateur = snapshot.data;
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await DatabaseService(uid: utilisateur.uid)
                  .checkStatsWeek(utilisateur);
            });
            return Scaffold(
              // appBar: AppBar(title: Text(MyApp.title), centerTitle: true),
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: PieChartPage(),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
