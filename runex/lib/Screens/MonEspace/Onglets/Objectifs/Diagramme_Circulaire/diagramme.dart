import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';

class Diagramme extends StatefulWidget {
  final String typeObjectif;

  const Diagramme({Key key, this.typeObjectif});

  @override
  _DiagrammeState createState() => _DiagrammeState();
}

class _DiagrammeState extends State<Diagramme> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    final theme = Provider.of<ThemeChanger>(context);

    return StreamBuilder<Utilisateur>(
      stream: DatabaseService(uid: utilisateur.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          utilisateur = snapshot.data;

          if (widget.typeObjectif == "objTemps" &&
              !utilisateur.objectifs['hasobjTemps']) {
            return Text(
              "Pas d'objectif de temps choisi!",
              style: TextStyle(fontSize: 22, color: Colors.grey),
            );
          } else if (widget.typeObjectif == "objDistance" &&
              !utilisateur.objectifs['hasobjDistance']) {
            return Text(
              "Pas d'objectif de distance choisi!",
              style: TextStyle(fontSize: 22, color: Colors.grey),
            );
          }

          Map data = getData(widget.typeObjectif, utilisateur);

          if (widget.typeObjectif == "objTemps" && data == null) {
            return Text(
              "Pas d'objectif de temps choisi!",
              style: TextStyle(fontSize: 22, color: Colors.grey),
            );
          } else if (widget.typeObjectif == "objDistance" && data == null) {
            return Text(
              "Pas d'objectif de distance choisi!",
              style: TextStyle(fontSize: 22, color: Colors.grey),
            );
          }

          return AspectRatio(
            aspectRatio: 3 / 2,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      final desiredTouch =
                          pieTouchResponse.touchInput is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                      if (desiredTouch &&
                          pieTouchResponse.touchedSection != null) {
                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                      } else {
                        touchedIndex = -1;
                      }
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections(data, theme),
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  List<PieChartSectionData> showingSections(Map data, ThemeChanger theme) {
    int dataLength = data.length;
    List keyList = data.keys.toList();

    return List.generate(dataLength, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 55 : 40;
      if (keyList.contains("marche")) {
        keyList.remove("marche");
        String title = widget.typeObjectif == "objTemps"
            ? "${data["marche"] ~/ 60}H ${data["marche"] % 60}M"
            : "${data["marche"]} KM";
        return PieChartSectionData(
          color: theme.isDark()
              ? Color.fromRGBO(255, 90, 90, 1)
              : Color.fromRGBO(250, 65, 65, 1),
          value: data["marche"].toDouble(),
          title: title,
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
          badgeWidget: _Badge(
            'assets/icons/walk_chart_icon.svg',
            size: widgetSize,
            borderColor: const Color(0xfff8b250),
          ),
          badgePositionPercentageOffset: 1.1,
        );
      } else if (keyList.contains("velo")) {
        keyList.remove("velo");
        String title = widget.typeObjectif == "objTemps"
            ? "${data["velo"] ~/ 60}H ${data["velo"] % 60}M"
            : "${data["velo"]} KM";
        return PieChartSectionData(
          color: theme.isDark()
              ? Color.fromRGBO(19, 211, 142, 1)
              : Color.fromRGBO(15, 200, 120, 1),
          value: data["velo"].toDouble(),
          title: title,
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
          badgeWidget: _Badge(
            'assets/icons/bike_chart_icon.svg',
            size: widgetSize,
            borderColor: const Color(0xff13d38e),
          ),
          badgePositionPercentageOffset: 1.1,
        );
      } else if (keyList.contains("course")) {
        keyList.remove("course");
        String title = widget.typeObjectif == "objTemps"
            ? "${data["course"] ~/ 60}H ${data["course"] % 60}M"
            : "${data["course"]} KM";
        return PieChartSectionData(
          color: theme.isDark()
              ? Color.fromRGBO(87, 163, 184, 1)
              : Color.fromRGBO(75, 140, 155, 1),
          // color: const Color.fromRGBO(87, 163, 184, 1),
          value: data["course"].toDouble(),
          title: title,
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
          badgeWidget: _Badge(
            'assets/icons/running_chart_icon.svg',
            size: widgetSize,
            borderColor: const Color(0xff845bef),
          ),
          badgePositionPercentageOffset: 1.1,
        );
      }
    });
  }

  Map getData(String typeObjectif, Utilisateur utilisateur) {
    Map<String, int> data = Map();
    if (utilisateur.objectifs[typeObjectif]['velo'] != 0) {
      data['velo'] = utilisateur.objectifs[typeObjectif]['velo'];
    }
    if (utilisateur.objectifs[typeObjectif]['marche'] != 0) {
      data['marche'] = utilisateur.objectifs[typeObjectif]['marche'];
    }
    if (utilisateur.objectifs[typeObjectif]['course'] != 0) {
      data['course'] = utilisateur.objectifs[typeObjectif]['course'];
    }

    if (data.isNotEmpty)
      return data;
    else
      return null;
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key key,
    @required this.size,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 0,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
