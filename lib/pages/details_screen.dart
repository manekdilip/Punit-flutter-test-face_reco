import 'package:face_net_authentication/components/custom_app_bar.dart';
import 'package:face_net_authentication/components/custom_graphs.dart';
import 'package:face_net_authentication/constants/colors.dart';
import 'package:face_net_authentication/constants/enums.dart';
import 'package:face_net_authentication/constants/icons_string.dart';
import 'package:face_net_authentication/constants/static_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final Color color;
  final double maxValue;

  const DetailsScreen(
      {Key? key,
      required this.name,
      required this.color,
      required this.maxValue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends State<DetailsScreen> {
  int graphInterval = 0;
  GraphInterval currentInterval = GraphInterval.Hour;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: detailsScreenAppBar(
          title: widget.name, context: context, color: widget.color),
      body: Container(
        height: size.height,
        width: size.width,
        color: widget.color.withOpacity(0.07),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$ " + widget.maxValue.toStringAsFixed(2),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text(
                              "- 2.53%",
                              style: TextStyle(
                                  color: appRed,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: appRed,
                              size: 45,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 25),
                        child: Text("Deposit",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StatefulBuilder(builder: (context, graphState) {
                return Container(
                  height: size.height * 0.43,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                          height: size.height * 0.35,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: customGraphs(
                              graphColor: widget.color,
                              showLeftTile: true,
                              maxValue: widget.maxValue,
                              graphInterval: currentInterval,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(graphIntervalLabels.length, (index) {
                          return InkWell(
                            onTap: () {
                              graphInterval = index;
                              switch (index) {
                                case 0:
                                  currentInterval = GraphInterval.Hour;
                                  break;
                                case 1:
                                  currentInterval = GraphInterval.Day;
                                  break;
                                case 2:
                                  currentInterval = GraphInterval.Week;
                                  break;
                                case 3:
                                  currentInterval = GraphInterval.TwoWeek;
                                  break;
                                case 4:
                                  currentInterval = GraphInterval.OneMonth;
                                  break;
                                case 5:
                                  currentInterval = GraphInterval.ThreeMonth;
                                  break;
                                case 6:
                                  currentInterval = GraphInterval.YTD;
                                  break;
                                case 7:
                                  currentInterval = GraphInterval.OneYear;
                                  break;
                                case 8:
                                  currentInterval = GraphInterval.FiveYear;
                                  break;
                              }
                              graphState(() {});
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: graphInterval == index
                                      ? widget.color.withOpacity(0.4)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 10),
                                  child: Text(graphIntervalLabels[index],
                                      style: TextStyle(
                                          color: graphInterval == index
                                              ? Colors.black
                                              : appGrey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600)),
                                )),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "History",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: widget.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 15),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("All",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                          size: 22,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Divider(),
                      Column(
                        children: List.generate(5, (index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                    decoration: BoxDecoration(
                                      color: appGrey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Image.asset(historyIcon),
                                    )),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Distribution",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "+0.000135",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat("yyyy-MM-dd hh:mm:ss")
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "Success",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
