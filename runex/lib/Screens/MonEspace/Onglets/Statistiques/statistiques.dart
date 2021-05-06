import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';

class Statistiques extends StatefulWidget {
  Statistiques({Key key}) : super(key: key);

  @override
  _StatistiquesState createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
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
              if (this.mounted) setState(() {});
            });
            return Container(
              child: Text(
                utilisateur.statistiques['debut'].toString(),
                style: TextStyle(fontSize: 48.0),
              ),
            );
          } else
            return Loading();
        });
  }
}
