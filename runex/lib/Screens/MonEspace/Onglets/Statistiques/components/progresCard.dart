import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

class ProgresCard extends StatelessWidget {
  String typeStats;
  DateTime fromDate;
  DateTime toDate;
  List data;
  Color color;
  ProgresCard({
    this.typeStats,
    this.color,
    this.toDate,
    this.data,
    this.fromDate,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: color,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: typeStats == 'statsDistance' ? 'km' : "ms",
              onMissingValue: (dateTime) {
                if (dateTime.day.isEven) {
                  return 0;
                }
                return 0;
              },
              data: data,
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundColor: color,
            footerHeight: 30.0,
          ),
        ),
      ),
    );
  }
}
