import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/models/user.dart';

class Diagramme extends StatefulWidget {
  final String typeStats;
  final Utilisateur utilisateur;
  Diagramme({
    @required this.typeStats,
    @required this.utilisateur,
  });
  @override
  _DiagrammeState createState() => _DiagrammeState();
}

class _DiagrammeState extends State<Diagramme> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = widget.utilisateur;
    final theme = Provider.of<ThemeChanger>(context);

    if (widget.typeStats == "statsDistance" &&
        !utilisateur.statistiques['hasStatistiquesDistance']) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "Aucun statistiques de distance à afficher!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, color: Colors.grey),
        ),
      );
    } else if (widget.typeStats == "statsTemps" &&
        !utilisateur.statistiques['hasStatistiquesTemps']) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "Aucun statistiques de temps à afficher!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, color: Colors.grey),
        ),
      );
    }

    Map data = getData(widget.typeStats, utilisateur);

    if (widget.typeStats == "statsTemps" && data == null) {
      return Text(
        "Pas de statistique de temps à afficher!",
        style: TextStyle(fontSize: 22, color: Colors.grey),
      );
    } else if (widget.typeStats == "statsDistance" && data == null) {
      return Text(
        "Pas de statistique de distance à afficher!",
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
                if (desiredTouch && pieTouchResponse.touchedSection != null) {
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
        String title = widget.typeStats == "statsTemps"
            ? "${(data["marche"] ~/ 3600000)}H ${((data["marche"] % 3600000) / 60000).toStringAsFixed(0)}M"
            : "${data["marche"].toStringAsFixed(1)} KM";

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
        String title = widget.typeStats == "statsTemps"
            ? "${(data["velo"] ~/ 3600000)}H ${((data["velo"] % 3600000) / 60000).toStringAsFixed(0)}M"
            : "${data["velo"].toStringAsFixed(1)} KM";
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
        String title = widget.typeStats == "statsTemps"
            ? "${(data["course"] ~/ 3600000)}H ${((data["course"] % 3600000) / 60000).toStringAsFixed(0)}M"
            : "${data["course"].toStringAsFixed(1)} KM";
        return PieChartSectionData(
          color: theme.isDark()
              ? Color.fromRGBO(87, 163, 184, 1)
              : Color.fromRGBO(75, 140, 155, 1),
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

  Map getData(String typeStats, Utilisateur utilisateur) {
    Map<String, num> data = Map();
    if (utilisateur.statistiques[typeStats]['velo']['totale'] != 0) {
      data['velo'] = utilisateur.statistiques[typeStats]['velo']['totale'];
    }
    if (utilisateur.statistiques[typeStats]['marche']['totale'] != 0) {
      data['marche'] = utilisateur.statistiques[typeStats]['marche']['totale'];
    }
    if (utilisateur.statistiques[typeStats]['course']['totale'] != 0) {
      data['course'] = utilisateur.statistiques[typeStats]['course']['totale'];
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
