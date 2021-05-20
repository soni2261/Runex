import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/Screens/MonEspace/Onglets/Statistiques/components/diagramme.dart';
import 'package:runex/Screens/MonEspace/Onglets/Statistiques/components/progresCard.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/models/user.dart';

Utilisateur utilisateur;
String typeStats;

class StatsComplet extends StatefulWidget {
  @required
  final Utilisateur utilisateur;
  @required
  final String typeStats;

  StatsComplet({
    Key key,
    this.utilisateur,
    this.typeStats,
  }) : super(key: key);
  @override
  _StatsCompletState createState() => _StatsCompletState();
}

class _StatsCompletState extends State<StatsComplet> {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    utilisateur = widget.utilisateur;
    typeStats = widget.typeStats;

    List totales = [
      totaleSport("marche"),
      totaleSport("course"),
      totaleSport("velo"),
    ];
    List couleurs = [
      theme.isDark()
          ? Color.fromRGBO(255, 90, 90, 1)
          : Color.fromRGBO(250, 65, 65, 1),
      theme.isDark()
          ? Color.fromRGBO(87, 163, 184, 1)
          : Color.fromRGBO(75, 140, 155, 1),
      theme.isDark()
          ? Color.fromRGBO(19, 211, 142, 1)
          : Color.fromRGBO(15, 200, 120, 1),
    ];

    var date0 = DateTime.fromMicrosecondsSinceEpoch(
        utilisateur.statistiques['debut'].microsecondsSinceEpoch);
    var date1 = date0.add(Duration(days: 1));
    var date2 = date0.add(Duration(days: 2));
    var date3 = date0.add(Duration(days: 3));
    var date4 = date0.add(Duration(days: 4));
    var date5 = date0.add(Duration(days: 5));
    var date6 = date0.add(Duration(days: 6));

    List dataMarche =
        utilisateur.statistiques[typeStats]['marche']['statsSemaine'];
    List<DataPoint<dynamic>> dataMarcheDataPoint = [
      DataPoint<DateTime>(value: dataMarche[0].toDouble(), xAxis: date0),
      DataPoint<DateTime>(value: dataMarche[1].toDouble(), xAxis: date1),
      DataPoint<DateTime>(value: dataMarche[2].toDouble(), xAxis: date2),
      DataPoint<DateTime>(value: dataMarche[3].toDouble(), xAxis: date3),
      DataPoint<DateTime>(value: dataMarche[4].toDouble(), xAxis: date4),
      DataPoint<DateTime>(value: dataMarche[5].toDouble(), xAxis: date5),
      DataPoint<DateTime>(value: dataMarche[6].toDouble(), xAxis: date6),
    ];

    List dataCourse =
        utilisateur.statistiques[typeStats]['course']['statsSemaine'];
    List<DataPoint<dynamic>> dataCourseDataPoint = [
      DataPoint<DateTime>(value: dataCourse[0].toDouble(), xAxis: date0),
      DataPoint<DateTime>(value: dataCourse[1].toDouble(), xAxis: date1),
      DataPoint<DateTime>(value: dataCourse[2].toDouble(), xAxis: date2),
      DataPoint<DateTime>(value: dataCourse[3].toDouble(), xAxis: date3),
      DataPoint<DateTime>(value: dataCourse[4].toDouble(), xAxis: date4),
      DataPoint<DateTime>(value: dataCourse[5].toDouble(), xAxis: date5),
      DataPoint<DateTime>(value: dataCourse[6].toDouble(), xAxis: date6),
    ];

    List dataVelo = utilisateur.statistiques[typeStats]['velo']['statsSemaine'];
    List<DataPoint<dynamic>> dataVeloDataPoint = [
      DataPoint<DateTime>(value: dataVelo[0].toDouble(), xAxis: date0),
      DataPoint<DateTime>(value: dataVelo[1].toDouble(), xAxis: date1),
      DataPoint<DateTime>(value: dataVelo[2].toDouble(), xAxis: date2),
      DataPoint<DateTime>(value: dataVelo[3].toDouble(), xAxis: date3),
      DataPoint<DateTime>(value: dataVelo[4].toDouble(), xAxis: date4),
      DataPoint<DateTime>(value: dataVelo[5].toDouble(), xAxis: date5),
      DataPoint<DateTime>(value: dataVelo[6].toDouble(), xAxis: date6),
    ];
    // int totaleCourse = totaleSport("course"),
    //     totaleMarche = totaleSport("marche"),
    //     totaleVelo = totaleSport("velo");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('STATS COMPLET'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Diagramme(typeStats: typeStats, utilisateur: utilisateur),
            SizedBox(
              height: 35,
            ),
            Text(
              'Marche',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            totales[0] == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Vous avez pas marché cette semaine!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: ProgresCard(
                      fromDate: DateTime.fromMicrosecondsSinceEpoch(utilisateur
                          .statistiques['debut'].microsecondsSinceEpoch),
                      toDate: DateTime.fromMicrosecondsSinceEpoch(utilisateur
                          .statistiques['end'].microsecondsSinceEpoch),
                      data: dataMarcheDataPoint,
                      color: couleurs[0],
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Course',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            totales[1] == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Vous avez pas couru cette semaine!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: ProgresCard(
                      fromDate: DateTime.fromMicrosecondsSinceEpoch(utilisateur
                          .statistiques['debut'].microsecondsSinceEpoch),
                      toDate: DateTime.fromMicrosecondsSinceEpoch(utilisateur
                          .statistiques['end'].microsecondsSinceEpoch),
                      data: dataCourseDataPoint,
                      color: couleurs[1],
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Vélo',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            totales[2] == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Vous avez pas fait du vélo cette semaine!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: ProgresCard(
                      fromDate: DateTime.fromMicrosecondsSinceEpoch(utilisateur
                          .statistiques['debut'].microsecondsSinceEpoch),
                      toDate: DateTime.fromMicrosecondsSinceEpoch(utilisateur
                          .statistiques['end'].microsecondsSinceEpoch),
                      data: dataVeloDataPoint,
                      color: couleurs[2],
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  int totaleSport(typeSport) {
    List list = utilisateur.statistiques[typeStats][typeSport]['statsSemaine'];
    int somme = 0;
    for (int i = 0; i < list.length; i++) {
      somme += list[i];
    }

    return somme;
  }
}
