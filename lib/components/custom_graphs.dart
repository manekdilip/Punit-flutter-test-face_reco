import 'dart:math';

import 'package:face_net_authentication/constants/colors.dart';
import 'package:face_net_authentication/constants/enums.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

customGraphs(
    {required Color graphColor,
    required bool showLeftTile,
    required double maxValue,
    required GraphInterval graphInterval}) {
  List<FlSpot> graphData = [];

  List<String> xLabels = [];

  switch (graphInterval) {
    case GraphInterval.Hour:
      for (int i = 0; i < DateTime.now().hour + 1; i++) {
        final dateTime = DateTime.now().subtract(Duration(hours: i));
        xLabels.add(DateFormat.jm().format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
    case GraphInterval.Day:
      for (int i = 0; i < DateTime.now().hour + 1; i++) {
        final dateTime = DateTime.now().subtract(Duration(hours: i));
        xLabels.add(DateFormat.jm().format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
    case GraphInterval.Week:
      for (int i = 0; i < 7; i++) {
        final dateTime = DateTime.now().subtract(Duration(days: i));
        xLabels.add(DateFormat("dd MMM yy").format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
    case GraphInterval.TwoWeek:
      for (int i = 0; i < 14; i++) {
        final dateTime = DateTime.now().subtract(Duration(days: i));
        xLabels.add(DateFormat("dd MMM yy").format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
    case GraphInterval.OneMonth:
      for (int i = 0; i < 30; i++) {
        final dateTime = DateTime.now().subtract(Duration(days: i));
        xLabels.add(DateFormat("dd MMM yy").format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
    case GraphInterval.ThreeMonth:
      for (int i = 0; i < 3; i++) {
        final dateTime = DateTime.now().subtract(Duration(days: i * 30));
        xLabels.add(DateFormat("dd MMM yy").format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
    case GraphInterval.YTD:
      for (int i = 0; i < DateTime.now().month; i++) {
        final dateTime = DateTime.now().subtract(Duration(days: i * 30));
        xLabels.add(DateFormat("dd MMM yy").format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
    case GraphInterval.OneYear:
      for (int i = 0; i < 12; i++) {
        final dateTime = DateTime.now().subtract(Duration(days: i * 30));
        xLabels.add(DateFormat("dd MMM yy").format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
    case GraphInterval.FiveYear:
      for (int i = 0; i < 5; i++) {
        final dateTime = DateTime.now().subtract(Duration(days: i * 365));
        xLabels.add(DateFormat("yyyy").format(dateTime));
        Random random = new Random();
        double randomNumber =
            maxValue - ((maxValue / (i == 0 ? 1 : i)) * random.nextDouble());
        graphData.add(FlSpot(i.toDouble(), randomNumber));
      }
      break;
  }

  return LineChart(LineChartData(
    minY: 0,
    maxY: maxValue + 100,
    lineTouchData: LineTouchData(
      enabled: showLeftTile,
      touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: graphColor,
          getTooltipItems: (data) {
            List<LineTooltipItem> toolTips = [];
            for (int i = 0; i < data.length; i++) {
              String yData = "\$" + data[i].y.toStringAsFixed(2),
                  xData = xLabels[i];
              toolTips.add(LineTooltipItem(
                yData + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ));
            }
            return toolTips;
          }),
    ),
    gridData: FlGridData(
      show: showLeftTile,
      drawHorizontalLine: true,
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: showLeftTile,
          getTextStyles: (context, _) =>
              TextStyle(color: appGrey, fontSize: 12),
          getTitles: (value) {
            if (value < 1000) {
              return value.toStringAsFixed(1);
            } else if (value < 1000000) {
              return (value / 1000).toStringAsFixed(1) + " k";
            } else if (value < 1000000000) {
              return (value / 1000000).toStringAsFixed(1) + " m";
            } else {
              return (value / 1000000000).toStringAsFixed(1) + " b";
            }
          },
          reservedSize: 40,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false)),
    borderData: FlBorderData(
        show: showLeftTile,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.5)),
          left: BorderSide(width: 1, color: Colors.grey.withOpacity(0.5)),
        )),
    lineBarsData: [
      LineChartBarData(
        spots: graphData,
        preventCurveOverShooting: true,
        colors: [graphColor],
        barWidth: 2,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
            show: true,
            gradientFrom: Offset(0, -1),
            gradientTo: Offset(0, 0),
            colors: [
              graphColor.withOpacity(0.3),
              graphColor.withOpacity(0.07)
            ]),
      ),
    ],
  ));
}
