import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/Screens/MonEspace/Onglets/Statistiques/components/diagramme.dart';
import 'package:runex/Screens/MonEspace/Onglets/Statistiques/stats_complet.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/constants.dart';
import 'package:runex/models/user.dart';
import 'package:runex/components/rounded_text_button.dart';
import 'package:runex/services/database.dart';

class PieChartPage extends StatefulWidget {
  final String typeStats;
  PieChartPage(this.typeStats);
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          utilisateur = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Statistiques de distance',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Diagramme(
                        typeStats: 'statsDistance',
                        utilisateur: utilisateur,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StatsComplet(
                                      utilisateur: utilisateur,
                                      typeStats: 'statsDistance',
                                    )),
                          );
                        },
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        text: 'VOIR LES STATS COMPLET',
                        isBold: true,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Statistiques de temps',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Diagramme(
                        typeStats: 'statsTemps',
                        utilisateur: utilisateur,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StatsComplet(
                                      utilisateur: utilisateur,
                                      typeStats: 'statsTemps',
                                    )),
                          );
                        },
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        text: 'VOIR LES STATS COMPLET',
                        isBold: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

//// import 'package:fl_chart/fl_chart.dart';
// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// import 'package:bezier_chart/bezier_chart.dart';
// import 'components/progresCard.dart';
// import 'widget/indicators_widget.dart';
// import 'widget/pie_chart_sections.dart';

// class PieChartPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => PieChartPageState();
// }

// final date0 = DateTime.now().subtract(Duration(days: 1));
// final date1 = DateTime.now().subtract(Duration(days: 2));
// final date2 = DateTime.now().subtract(Duration(days: 3));
// final date3 = DateTime.now().subtract(Duration(days: 4));
// final date4 = DateTime.now().subtract(Duration(days: 5));
// final date5 = DateTime.now().subtract(Duration(days: 6));
// final date6 = DateTime.now().subtract(Duration(days: 7));
// final fromDate = DateTime(2021, 05, 1);
// final toDate = DateTime.now();

// class PieChartPageState extends State {
//   int touchedIndex;

//   @override
//   Widget build(BuildContext context) => Card(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//                 child: ListView(
//               shrinkWrap: true,
//               padding: const EdgeInsets.all(20.0),
//               children: <Widget>[
//                 LiteRollingSwitch(
//                   value: true,
//                   textOn: '%',
//                   textOff: 'km',
//                   colorOn: Colors.greenAccent[700],
//                   colorOff: Colors.redAccent[700],
//                   iconOn: Icons.ad_units,
//                   iconOff: Icons.ad_units,
//                   textSize: 16.0,
//                   onChanged: (bool state) {
//                     //Conversion de pourcentage en untié de distance en cliquant sur l'interupteur
//                     print('Current State of SWITCH IS: $state');
//                   },
//                 ),
//                 Text(
//                   "Progression des objectifs",
//                   textAlign: TextAlign.left,
//                   textScaleFactor: 2,
//                 ),
//                 PieChart(
//                   //Diagramme indiquant la progression dans les objectifs
//                   PieChartData(
//                     pieTouchData: PieTouchData(
//                       touchCallback: (pieTouchResponse) {
//                         setState(() {
//                           if (pieTouchResponse.touchInput is FlLongPressEnd ||
//                               pieTouchResponse.touchInput is FlPanEnd) {
//                             touchedIndex = -1;
//                           } else {
//                             touchedIndex = pieTouchResponse.touchedSectionIndex;
//                           }
//                         });
//                       },
//                     ),
//                     borderData: FlBorderData(show: false),
//                     sectionsSpace: 0,
//                     centerSpaceRadius: 40,
//                     sections: getSections(touchedIndex),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: IndicatorsWidget(),
//                 ),
//                 Text(
//                   "Activité Mensuelle",
//                   textAlign: TextAlign.left,
//                   textScaleFactor: 2,
//                 ),
//                 Center(
//                   // Graphique indiquant l'activité totale effectué sur le mois.
//                   child: ProgresCard(
//                     color: Color.fromRGBO(253, 90, 90, 1),
//                     data: [
//                       //durant le dernier mois.
//                       DataPoint<DateTime>(value: 10, xAxis: date1),
//                       DataPoint<DateTime>(value: 50, xAxis: date2),
//                       DataPoint<DateTime>(value: 0, xAxis: date3),
//                       DataPoint<DateTime>(value: 60, xAxis: date4),
//                       DataPoint<DateTime>(value: 60, xAxis: date5),
//                       DataPoint<DateTime>(value: 60, xAxis: date6),
//                     ] as List<DataPoint<dynamic>>,
//                     fromDate: fromDate,
//                     toDate: toDate,
//                   ),
//                 ),
//                 Text(
//                   "Course",
//                   textAlign: TextAlign.left,
//                   textScaleFactor: 2,
//                 ),
//                 Center(
//                   child: Card(
//                     //Graphique pour l'activit course
//                     elevation: 12,
//                     clipBehavior: Clip.hardEdge,
//                     child: Container(
//                       height: MediaQuery.of(context).size.height / 2,
//                       width: MediaQuery.of(context).size.width,
//                       child: BezierChart(
//                         fromDate: fromDate,
//                         bezierChartScale: BezierChartScale.WEEKLY,
//                         toDate: toDate,
//                         selectedDate: toDate,
//                         series: [
//                           BezierLine(
//                             label: "km",
//                             onMissingValue: (dateTime) {
//                               if (dateTime.day.isEven) {
//                                 return 0;
//                               }
//                               return 0;
//                             },
//                             data: [
//                               //durant les 7 derniers jours
//                               DataPoint<DateTime>(value: 10, xAxis: date1),
//                               DataPoint<DateTime>(value: 50, xAxis: date2),
//                               DataPoint<DateTime>(value: 0, xAxis: date3),
//                               DataPoint<DateTime>(value: 60, xAxis: date4),
//                               DataPoint<DateTime>(value: 60, xAxis: date5),
//                               DataPoint<DateTime>(value: 60, xAxis: date6),
//                             ],
//                           ),
//                         ],
//                         config: BezierChartConfig(
//                           verticalIndicatorStrokeWidth: 3.0,
//                           verticalIndicatorColor: Colors.black26,
//                           showVerticalIndicator: true,
//                           verticalIndicatorFixedPosition: false,
//                           backgroundColor: Colors.orange,
//                           footerHeight: 30.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "Marche",
//                   textAlign: TextAlign.left,
//                   textScaleFactor: 2,
//                 ),
//                 Center(
//                   //Graphique de la marche des 7 derniers jours
//                   child: Card(
//                     elevation: 12,
//                     clipBehavior: Clip.hardEdge,
//                     child: Container(
//                       height: MediaQuery.of(context).size.height / 2,
//                       width: MediaQuery.of(context).size.width,
//                       child: BezierChart(
//                         fromDate: fromDate,
//                         bezierChartScale: BezierChartScale.WEEKLY,
//                         toDate: toDate,
//                         selectedDate: toDate,
//                         series: [
//                           BezierLine(
//                             label: "km",
//                             onMissingValue: (dateTime) {
//                               if (dateTime.day.isEven) {
//                                 return 0;
//                               }
//                               return 0;
//                             },
//                             data: [
//                               DataPoint<DateTime>(value: 10, xAxis: date1),
//                               DataPoint<DateTime>(value: 50, xAxis: date2),
//                               DataPoint<DateTime>(value: 0, xAxis: date3),
//                               DataPoint<DateTime>(value: 60, xAxis: date4),
//                               DataPoint<DateTime>(value: 60, xAxis: date5),
//                               DataPoint<DateTime>(value: 60, xAxis: date6),
//                             ],
//                           ),
//                         ],
//                         config: BezierChartConfig(
//                           verticalIndicatorStrokeWidth: 3.0,
//                           verticalIndicatorColor: Colors.black26,
//                           showVerticalIndicator: true,
//                           verticalIndicatorFixedPosition: false,
//                           backgroundColor: Colors.green,
//                           footerHeight: 30.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "Vélo",
//                   textAlign: TextAlign.left,
//                   textScaleFactor: 2,
//                 ),
//                 Center(
//                   // Graphique pour l'activité vélo des 7 derniers jours.
//                   child: Card(
//                     elevation: 12,
//                     clipBehavior: Clip.hardEdge,
//                     child: Container(
//                       height: MediaQuery.of(context).size.height / 2,
//                       width: MediaQuery.of(context).size.width,
//                       child: BezierChart(
//                         fromDate: fromDate,
//                         bezierChartScale: BezierChartScale.WEEKLY,
//                         toDate: toDate,
//                         selectedDate: toDate,
//                         series: [
//                           BezierLine(
//                             label: "km",
//                             onMissingValue: (dateTime) {
//                               if (dateTime.day.isEven) {
//                                 return 0;
//                               }
//                               return 0;
//                             },
//                             data: [
//                               DataPoint<DateTime>(value: 10, xAxis: date1),
//                               DataPoint<DateTime>(value: 50, xAxis: date2),
//                               DataPoint<DateTime>(value: 0, xAxis: date3),
//                               DataPoint<DateTime>(value: 60, xAxis: date4),
//                             ],
//                           ),
//                         ],
//                         config: BezierChartConfig(
//                           verticalIndicatorStrokeWidth: 3.0,
//                           verticalIndicatorColor: Colors.black26,
//                           showVerticalIndicator: true,
//                           verticalIndicatorFixedPosition: false,
//                           backgroundColor: Colors.blue,
//                           footerHeight: 30.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//             ),
//           ],
//         ),
//       );
// }
