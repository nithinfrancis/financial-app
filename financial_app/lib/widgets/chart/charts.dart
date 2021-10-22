import 'package:financial_app/utils/app_colors.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

import 'bezier_chart.dart';

class CustomChart extends StatefulWidget {
  @override
  _CustomChartState createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    fromDate = DateTime(2019, 01, 1);
    toDate = DateTime(2019, 12, 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("500",style: TextStyle(color: AppColors.greyColor),),
                      Text("250",style: TextStyle(color: AppColors.greyColor),),
                      Text("0",style: TextStyle(color: AppColors.greyColor),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: BezierChart(
              fromDate: fromDate,
              bezierChartScale: BezierChartScale.MONTHLY,
              toDate: toDate,
              onIndicatorVisible: (val) {
              },
              onDateTimeSelected: (datetime) {
                print("selected datetime: $datetime");
              },
              selectedDate: toDate,
              //this is optional
              footerDateTimeBuilder: (DateTime value, BezierChartScale? scaleType) {
                final newFormat = intl.DateFormat('MMM');
                return newFormat.format(value).toUpperCase();
              },
              xAxisCustomValues: [200],
              bubbleLabelDateTimeBuilder: (DateTime value, BezierChartScale? scaleType) {
                final newFormat = intl.DateFormat('MMM');
                return "${newFormat.format(value)}\n";
              },
              series: [
                BezierLine(
                  lineColor: Colors.blue,
                  // label: "Duty",
                  onMissingValue: (dateTime) {
                    return 312.5;
                  },
                  lineStrokeWidth: 1.5,
                  data: <DataPoint<DateTime>>[
                    DataPoint<DateTime>(
                      value: 200,
                      xAxis: DateTime(2019, 1, 3),
                    ),
                    DataPoint<DateTime>(value: 489, xAxis: DateTime(2019, 2, 5)),
                    DataPoint<DateTime>(value: 300.5, xAxis: DateTime(2019, 5, 4)),
                    DataPoint<DateTime>(value: 489, xAxis: DateTime(2019, 6, 5)),
                    DataPoint<DateTime>(value: 105, xAxis: DateTime(2019, 9, 6)),
                    DataPoint<DateTime>(value: 70, xAxis: DateTime(2019, 11, 7)),
                  ],
                ),
              ],
              config: BezierChartConfig(
                showDataPoints: false,
                updatePositionOnTap: true,
                bubbleIndicatorValueFormat: intl.NumberFormat("###,##0.00", "en_US"),
                verticalIndicatorStrokeWidth: 1.0,
                verticalIndicatorColor: Colors.black,
                showVerticalIndicator: false,
                verticalIndicatorFixedPosition: false,
                backgroundColor: Colors.white,
                xLinesColor: Colors.blue,
                footerHeight: 20.0,
                bubbleIndicatorColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
